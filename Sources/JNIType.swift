//
//  JNIType.swift
//  SwiftJava
//
//  Created by John Holdsworth on 17/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//
//  Conversion to/from Java primitives/objects from basic Swift types.
//

public class JNIType {

    public static func toJava( value: Bool, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( z: jboolean( value ? JNI_TRUE : JNI_FALSE ) )
    }

    public static func toSwift( type: Bool.Type, from: jboolean, consume: Bool = true ) -> Bool {
        return from != jboolean( JNI_FALSE )
    }

    public static func toJava( value: [Bool]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if let value: [Bool] = value, let array: jbooleanArray = JNI.api.NewBooleanArray( JNI.env, jsize(value.count) ) {
            var _value: [jboolean] = value.map { jboolean( $0 ? JNI_TRUE : JNI_FALSE ) }
            withUnsafePointer(to: &_value[0]) {
                valuePtr in
                JNI.api.SetBooleanArrayRegion( JNI.env, array, 0,  jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Bool].Type, from: jobject?, consume: Bool = true ) -> [Bool]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [jboolean]( repeating: jboolean(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetBooleanArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value.map { $0 != jboolean( JNI_FALSE ) }
    }

    public static func toJava( value: [[Bool]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Bool]].Type, from: jobject?, consume: Bool = true ) -> [[Bool]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Bool].self, from: $0, consume: false ) ?? [Bool]() }
    }


    public static func toJava( value: Int8, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( b: value )
    }

    public static func toSwift( type: Int8.Type, from: jbyte, consume: Bool = true ) -> jbyte {
        return from
    }

    public static func toJava( value: [Int8]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Int8] = value, let array: jbyteArray = JNI.api.NewByteArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetByteArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Int8].Type, from: jobject?, consume: Bool = true ) -> [Int8]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Int8]( repeating: Int8(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetByteArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[Int8]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Int8]].Type, from: jobject?, consume: Bool = true ) -> [[Int8]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Int8].self, from: $0, consume: false ) ?? [Int8]() }
    }


    public static func toJava( value: Int16, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( s: value )
    }

    public static func toSwift( type: Int16.Type, from: jshort, consume: Bool = true ) -> Int16 {
        return from
    }

    public static func toJava( value: [Int16]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Int16] = value, let array: jshortArray = JNI.api.NewShortArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetShortArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Int16].Type, from: jobject?, consume: Bool = true ) -> [Int16]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Int16]( repeating: Int16(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetShortArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[Int16]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Int16]].Type, from: jobject?, consume: Bool = true ) -> [[Int16]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Int16].self, from: $0, consume: false ) ?? [Int16]() }
    }


    public static func toJava( value: UInt16, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( c: value )
    }

    public static func toSwift( type: UInt16.Type, from: jchar, consume: Bool = true ) -> UInt16 {
        return from
    }

    public static func toJava( value: [UInt16]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [UInt16] = value, let array: jcharArray = JNI.api.NewCharArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetCharArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [UInt16].Type, from: jobject?, consume: Bool = true ) -> [UInt16]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [UInt16]( repeating: UInt16(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetCharArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[UInt16]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[UInt16]].Type, from: jobject?, consume: Bool = true ) -> [[UInt16]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [UInt16].self, from: $0, consume: false ) ?? [UInt16]() }
    }


    public static func toJava( value: Int32, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( i: jint(value) )
    }

    public static func toSwift( type: Int32.Type, from: jint, consume: Bool = true ) -> Int32 {
        return Int32(from)
    }

    public static func toJava( value: [Int32]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Int32] = value, let array: jintArray = JNI.api.NewIntArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                valuePtr.withMemoryRebound( to: jint.self, capacity: value.count ) {
                    JNI.api.SetIntArrayRegion( JNI.env, array, 0, jsize(value.count), $0)
                }
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Int32].Type, from: jobject?, consume: Bool = true ) -> [Int32]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Int32]( repeating: Int32(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            valuePtr.withMemoryRebound( to: jint.self, capacity: value.count ) {
                JNI.api.GetIntArrayRegion( JNI.env, from, 0, length, $0 )
            }
        }
        return value
    }

    public static func toJava( value: [[Int32]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Int32]].Type, from: jobject?, consume: Bool = true ) -> [[Int32]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Int32].self, from: $0, consume: false ) ?? [Int32]() }
    }


    public static func toJava( value: Int, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( j: Int64(value) )
    }

    public static func toSwift( type: Int.Type, from: jint, consume: Bool = true ) -> Int {
        return Int(from)
    }

    public static func toJava( value: [Int]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if let value: [Int] = value, let array: jintArray = JNI.api.NewIntArray( JNI.env, jsize(value.count) ) {
            var _value: [jint] = value.map { jint($0) }
            withUnsafePointer(to: &_value[0]) {
                valuePtr in
                JNI.api.SetIntArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Int].Type, from: jobject?, consume: Bool = true ) -> [Int]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [jint]( repeating: jint(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetIntArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value.map { Int($0) }
    }

    public static func toJava( value: [[Int]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Int]].Type, from: jobject?, consume: Bool = true ) -> [[Int]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Int].self, from: $0, consume: false ) ?? [Int]() }
    }


    public static func toJava( value: Int64, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( j: Int64(value) )
    }

    public static func toSwift( type: Int64.Type, from: jlong, consume: Bool = true ) -> Int64 {
        return Int64(from)
    }

    public static func toJava( value: [Int64]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Int64] = value, let array: jlongArray = JNI.api.NewLongArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetLongArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Int64].Type, from: jobject?, consume: Bool = true ) -> [Int64]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Int64]( repeating: Int64(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetLongArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[Int64]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Int64]].Type, from: jobject?, consume: Bool = true ) -> [[Int64]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Int64].self, from: $0, consume: false ) ?? [Int64]() }
    }


    public static func toJava( value: Float, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( f: value )
    }

    public static func toSwift( type: Float.Type, from: jfloat, consume: Bool = true ) -> Float {
        return from
    }

    public static func toJava( value: [Float]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Float] = value, let array: jfloatArray = JNI.api.NewFloatArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetFloatArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Float].Type, from: jobject?, consume: Bool = true ) -> [Float]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Float]( repeating: Float(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetFloatArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[Float]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Float]].Type, from: jobject?, consume: Bool = true ) -> [[Float]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Float].self, from: $0, consume: false ) ?? [Float]() }
    }


    public static func toJava( value: Double, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( d: value )
    }

    public static func toSwift( type: Double.Type, from: jdouble, consume: Bool = true ) -> Double {
        return from
    }

    public static func toJava( value: [Double]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if var value: [Double] = value, let array: jdoubleArray = JNI.api.NewDoubleArray( JNI.env, jsize(value.count) ) {
            withUnsafePointer(to: &value[0]) {
                valuePtr in
                JNI.api.SetDoubleArrayRegion( JNI.env, array, 0, jsize(value.count), valuePtr )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toSwift( type: [Double].Type, from: jobject?, consume: Bool = true ) -> [Double]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        let length: jsize = JNI.api.GetArrayLength( JNI.env, from )
        var value = [Double]( repeating: Double(), count: Int(length) )
        withUnsafeMutablePointer(to: &value[0]) {
            valuePtr in
            JNI.api.GetDoubleArrayRegion( JNI.env, from, 0, length, valuePtr )
        }
        return value
    }

    public static func toJava( value: [[Double]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJavaArray( value: value, locals: locals ) { toJava( value: $0, locals: $1 ) }
    }

    public static func toSwift( type: [[Double]].Type, from: jobject?, consume: Bool = true ) -> [[Double]]? {
        guard let from: jobject = from else { return nil }
        defer { if consume { JNI.DeleteLocalRef( from ) } }
        return from.arrayMap { toSwift( type: [Double].self, from: $0, consume: false ) ?? [Double]() }
    }

}
