//
//  Animator.swift
//  SwiftAnimation
//
//  Created by AugustRush on 4/24/16.
//  Copyright © 2016 August. All rights reserved.
//

import QuartzCore

class Animator {
    //MARK: property's
    private lazy var displayLink : CADisplayLink = {
        let displayLink = CADisplayLink(target : self, selector: #selector(self.render))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode : NSRunLoopCommonModes)
        return displayLink
    }()
    
    private lazy var animations : [Renderable] = Array()
    
    //MARK: singleton
    static let shared = Animator()
    
    //MARK: private methods
    @objc private func render() -> Void {
        for A in animations {
            A.render()
        }
    }
    
    //MARK: public methods
    
    func addAnimation<R : Renderable>(a : R) -> Void {
        print("a is \(a)")
        animations.append(a)
        displayLink.paused = false
    }
}