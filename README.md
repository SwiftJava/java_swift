
### java_swift

Support framework for Swift-Java Bridge organised as follows:

* [JNICore.swift](Sources/JNICore.swift): Management of interactions with JVM

* [JNIObject.swift](Sources/JNIObject.swift): basic object types and protocols

* [JNIProxy.swift](Sources/JNIProxy.swift): exporting a Swift object to Java

* [JNIField.swift](Sources/JNIField.swift): field accessors

* [JNIMethod.swift](Sources/JNIMethod.swift): method accessors

* [JNIType.swift](Sources/JNIType.swift): encoding and decoding to/from Java

Generated classes:

* [JavaClass.swift](Sources/JavaClass.swift): The object representing a Java class

* [JavaObject.swift](Sources/JavaObject.swift): Superclass of all Swift objects representing a object from Java

* [JavaEnum.swift](Sources/JavaEnum.swift): Used to convert Java enums as Swift enums

* [JavaMap.swift](Sources/JavaMap.swift): Used to support representing dictionaries in Java

* [JavaSet.swift](Sources/JavaSet.swift): Included to extract the keys from a JavaMap

* [HashMap.swift](Sources/HashMap.swift): Concrete implementation for dictionaries in Java

* [Throwable.swift](Sources/Throwable.swift): Used for error reporting/dumping stack

* [Exception.swift](Sources/Exception.swift): Used for error reporting/dumping stack

* [Runnable.swift](Sources/Runnable.swift): A proxy for a closure passed to/from Java

This version requires the second beta of the toolchain downloadable from [here](http://johnholdsworth.com/android_toolchain.tgz).

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

This License does not apply to the code generated from the macOS distribution of the Java VM
which are provided under the provisions of "Fair Use" but your use is ultimately subject
to the original License Agreement.
