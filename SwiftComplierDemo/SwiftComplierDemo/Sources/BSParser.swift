//
//  BSParser.swift
//  SwiftCompilerDemo
//
//  Created by AugustRush on 11/29/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

public enum BSValue {
    case number(Int)
    case undefined(String)
}

public class BSOperatorNode {
    public var op: String = ""
    public var values = [BSValue]()
}

public enum BSParserError: Error {
    case unexpectedToken
}

public struct BSParser {
    
    var tokens: [BSToken]
    
    init(tokens: [BSToken]) {
        self.tokens = tokens
    }
    
    
    func parseToOperatorNodes() throws -> [BSOperatorNode] {
        if tokens.count == 0 {
            throw BSParserError.unexpectedToken
        }
        
        var nodes = [BSOperatorNode]()
        var templateNodes = [BSOperatorNode]()
        
        tokens.forEach { (t) in
            switch t {
            case .parensOpen:
                let node = BSOperatorNode()
                templateNodes.append(node)
            case .parensClosed:
                let node = templateNodes.last
                nodes.append(node!)
                templateNodes.removeLast()
            case .op(let op):
                let node = templateNodes.last
                node?.op = op
            case .number(let n):
                let node = templateNodes.last
                node?.values.append(BSValue.number(n))
            }
        }
        
        return nodes
    }
}
