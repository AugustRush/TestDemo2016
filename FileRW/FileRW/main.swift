//
//  main.swift
//  FileRW
//
//  Created by AugustRush on 5/27/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

//struct Test {
//    var x: Float32 = 10.0
//    var y: Float64 = 10.0
//    var z: Float80 = 10
//    var test  = "test"
//    var names: [String] = Array()
//    
//    init() {
//        names.append("liu")
//        names.append("pingwei")
//    }
//    
//    
//    mutating func save() {
//        let file = fopen("/Users/baidu/Desktop/untitled", "wb")
//        if file != nil {
//            fwrite(&self, sizeof(Test), 1, file)
//            fclose(file)
//        }
//    }
//    
//    mutating func read() -> Test {
//        var new = Test()
//        let file = fopen("/Users/baidu/Desktop/untitled", "wb")
//        if file != nil {
////            fwrite(&self, sizeof(Test), 1, file)
//            fread(&new, sizeof(Test), 1, file)
//            fclose(file)
//        }
//        return new
//    }
//}
//var xiaoMing = Test()
//xiaoMing.save()
//let r = Mirror(reflecting: xiaoMing)
//print("xiaoMing 是 \(r.displayStyle!)")
//
//print("属性个数:\(r.children.count)")
//for i in r.children.startIndex..<r.children.endIndex {
//    print("属性名:\(r.children[i].0!)，值:\(r.children[i].1)")
//}
//
//dump(xiaoMing)
//
//print("Struc Test size is \(sizeof(Test))")

class Person {
    var sex: Bool = false
    var name = "test"
    
    
    func test() {
//        sizeofValue(<#T##T#>)
//        unsafeAddressOf(<#T##object: AnyObject##AnyObject#>)
    }
}

let p = Person()
print("Person size is \(sizeofValue(Person)), \(sizeof(Person),unsafeAddressOf(p), sizeof(p.dynamicType))")



