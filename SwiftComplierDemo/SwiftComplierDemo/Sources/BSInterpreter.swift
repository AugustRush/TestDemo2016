//
//  BSInterpreter.swift
//  SwiftCompilerDemo
//
//  Created by AugustRush on 11/29/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

public class BSInterpreter {
    
    public static func evalute(nodes: [BSOperatorNode]) -> Int {
        var target = 0
        nodes.forEach { (node) in
            node.values.forEach({ (val) in
                switch val {
                case .number(let n):
                    target += n
                case .undefined(let err):
                    print("undefined error \(err)")
                }
            })
        }
        
        return target
    }
}
