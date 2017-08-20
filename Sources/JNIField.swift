//
//  JNIField.swift
//  SwiftJava
//
//  Created by John Holdsworth on 17/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//
//  Static functions related to accessing static and instance fields
//

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
                            _ locals: UnsafeMutablePointer<[jobject]>,
                            _ file: StaticString = #file, _ line: Int = #line ) {
        let clazz = JNI.GetObjectClass( object, locals, file, line )
        fieldCache.pointee = JNI.api.GetFieldID( JNI.env, clazz, fieldName, fieldSig )
        if fieldCache.pointee == nil {
            JNI.report( "Failed to lookup field \(String(cString: fieldName))")
        }
    }

    public static func GetStaticObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticObjectField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                       classCache: UnsafeMutablePointer<jclass?>,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticBooleanField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                    classCache: UnsafeMutablePointer<jclass?>,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticByteField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                    classCache: UnsafeMutablePointer<jclass?>,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticCharField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticShortField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticIntField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticLongField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                     classCache: UnsafeMutablePointer<jclass?>,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticFloatField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetStaticDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                     classCache: UnsafeMutablePointer<jclass?>,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        var locals = [jobject]()
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        return JNI.check( JNI.api.GetStaticDoubleField( JNI.env, classCache.pointee, fieldCache.pointee ), &locals, file, line )
    }


    public static func GetBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                        fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                        _ file: StaticString = #file, _ line: Int = #line ) -> jboolean {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetBooleanField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jbyte {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetByteField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jchar {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetCharField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jshort {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetShortField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                    _ file: StaticString = #file, _ line: Int = #line ) -> jint {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetIntField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                     _ file: StaticString = #file, _ line: Int = #line ) -> jlong {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetLongField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                      _ file: StaticString = #file, _ line: Int = #line ) -> jfloat {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetFloatField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jdouble {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetDoubleField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }

    public static func GetObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?,
                                       _ file: StaticString = #file, _ line: Int = #line ) -> jobject? {
        var locals = [jobject]()
        getFieldID( fieldName, fieldType, fieldCache, object, &locals, file, line )
        return JNI.check( JNI.api.GetObjectField( JNI.env, object, fieldCache.pointee ), &locals, file, line )
    }


    public static func SetStaticBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                       classCache: UnsafeMutablePointer<jclass?>, value: jboolean,
                                       locals: UnsafeMutablePointer<[jobject]>,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticBooleanField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jbyte,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticByteField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jchar,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticCharField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jshort,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticShortField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jint,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticIntField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jlong,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticLongField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jfloat,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticFloatField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                      classCache: UnsafeMutablePointer<jclass?>, value: jdouble,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticDoubleField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetStaticObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                             fieldCache: UnsafeMutablePointer<jfieldID?>, className: UnsafePointer<Int8>,
                                             classCache: UnsafeMutablePointer<jclass?>, value: jobject?,
                                             locals: UnsafeMutablePointer<[jobject]>,
                                             _ file: StaticString = #file, _ line: Int = #line ) {
        getStaticFieldID( fieldName, fieldType, fieldCache, className, classCache, file, line )
        JNI.check( JNI.api.SetStaticObjectField( JNI.env, classCache.pointee, fieldCache.pointee, value ), locals, file, line )
    }


    public static func SetBooleanField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                        fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jboolean,
                                        locals: UnsafeMutablePointer<[jobject]>,
                                        _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetBooleanField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetByteField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jbyte,
                                     locals: UnsafeMutablePointer<[jobject]>,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetByteField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetCharField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jchar,
                                     locals: UnsafeMutablePointer<[jobject]>,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetCharField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetShortField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jshort,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetShortField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetIntField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                    fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jint,
                                    locals: UnsafeMutablePointer<[jobject]>,
                                    _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetIntField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetLongField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                     fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jlong,
                                     locals: UnsafeMutablePointer<[jobject]>,
                                     _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetLongField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetFloatField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                      fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jfloat,
                                      locals: UnsafeMutablePointer<[jobject]>,
                                      _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetFloatField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetDoubleField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jdouble,
                                       locals: UnsafeMutablePointer<[jobject]>,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetDoubleField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

    public static func SetObjectField( fieldName: UnsafePointer<Int8>, fieldType: UnsafePointer<Int8>,
                                       fieldCache: UnsafeMutablePointer<jfieldID?>, object: jobject?, value: jobject?,
                                       locals: UnsafeMutablePointer<[jobject]>,
                                       _ file: StaticString = #file, _ line: Int = #line ) {
        getFieldID( fieldName, fieldType, fieldCache, object, locals, file, line )
        JNI.check( JNI.api.SetObjectField( JNI.env, object, fieldCache.pointee, value ), locals, file, line )
    }

}
