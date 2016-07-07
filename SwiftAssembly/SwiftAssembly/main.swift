//
//  main.swift
//  SwiftAssembly
//
//  Created by AugustRush on 7/2/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

//func test() {
//    print("just a test function!");
//}

func test1() {
    print("just a test1 function!");
}


let sampleClassInstance = ASampleClass()

//可以通过 @_silgen_name 指定 say_hello 方法经过Swift mangling name后的编码字符串，以供在 C 中直接调用
@_silgen_name("say_hello") func say_hello() -> NSNumber {
    print("This is say_hello() in swift")
    return NSNumber(double: 3.14)
}

@_silgen_name("notsay_hello") func notsay_hello() -> NSNumber {
    print("This is notsay_hello() in swift")
    return NSNumber(double: 3.1416926)
}

let a = performFunction("_TFC13SwiftAssembly12ASampleClass13aTestFunctionfT_SS", sampleClassInstance,sizeof(String))
let b = performFunction("_TFC13SwiftAssembly12ASampleClass13bTestFunctionfT_CSo8NSString", sampleClassInstance,sizeof(NSString))
let c = performFunction("say_hello", nil, sizeof(NSNumber))
let d = performFunction("notsay_hello", nil, sizeof(NSNumber))

//print("a is \(a)")
print("b is \(b)")
print("c is \(c)")
print("d is \(d)")

//func typename (thing:Any) -> String{
//    let name = _stdlib_getTypeName(thing)
//    let demangleName = _stdlib_demangleName(name)
//    return demangleName.componentsSeparatedByString(".").last!
//}