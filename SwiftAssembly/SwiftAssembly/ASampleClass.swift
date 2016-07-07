//
//  ASampleClass.swift
//  SwiftAssembly
//
//  Created by AugustRush on 7/2/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

class ASampleClass
{
    func aTestFunction() -> String
    {
        //_TFC13SwiftAssembly12ASampleClass13aTestFunctionfT_SS
        print("called correctly")
        return "aaaaa test"
    }
    
    func bTestFunction() -> NSString
    {
        //_TFC13SwiftAssembly12ASampleClass13bTestFunctionfT_CSo8NSString
        print("called b function correctly!!!")
        return NSString(string: "bbbbb test")
    }
    
    func cTestFunction(a: Int) -> Any? {
        //_TFC13SwiftAssembly12ASampleClass13cTestFunctionfSiGSqP_
        return nil
    }
    
    func dTestFunction() -> NSInteger
    {
        //_TFC13SwiftAssembly12ASampleClass13dTestFunctionfT_Si
        print("called b function correctly!!!")
        return 0
    }
    
    func eTestFunction(a: Int) -> Any {
        //_TFC13SwiftAssembly12ASampleClass13eTestFunctionfSiP_
        return ""
    }
    //_TFC13SwiftAssembly12ASampleClass13fTestFunctionfTSi1bGSaSS__P_
    func fTestFunction(a: Int, b: Array<String>) -> Any {
        
        return ""
    }
    
    func gTestFunction(a: Int, b: Array<Int>) -> Any {
        
        return ""
    }
}

