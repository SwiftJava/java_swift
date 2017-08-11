
### java_swift

Support framework for Swift-Java Bridge organised as follows:

* [JNICore.swift](blob/master/Sources/JNICore.swift): Management of interactions with JVM

* [JNIObject.swift](blob/master/Sources/JNIObject.swift): basic object types and protocols

* [JNIProxy.swift](blob/master/Sources/JNIProxy.swift): exporting a Swift object to Java

* [JNIField.swift](blob/master/Sources/JNIField.swift): field accessors

* [JNIMethod.swift](blob/master/Sources/JNIMethod.swift): method accessors

* [JNIType.swift](blob/master/Sources/JNIType.swift): encoding and decoding to/from Java

* [JavaClass.swift](blob/master/Sources/JavaClass.swift): The object representing a Java class

* [JavaObject.swift](blob/master/Sources/JavaObject.swift): Superclass of all Swift objects representing a object from Java

* [JavaMap.swift](blob/master/Sources/JavaMap.swift): Used to support representing dictionaries in Java

* [HashMap.swift](blob/master/Sources/HashMap.swift): Used to support representing dictionaries in Java

* [Throwable.swift](blob/master/Sources/Throwable.swift): Used for error reporting/dumping stack

* [Exception.swift](blob/master/Sources/Exception.swift): Used for error reporting/dumping stack

* [Runnable.swift](blob/master/Sources/Runnable.swift): A proxy for a closure passed from/to Java

# MIT License

The MIT License (MIT)
Copyright (c) 2016, John Holdsworth

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This License does not apply to the code generated from the Apple distribution of the Java VM
which are provided under the provisions of "Fair Use" but your use is ultimately subject
to the original License Agreement.
