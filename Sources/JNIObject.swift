//
//  JNIObject.swift
//  SwiftJava
//
//  Created by John Holdsworth on 14/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import Foundation

public protocol JNIObjectProtocol {

    func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]> ) -> jobject?

    func withJavaObject<Result>( _ body: @escaping (jobject?) throws -> Result ) rethrows -> Result

}

extension JNIObjectProtocol {

    public func withJavaObject<Result>( _ body: @escaping (jobject?) throws -> Result ) rethrows -> Result {
        var locals = [jobject]()
        let javaObject = localJavaObject( &locals )
        defer {
            for local in locals {
                JNI.DeleteLocalRef( local )
            }
        }
        return try body( javaObject )
    }

}

public protocol JavaProtocol: JNIObjectProtocol {
}

public protocol UnclassedProtocol: JavaProtocol {
}

open class UnclassedProtocolForward: JNIObjectForward, UnclassedProtocol  {

}

open class UnclassedObject: JavaObject, Error {
}

extension Throwable: Error {
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

    public convenience init() {
        self.init( javaObject: nil )
    }

    public required init( javaObject: jobject? ) {
        self.javaObject = javaObject
    }

    open var isNull: Bool {
        return _javaObject == nil || JNI.api.IsSameObject( JNI.env, _javaObject, nil ) == jboolean(JNI_TRUE)
    }

    open func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]> ) -> jobject? {
        if let local = _javaObject != nil ? JNI.api.NewLocalRef( JNI.env, _javaObject ) : nil {
            locals.pointee.append( local )
            return local
        }
        return nil
    }

    open func clearLocal() {
    }

    deinit {
        javaObject = nil
    }

}

open class JNIObjectForward: JNIObject {
}

extension String: JNIObjectProtocol {

    public func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]> ) -> jobject? {
        if let javaObject =  Array(utf16).withUnsafeBufferPointer( {
            JNI.env?.pointee?.pointee.NewString( JNI.env, $0.baseAddress, jsize($0.count) )
        } ) {
            locals.pointee.append( javaObject )
            return javaObject
        }
        return nil
    }

}

//// Passing arbitrary arrays and dictionaries of objects will have to wait for swift 4 I guess
//// https://github.com/apple/swift-evolution/blob/master/proposals/0143-conditional-conformances.md#extending-protocols-to-conform-to-protocols
//
//extension Array: JNIObjectProtocol where Element: JNIObjectProtocol {
//    public func localJavaObject( _ locals: UnsafeMutablePointer<[jobject]> ) -> jobject? {
//        return JNIType.toJava( value: map { JNIType.toJava( value: $0, locals: locals ).l }, locals: locals ).l
//    }
//}

extension JNIType {

    public static func toJava( value: [jobject?]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        if let value = value, let array = JNI.NewObjectArray( value.count, value, locals ) {
            for i in 0..<value.count {
                JNI.api.SetObjectArrayElement( JNI.env, array, jsize(i), value[i] )
            }
            locals.pointee.append( array )
            return jvalue( l: array )
        }
        return jvalue( l: nil )
    }

    public static func toJava( value: JNIObjectProtocol?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( l: value?.localJavaObject( locals ) )
    }

    public static func toJava( value: [JNIObjectProtocol]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJava( value: value?.map { toJava( value: $0, locals: locals ).l }, locals: locals )
    }

    public static func toJava( value: [[JNIObjectProtocol]]?, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return toJava( value: value?.map { toJava( value: $0, locals: locals ).l }, locals: locals )
    }

    public static func toSwift<T: JNIObject>( type: T, from: jobject? ) -> T? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return T( javaObject: from )
    }

    public static func toSwift<T: JNIObject>( type: [T], from: jobject? ) -> [T]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return (0 ..< JNI.api.GetArrayLength( JNI.env, from )).map {
            let element = JNI.api.GetObjectArrayElement( JNI.env, from, $0 )
            defer { JNI.DeleteLocalRef( element ) }
            return T( javaObject: element )
        }
    }

    public static func toSwift<T: JNIObject>( type: [[T]], from: jobject? ) -> [[T]]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        return (0 ..< JNI.api.GetArrayLength( JNI.env, from )).map {
            toSwift( type: [T](), from: JNI.api.GetObjectArrayElement( JNI.env, from, $0 ) ) ?? [T]() }
    }

    public static func toJava( value: JNIObjectProtocol?, mapClass: String, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        return jvalue( l: value?.localJavaObject( locals ) )
    }

    public static func toJava( value: [String:JNIObjectProtocol]?, mapClass: String, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        guard let value = value else { return jvalue( l: nil ) }

        var classCache: jclass?
        var methodID: jmethodID?
        var __locals = [jobject]()
        var __args = [jvalue]( repeating: jvalue(), count: 1 )
        guard let __object = JNIMethod.NewObject( className: mapClass, classCache: &classCache,
                   methodSig: "()V", methodCache: &methodID, args: &__args, locals: &__locals ) else {
            JNI.report( "Unable to create HashMap of class \(mapClass)" )
            return jvalue( l: nil )
        }
        
       JNI.api.DeleteGlobalRef( JNI.env, classCache )

        let map = HashMap( javaObject: __object )
        for (key, item) in value {
            let javaKey = JavaObject( javaObject: toJava( value: key, locals: locals ).l )
            let javaItem = JavaObject( javaObject: toJava( value: item, locals: locals ).l )
            _ = map.put( javaKey, javaItem )
        }

        locals.pointee.append( __object )
        return jvalue( l: __object )
    }

    public static func toJava( value: [String:[JNIObjectProtocol]]?, mapClass: String, locals: UnsafeMutablePointer<[jobject]> ) -> jvalue {
        guard let value = value else { return jvalue( l: nil ) }

        var classCache: jclass?
        var methodID: jmethodID?
        var __args = [jvalue]( repeating: jvalue(), count: 1 )
        var __locals = [jobject]()
        guard let __object = JNIMethod.NewObject( className: mapClass, classCache: &classCache,
                   methodSig: "()V", methodCache: &methodID, args: &__args, locals: &__locals ) else {
            JNI.report( "Unable to create HashMap of class \(mapClass)" )
            return jvalue( l: nil )
        }

        JNI.api.DeleteGlobalRef( JNI.env, classCache )

        let map = HashMap( javaObject: __object )
        for (key, item) in value {
            let javaKey = JavaObject( javaObject: toJava( value: key, locals: locals ).l )
            let javaItem = JavaObject( javaObject: toJava( value: item, locals: locals ).l )
            _ = map.put( javaKey, javaItem )
        }

        locals.pointee.append( __object )
        return jvalue( l: __object )
    }

    public static func toSwift<T: JNIObject>( type: [String:T], from: jobject? ) -> [String:T]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        let map = HashMap( javaObject: from )
        var out = [String:T]()
        for key in map.keySet().toArray() {
            key.withJavaObject {
                keyObject in
                if let keyref = JNI.api.NewLocalRef( JNI.env, keyObject ),
                    let ketstr = JNIType.toSwift( type: String(), from: keyref ) {
                    map.get(key).withJavaObject {
                        itemObject in
                        out[ketstr] = T( javaObject: itemObject )
                    }
                }
            }
        }
        return out
    }

    public static func toSwift<T: JNIObject>( type: [String:[T]], from: jobject? ) -> [String:[T]]? {
        guard from != nil else { return nil }
        defer { JNI.DeleteLocalRef( from ) }
        let map = HashMap( javaObject: from )
        var out = [String:[T]]()
        for key in map.keySet().toArray() {
            key.withJavaObject {
                keyObject in
                map.get(key).withJavaObject {
                    itemObject in
                    if let keyref = JNI.api.NewLocalRef( JNI.env, keyObject ),
                        let keystr = JNIType.toSwift( type: String(), from: keyref ),
                        let valref = JNI.api.NewLocalRef( JNI.env, itemObject ),
                        let value = JNIType.toSwift( type: [T](), from: valref ) {
                        out[keystr] = value
                    }
                }
            }
        }
        return out
    }

}
