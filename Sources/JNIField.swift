//
//  JNIField.swift
//  SwiftJava
//
//  Created by John Holdsworth on 17/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import CJavaVM

public class JNIField {

    static func getStaticFieldID( _ fieldName: UnsafePointer<Int8>, _ fieldSig: UnsafePointer<Int8>,
                                  _ fieldCache: UnsafeMutablePointer<jfieldID?>,
                                  _ className: UnsafePointer<Int8>, _ classCache: UnsafeMutablePointer<jclass?>,
                                  _ file: StaticString = #file, _ line: Int = #line ) {
        JNI.CachedFindClass( className, classCache, file, line )
        fieldCache.pointee = JNI.api.GetStaticFieldID( JNI.env, classCache.pointee, fieldName, fieldSig )
        if fieldCache.pointee == nil {
            JNI.report( "Failed to lookup static field \(String(cString: fieldName))")
        }
    }

    static func getFieldID( _ fieldName: UnsafePointer<Int8>, _ fieldSig: UnsafePointer<Int8>,
                            _ fieldCache: UnsafeMutablePointer<jfieldID?>, _ object: jobject?,
                            _ file: StaticString = #file, _ line: Int = #line ) {
        let clazz = JNI.GetObjectClass( object, file, line )
        fieldCache.pointee = JNI.api.GetFieldID( JNI.env, clazz, fieldName, fieldSig )
        if fieldCache.pointee == nil {
            JNI.report( "Failed to lookup field \(String(cString: fieldName))")
        }
    }

    public static func GetStaticObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticObjectField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                       classCache: UnsafeMutablePointer<jclass?>,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticBooleanField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                    classCache: UnsafeMutablePointer<jclass?>,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticByteField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                    classCache: UnsafeMutablePointer<jclass?>,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticCharField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticShortField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticIntField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticLongField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                     classCache: UnsafeMutablePointer<jclass?>,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticFloatField( JNI.env, classCache.pointee, fieldCache.pointee )
    }

    public static func GetStaticDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                     classCache: UnsafeMutablePointer<jclass?>,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.api.GetStaticDoubleField( JNI.env, classCache.pointee, fieldCache.pointee )
    }


    public static func GetObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetObjectField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                        fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                        _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetBooleanField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetByteField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetCharField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetShortField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetIntField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetLongField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetFloatField( JNI.env, object, fieldCache.pointee )
    }

    public static func GetDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        return JNI.api.GetDoubleField( JNI.env, object, fieldCache.pointee )
    }


    public static func SetStaticObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                       classCache: UnsafeMutablePointer<jclass?>, value: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticObjectField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                       classCache: UnsafeMutablePointer<jclass?>, value: jboolean,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticBooleanField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jbyte,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticByteField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jchar,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticCharField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jshort,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticShortField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jint,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticIntField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jlong,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticLongField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jfloat,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticFloatField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }

    public static func SetStaticDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jdouble,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.api.SetStaticDoubleField( JNI.env, classCache.pointee, fieldCache.pointee, value )
    }


    public static func SetObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetObjectField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                        fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jboolean,
                                        _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetBooleanField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jbyte,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetByteField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jchar,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetCharField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jshort,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetShortField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jint,
                                    _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetIntField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jlong,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetLongField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jfloat,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetFloatField( JNI.env, object, fieldCache.pointee, value )
    }

    public static func SetDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jdouble,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, file, line )
        JNI.api.SetDoubleField( JNI.env, object, fieldCache.pointee, value )
    }

}
