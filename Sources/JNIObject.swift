//
//  JNIObject.swift
//  SwiftJava
//
//  Created by John Holdsworth on 14/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import CJavaVM

public protocol JNIObjectProtocol {
    func withJavaObject<Result>( _ body: @escaping (jobject?) throws -> Result ) rethrows -> Result
    func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]>? ) -> jobject?
}

public protocol JavaProtocol: JNIObjectProtocol {

}

public protocol UnclassedProtocol: JavaProtocol {

}

open class UnclassedProtocolForward: JNIObjectForward, UnclassedProtocol {

}

open class JNIObject: JNIObjectProtocol {

    private var _javaObject: jobject?

    open var javaObject: jobject? {
        get {
            return _javaObject
        }
        set(newValue) {
            if newValue != _javaObject {
                let oldValue = _javaObject
                if newValue != nil {
                    _javaObject = JNI.api.NewGlobalRef( JNI.env, newValue )
                }
                else {
                    _javaObject = nil
                }
                if oldValue != nil {
                    JNI.api.DeleteGlobalRef( JNI.env, oldValue )
                }
            }
        }
    }

    public required init( javaObject: jobject? ) {
        self.javaObject = javaObject
    }

    deinit {
        javaObject = nil
    }

    open var isNull: Bool {
        return _javaObject == nil || JNI.api.IsSameObject( JNI.env, _javaObject, nil ) == jboolean(JNI_TRUE)
    }

    open func withJavaObject<Result>(_ body: @escaping (jobject?) throws -> Result) rethrows -> Result {
        return try body( javaObject )
    }

    open func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]>? ) -> jobject? {
        if let local = _javaObject != nil ? JNI.api.NewLocalRef( JNI.env, _javaObject ) : nil {
            locals?.pointee.append( local )
            return local
        }
        return _javaObject
    }

    open func swiftValue() -> jvalue {
        return jvalue( j: jlong(unsafeBitCast(Unmanaged.passRetained(self), to: uintptr_t.self)) )
    }

    open func updateSwiftObject( _ file: StaticString = #file, _ line: Int = #line ) {
        guard _javaObject != nil else { return }
        let existing = JNIObject.swiftField( _javaObject, file, line )
        var fieldID: jfieldID?
        var locals = [jobject]()
        JNIField.SetLongField( fieldName: "swiftObject", fieldType: "J", fieldCache: &fieldID,
                               object: _javaObject, value: swiftValue().j, locals: &locals, file, line )
        if existing != 0 {
            Unmanaged<JNIObject>.fromOpaque( UnsafeRawPointer(bitPattern: existing)! ).release()
        }
    }

    public static func swiftField( _ object: jobject?, _ file: StaticString = #file, _ line: Int = #line ) -> uintptr_t {
        var fieldID: jfieldID?
        var locals = [jobject]()
        let swiftField = JNIField.GetLongField( fieldName: "swiftObject", fieldType: "J", fieldCache: &fieldID,
                                                object: object, locals: &locals, file, line )
        #if os(Android)
        return uintptr_t(swiftField&0xffffffff)
        #else
        return uintptr_t(swiftField)
        #endif
    }

    public static func swiftPointer( jniEnv: UnsafeMutablePointer<JNIEnv?>?, object: jobject?, _ file: StaticString = #file, _ line: Int = #line ) -> uintptr_t {
//        let currentThread = pthread_self()
//        let saveEnv = JNI.envCache[currentThread]
//        JNI.envCache[currentThread] = jniEnv
        let swiftPointer = JNIObject.swiftField( object, file, line )
        if swiftPointer == 0 {
            JNI.report( "Race condition setting swiftObject on Java Proxy. More thought required..." )
        }
//        if saveEnv != nil {
//            JNI.envCache[currentThread] = saveEnv
//        }
        return swiftPointer
    }

}

open class UnclassedObject: JNIObject, Error {

}

open class JNIObjectForward: JNIObject {

}

open class JNIObjectProxy: JNIObject {

    open func createProxy( javaClassName: UnsafePointer<Int8>, _ file: StaticString = #file, _ line: Int = #line ) {
        var javaClass: jclass?
        var locals = [jobject]()
        var methodID: jmethodID?
        var args: [jvalue] = [swiftValue()]
        if let newObject = JNIMethod.NewObject( className: javaClassName, classCache: &javaClass,
                                                methodSig: "(J)V", methodCache: &methodID,
                                                args: &args, locals: &locals ) {
            javaObject = newObject
        }
        else {
            JNI.report( "Unable to create proxy: \(String( cString: javaClassName ))" )
        }
    }

    open func createProxy( className: UnsafePointer<Int8>, classObject: jclass?, file: StaticString = #file, _ line: Int = #line ) {
        var locals = [jobject]()
        var methodID: jmethodID?
        var args: [jvalue] = [swiftValue()]
        if let newObject = JNIMethod.NewObject( className: className, classObject: classObject,
                                                methodSig: "(J)V", methodCache: &methodID,
                                                args: &args, locals: &locals ) {
            javaObject = newObject
        }
        else {
            JNI.report( "Unable to create proxy: \(String( cString: className ))" )
        }
    }

}

extension JNIType {

    public static func encode( value: JNIObject?, locals: UnsafeMutablePointer<[jobject]>? ) -> jvalue {
        return jvalue( l: value?.localJavaObject( locals ) )
    }

    public static func decode<T: JNIObject>( type: T, from: jobject? ) -> T? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return T( javaObject: from )
    }

    public static func encode( value: [JNIObject]?, locals: UnsafeMutablePointer<[jobject]>? ) -> jvalue {
        return encode( value: value?.map { encode( value: $0, locals: locals ).l }, locals: locals )
    }

    public static func decode<T: JNIObject>( type: [T], from: jobject? ) -> [T]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return (0..<JNI.api.GetArrayLength( JNI.env, from )).map {
            T( javaObject: JNI.api.GetObjectArrayElement( JNI.env, from, $0 ) ) }
    }

    public static func encode<T: JNIObject>( value: [[T]]?, locals: UnsafeMutablePointer<[jobject]>? ) -> jvalue {
        return encode( value: value?.map { encode( value: $0, locals: locals ).l }, locals: locals )
    }

    public static func decode<T: JNIObject>( type: [[T]], from: jobject? ) -> [[T]]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return (0..<JNI.api.GetArrayLength( JNI.env, from )).map {
            decode( type: [T](), from: JNI.api.GetObjectArrayElement( JNI.env, from, $0 ) ) ?? [T]() }
    }

}
