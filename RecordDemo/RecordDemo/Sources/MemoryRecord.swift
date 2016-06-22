//
//  MemoryRecord.swift
//  Record
//
//  Created by AugustRush on 6/18/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

public class MemoryRecord {
    public static let sharedRecord = MemoryRecord()
    //MARK: Public properties
    public var lifetimeLimit: NSTimeInterval {
        set {
        
        }
        
        get {
            return 0
        }
    }
    
    public var costLimit: UInt {
        set {
        
        }
        
        get {
            return 0
        }
    }
    
    public var countLimit: UInt {
        set {
        
        }
        
        get {
            return 0
        }
    }
    
    public var clearAllRecordsWhenMemoryWarning: Bool {
        set {
        
        }
        
        get {
            return true
        }
    }
    
    public var count: Int {
        get {
            mutext.lock()
            let c = _LRUMap.count()
            mutext.unlock()
            return c
        }
    }
    
    //MARK: Private properties
    private let mutext = Mutext()
    private var _LRUMap = LRUMap()
    
    //MARK: Public methods
    
    func set(value: Any, forKey key: String) -> Void {
        mutext.lock()
        let node = LinkNode(key: key,value: value)
        _LRUMap.updateNode(node)
        mutext.unlock()
    }
    
    @warn_unused_result
    func value(forKey key: String) -> Any? {
        mutext.lock()
        let node = _LRUMap.value(forKey: key)
        mutext.unlock()
        return node?.value
    }
    
    func removeValue(forKey key: String) -> Any? {
        mutext.lock()
        let node = _LRUMap.removeValue(forKey: key)
        mutext.unlock()
        return node?.value
    }
    
    func removeAll() {
        if count > 0 {
            mutext.lock()
            _LRUMap.removeAll()
            mutext.unlock()
        }
    }
    
}
