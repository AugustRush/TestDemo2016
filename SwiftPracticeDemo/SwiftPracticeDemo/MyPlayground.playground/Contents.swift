//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

let arr = [1, 2, 3, 6, 5, 4]
let brr = arr.flatMap {
    "NO." + String($0) }

let a1: Int? = 3
let b1 = a1.map{ $0 * 2 }

let a2: Int? = nil
let b2 = a2.map{ $0 * 2 }

let s: String? = "abc"
let v = s.flatMap { (a: String) -> String? in
    return a + "test"
}



func doIt(@noescape code: () -> ()) {
    code()
}

class Bar {
    var i = 0
    func some() {
        doIt {
            print("do it output \(i)")
            //      ^ we don't need `self.` anymore!
        }
    }
}

let bar = Bar()
bar.some() // -> outputs 0

struct exp {
    var pro1 : String
    var pro2 : Int
    var pro3 : Character
}
