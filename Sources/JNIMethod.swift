//
//  JNIMethod.swift
//  SwiftJava
//
//  Created by John Holdsworth on 17/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import CJavaVM

public class JNIMethod {

    static func getStaticMethodID( _ methodName: UnsafePointer<Int8>, _ methodSig: UnsafePointer<Int8>,
                             _ methodCache: UnsafeMutablePointer<jmethodID?>,
                             _ className: UnsafePointer<Int8>, _ classCache: UnsafeMutablePointer<jclass?>,
                             _ file: StaticString = #file, _ line: Int = #line ) {
        JNI.CachedFindClass( className, classCache, file, line )
        methodCache.pointee = JNI.api.GetStaticMethodID( JNI.env, classCache.pointee, methodName, methodSig )
        if methodCache.pointee == nil {
            JNI.report( "Failed to lookup static method \(String(cString: methodName))( \(String(cString: methodSig)) )", file, line )
        }
    }

    static func getMethodID( _ methodName: UnsafePointer<Int8>, _ methodSig: UnsafePointer<Int8>,
                             _ methodCache: UnsafeMutablePointer<jmethodID?>, _ object: jobject?,
                             _ locals: UnsafeMutablePointer<[jobject]>?,
                             _ file: StaticString = #file, _ line: Int = #line ) {
        let clazz = JNI.GetObjectClass( object, locals, file, line )
        methodCache.pointee = JNI.api.GetMethodID( JNI.env, clazz, methodName, methodSig )
        if methodCache.pointee == nil {
            JNI.report( "Failed to lookup method \(String(describing: object)).\(String(describing: clazz)).\(String(cString: methodName))( \(String(cString: methodSig)) )", file, line )
        }
    }

    public static func NewObject( className: UnsafePointer<Int8>, classObject: jclass?,
                                  methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        methodCache.pointee = JNI.api.GetMethodID( JNI.env, classObject, "<init>", methodSig )
        if methodCache.pointee == nil {
            JNI.report( "Failed to lookup constructor \(String(cString: className)).<init>( \(String(cString: methodSig)) )", file, line )
        }
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.NewObjectA( JNI.env, classObject, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func NewObject( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        JNI.CachedFindClass( className, classCache, file, line )
        return NewObject( className: className, classObject: classCache.pointee,
                          methodSig: methodSig, methodCache: methodCache,
                          args: args, locals: locals )
    }

    public static func CallStaticObjectMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticObjectMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticBooleanMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticBooleanMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticByteMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                      methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                      args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticByteMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticCharMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                      methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                      args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticCharMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticShortMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticShortMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticIntMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticIntMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticLongMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallLongMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticFloatMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallStaticFloatMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticDoubleMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallDoubleMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallStaticVoidMethod( className: UnsafePointer<Int8>, classCache: UnsafeMutablePointer<jclass?>,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticMethodID( methodName, methodSig, methodCache, className, classCache, file, line )
        withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            JNI.check( JNI.api.CallStaticVoidMethodA( JNI.env, classCache.pointee, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }


    public static func CallObjectMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jobject! {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallObjectMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallBooleanMethod( object: jobject?,
                                   methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                   args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                   _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallBooleanMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallByteMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallByteMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallCharMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallCharMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallShortMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallShortMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallIntMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallIntMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallLongMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallLongMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallFloatMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallFloatMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallDoubleMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        return withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            return JNI.check( JNI.api.CallDoubleMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

    public static func CallVoidMethod( object: jobject?,
                                  methodName: UnsafePointer<Int8>, methodSig: UnsafePointer<Int8>, methodCache: UnsafeMutablePointer<jmethodID?>,
                                  args: UnsafeMutablePointer<[jvalue]>, locals: UnsafeMutablePointer<[jobject]>,
                                  _ file: StaticString = #file, _ line: Int = #line ) {
        getMethodID( methodName, methodSig, methodCache, object, locals, file, line )
        withUnsafePointer(to: &args.pointee[0]) {
            argsPtr in
            JNI.check( JNI.api.CallVoidMethodA( JNI.env, object, methodCache.pointee, argsPtr ), locals, file, line )
        }
    }

}
