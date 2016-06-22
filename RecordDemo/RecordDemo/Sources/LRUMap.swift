//
//  HeadTailLink.swift
//  RecordDemo
//
//  Created by AugustRush on 6/19/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation
import UIKit

internal class LRUMap {
    private var _nodes: [String:LinkNode] = Dictionary()
    private weak var head: LinkNode?
    private weak var tail: LinkNode?
    
    func insertAtHead(node: LinkNode) -> Void {
        _nodes[node.key] = node
        if head != nil {//Not the first time to insert
            node.next = head!
            head!.prev = node
            head = node
        } else {//should be first time to insert
            head = node
            tail = node
        }
    }
    
    func updateNode(node: LinkNode) -> Void {
        let oldNode = _nodes[node.key]
        if let old = oldNode {
            old.value = node.value
            old.time = CACurrentMediaTime()
            moveNodeToHead(old)
        } else {
            insertAtHead(node)
        }
    }
    
    func moveNodeToHead(node: LinkNode) -> Void {
        guard let first = head where first == node else {
            node.next?.prev = node.prev
            node.prev?.next = node.next
            node.next = head
            head?.prev = node
            head = node
            return
        }
    }
    
    func value(forKey key: String) -> LinkNode? {
        return _nodes[key]
    }
    
    func removeValue(forKey key: String) -> LinkNode? {
        return _nodes.removeValueForKey(key)
    }
    
    func removeAll() {
        _nodes.removeAll()
        head = nil
        tail = nil
    }
    
    func count() -> Int {
        return _nodes.count
    }
}

internal class LinkNode {
    var value: Any
    var key: String
    var cost = UInt(0)
    var time = CACurrentMediaTime()
    //
    weak var prev: LinkNode?
    weak var next: LinkNode?
    
    init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
}

func == (lhs: LinkNode,rhs: LinkNode) -> Bool {
    return (unsafeAddressOf(lhs) == unsafeAddressOf(rhs))
}