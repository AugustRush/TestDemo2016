//
//  BSLexer.swift
//  SwiftCompilerDemo
//
//  Created by AugustRush on 11/29/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

public enum BSToken {
    case parensOpen
    case parensClosed
    case op(String)
    case number(Int)
}

public class BSLexer {
    public static func tokenlize(_ input: String) -> [BSToken] {
        
        var tokens = [BSToken]()
        var tempNumStr = String()

        
        input.characters.forEach { (ch) in
            switch ch {
            case "(":
                tokens.append(BSToken.parensOpen)
            case ")":
                tempNumStrHandler(numStr: &tempNumStr, tokens: &tokens)
                tokens.append(BSToken.parensClosed)
            case "s":
                tokens.append(BSToken.op(String(ch)))
            case "0"..."9":
                tempNumStr.append(ch)
            case " ":
                tempNumStrHandler(numStr: &tempNumStr, tokens: &tokens)
            default:
                print("default \(ch)")
            }
        }
        
        return tokens
    }
    
    private static func tempNumStrHandler(numStr: inout String, tokens: inout [BSToken]) {
        if !numStr.isEmpty {
            tokens.append(BSToken.number(Int(numStr)!))
            numStr.removeAll()
        }
    }
}
