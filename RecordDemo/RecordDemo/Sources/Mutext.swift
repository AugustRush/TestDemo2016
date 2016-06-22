//
//  Mutext.swift
//  Record
//
//  Created by AugustRush on 6/18/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

class Mutext {
    
    private var _mutex: pthread_mutex_t = pthread_mutex_t()

    init() {
        pthread_mutex_init(&_mutex, nil)
    }
    
    func lock() {
        pthread_mutex_lock(&_mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&_mutex)
    }
    
    func destory() {
        pthread_mutex_destroy(&_mutex)
    }
    
    deinit {
        destory()
    }
}

class RW_Mutext {
    
    private var _mutex: pthread_rwlock_t = pthread_rwlock_t()
    
    init() {
        pthread_rwlock_init(&_mutex, nil)
    }
    
    func rd_lock() {
        pthread_rwlock_rdlock(&_mutex)
    }
    
    func wr_lock() {
        pthread_rwlock_wrlock(&_mutex)
    }
    
    func unlock() {
        pthread_rwlock_unlock(&_mutex)
    }
    
    func destory() {
        pthread_rwlock_destroy(&_mutex)
    }
    
    deinit {
        destory()
    }
}
