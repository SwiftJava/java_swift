//
//  Package.swift
//  SwiftJava
//
//  Created by John Holdsworth on 20/07/2016.
//  Copyright (c) 2016 John Holdsworth. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "java_swift",
    dependencies: [
        .Package(url: "https://github.com/SwiftJava/CJavaVM.git", versions: Version(1,1,4)..<Version(10,0,0)),
        ]
)
