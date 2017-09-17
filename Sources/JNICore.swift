//
//  JavaJNI.swift
//  SwiftJava
//
//  Created by John Holdsworth on 13/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//
//  Basic JNI functionality notably initialising a JVM on Unix
//  as well as maintaining cache of currently attached JNI.env
//

import Foundation
import Dispatch

@_exported import CJavaVM

@_silgen_name("JNI_OnLoad")
public func JNI_OnLoad( jvm: UnsafeMutablePointer<JavaVM?>, ptr: UnsafeRawPointer ) -> jint {
    JNI.jvm = jvm
    let env: UnsafeMutablePointer<JNIEnv?>? = JNI.GetEnv()
    JNI.api = env!.pointee!.pointee
    JNI.envCache[JNI.threadKey] = env
#if os(Android)
    DispatchQueue.setThreadDetachCallback( JNI_DetachCurrentThread )
#endif
    return jint(JNI_VERSION_1_6)
}

public func JNI_DetachCurrentThread() {
    _ = JNI.jvm?.pointee?.pointee.DetachCurrentThread( JNI.jvm )
    JNI.envLock.lock()
    JNI.envCache[JNI.threadKey] = nil
    JNI.envLock.unlock()
}

public let JNI = JNICore()

open class JNICore {

    open var jvm: UnsafeMutablePointer<JavaVM?>?
    open var api: JNINativeInterface_!

    open var envCache = [pthread_t:UnsafeMutablePointer<JNIEnv?>?]()
    fileprivate let envLock = NSLock()

    open var threadKey: pthread_t { return pthread_self() }

    open var env: UnsafeMutablePointer<JNIEnv?>? {
        let currentThread = threadKey
        if let env = envCache[currentThread] {
            return env
        }

        let env = AttachCurrentThread()
        envLock.lock()
        envCache[currentThread] = env
        envLock.unlock()
        return env
    }

    open func AttachCurrentThread() -> UnsafeMutablePointer<JNIEnv?>? {
        var tenv: UnsafeMutablePointer<JNIEnv?>?
        if withPointerToRawPointer(to: &tenv, {
            self.jvm?.pointee?.pointee.AttachCurrentThread( self.jvm, $0, nil )
        } ) != jint(JNI_OK) {
            report( "Could not attach to background jvm" )
        }
        return tenv
    }

    open func report( _ msg: String, _ file: StaticString = #file, _ line: Int = #line ) {
        NSLog( "\(msg) - at \(file):\(line)" )
        if api?.ExceptionCheck( env ) != 0 {
            api.ExceptionDescribe( env )
        }
    }

    open func initJVM( options: [String]? = nil, _ file: StaticString = #file, _ line: Int = #line ) -> Bool {
#if os(Android)
        return true
#else
        if jvm != nil {
            report( "JVM can only be initialised once", file, line )
            return true
        }

        var options: [String]? = options
        if options == nil {
            var classpath: String = String( cString: getenv("HOME") )+"/.swiftjava.jar"
            if let CLASSPATH: UnsafeMutablePointer<Int8> = getenv( "CLASSPATH" ) {
                classpath += ":"+String( cString: CLASSPATH )
            }
            options = ["-Djava.class.path="+classpath,
                       // add to bootclasspath as threads not started using Thread class
                       // will not have the correct classloader and be missing classpath
                       "-Xbootclasspath/a:"+classpath]
        }

        var vmOptions = [JavaVMOption]( repeating: JavaVMOption(), count: options?.count ?? 1 )

        return withUnsafeMutablePointer(to: &vmOptions[0]) {
            (vmOptionsPtr) in
            var vmArgs = JavaVMInitArgs()
            vmArgs.version = jint(JNI_VERSION_1_6)
            vmArgs.nOptions = jint(options?.count ?? 0)
            vmArgs.options = vmOptionsPtr

            if let options: [String] = options {
                for i in 0..<options.count {
                    options[i].withCString {
                        (cString) in
                        vmOptions[i].optionString = strdup( cString )
                    }
                }
            }

            var tenv: UnsafeMutablePointer<JNIEnv?>?
            if withPointerToRawPointer(to: &tenv, {
                JNI_CreateJavaVM( &self.jvm, $0, &vmArgs )
            } ) != jint(JNI_OK) {
                report( "JNI_CreateJavaVM failed", file, line )
                return false
            }

            self.envCache[threadKey] = tenv
            self.api = self.env!.pointee!.pointee
            return true
        }
#endif
    }

    private func withPointerToRawPointer<T, Result>(to arg: inout T, _ body: @escaping (UnsafeMutablePointer<UnsafeMutableRawPointer?>) throws -> Result) rethrows -> Result {
        return try withUnsafeMutablePointer(to: &arg) {
            try $0.withMemoryRebound(to: UnsafeMutableRawPointer?.self, capacity: 1) {
                try body( $0 )
            }
        }
    }

    open func GetEnv() -> UnsafeMutablePointer<JNIEnv?>? {
        var tenv: UnsafeMutablePointer<JNIEnv?>?
        if withPointerToRawPointer(to: &tenv, {
            JNI.jvm?.pointee?.pointee.GetEnv(JNI.jvm, $0, jint(JNI_VERSION_1_6) )
        } ) != jint(JNI_OK) {
            report( "Unable to get initial JNIEnv" )
        }
        return tenv
    }

    private func autoInit() {
        envLock.lock()
        if envCache.isEmpty && !initJVM() {
            report( "Auto JVM init failed" )
        }
        envLock.unlock()
    }

    open func background( closure: @escaping () -> () ) {
        autoInit()
        DispatchQueue.global(qos: .default).async {
            closure()
        }
    }

    public func run() {
        RunLoop.main.run(until: Date.distantFuture)
    }

    open func FindClass( _ name: UnsafePointer<Int8>, _ file: StaticString = #file, _ line: Int = #line ) -> jclass? {
        autoInit()
        ExceptionReset()
        let clazz: jclass? = api.FindClass( env, name )
        if clazz == nil {
            report( "Could not find class \(String( cString: name ))", file, line )
            if strncmp( name, "org/swiftjava/", 14 ) == 0 {
                report( "\n\nLooking for a swiftjava proxy class required for event listeners and Runnable's to work.\n" +
                    "Have you copied https://github.com/SwiftJava/SwiftJava/blob/master/swiftjava.jar to ~/.swiftjava.jar " +
                    "and/or set the CLASSPATH environment variable?\n" )
            }
        }
        return clazz
    }

    open func CachedFindClass( _ name: UnsafePointer<Int8>, _ classCache: UnsafeMutablePointer<jclass?>,
                               _ file: StaticString = #file, _ line: Int = #line ) {
        if classCache.pointee == nil, let clazz: jclass = FindClass( name, file, line ) {
            classCache.pointee = api.NewGlobalRef( env, clazz )
            api.DeleteLocalRef( env, clazz )
        }
    }

    open func GetObjectClass( _ object: jobject?, _ locals: UnsafeMutablePointer<[jobject]>,
                              _ file: StaticString = #file, _ line: Int = #line ) -> jclass? {
        ExceptionReset()
        if object == nil {
            report( "GetObjectClass with nil object", file, line )
        }
        let clazz: jclass? = api.GetObjectClass( env, object )
        if clazz == nil {
            report( "GetObjectClass returns nil class", file, line )
        }
        else {
            locals.pointee.append( clazz! )
        }
        return clazz
    }

    private static var java_lang_ObjectClass: jclass?

    open func NewObjectArray( _ count: Int, _ array: [jobject?]?, _ locals: UnsafeMutablePointer<[jobject]>, _ file: StaticString = #file, _ line: Int = #line  ) -> jobjectArray? {
        CachedFindClass( "java/lang/Object", &JNICore.java_lang_ObjectClass, file, line )
        var arrayClass: jclass? = JNICore.java_lang_ObjectClass
        if array?.count != 0 {
            arrayClass = JNI.GetObjectClass(array![0], locals)
        }
        else {
#if os(Android)
            return nil
#endif
        }
        let array: jobjectArray? = api.NewObjectArray( env, jsize(count), arrayClass, nil )
        if array == nil {
            report( "Could not create array", file, line )
        }
        return array
    }

    open func DeleteLocalRef( _ local: jobject? ) {
        if local != nil {
            api.DeleteLocalRef( env, local )
        }
    }

    private var thrownCache = [pthread_t: jthrowable]()
    private let thrownLock = NSLock()

    open func check<T>( _ result: T, _ locals: UnsafeMutablePointer<[jobject]>, removeLast: Bool = false, _ file: StaticString = #file, _ line: Int = #line ) -> T {
        if removeLast && locals.pointee.count != 0 {
            locals.pointee.removeLast()
        }
        for local in locals.pointee {
            DeleteLocalRef( local )
        }
        if api.ExceptionCheck( env ) != 0, let throwable: jthrowable = api.ExceptionOccurred( env ) {
            report( "Exception occured", file, line )
            thrownLock.lock()
            thrownCache[threadKey] = throwable
            thrownLock.unlock()
            api.ExceptionClear( env )
        }
        return result
    }

    open func ExceptionCheck() -> jthrowable? {
        let currentThread: pthread_t = threadKey
        if let throwable: jthrowable = thrownCache[currentThread] {
            thrownLock.lock()
            thrownCache.removeValue(forKey: currentThread)
            thrownLock.unlock()
            return throwable
        }
        return nil
    }

    open func ExceptionReset() {
        if let throwable: jthrowable = ExceptionCheck() {
            report( "Left over exception" )
            Throwable( javaObject: throwable ).printStackTrace()
        }
    }

}
