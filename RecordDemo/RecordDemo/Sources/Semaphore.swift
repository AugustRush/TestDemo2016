//
//  Semaphore.swift
//  RecordDemo
//
//  Created by AugustRush on 7/4/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

class Semaphore {
    private let _semaphore = dispatch_semaphore_create(1)
    
    func lock() -> Int {
        return dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER)
    }
    
    func unlock() -> Int {
        return dispatch_semaphore_signal(_semaphore)
    }
}