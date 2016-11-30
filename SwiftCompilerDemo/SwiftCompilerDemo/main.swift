//
//  main.swift
//  SwiftCompilerDemo
//
//  Created by AugustRush on 11/29/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation
import AppKit

let path = "/Users/baidu/TestDemo2016/SwiftCompilerDemo/SwiftCompilerDemo/test.bis"
let fileURL = URL.init(fileURLWithPath: path)
let inputText = try String(contentsOf: fileURL, encoding: String.Encoding.utf8)

let tokens = BSLexer.tokenlize(inputText)
print("tokens is \(tokens)")
let opNodes = try BSParser(tokens: tokens).parseToOperatorNodes()
print("operator nodes is \(opNodes)")

let value = BSInterpreter.evalute(nodes: opNodes)
print("value is \(value)")
