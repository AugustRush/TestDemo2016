//
//  Value+Animatable.swift
//  SwiftAnimation
//
//  Created by AugustRush on 4/24/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

extension Float : Animatable , Interpolation {
    public func animateTo(value : Float) {
        
    }
    
    public func interpolation(change: Float, progress: Double, easing: ((Double) -> Double)) -> Float {
        return 0.0
    }
}

extension CGFloat : Animatable, Interpolation {
    public func animateTo(value : CGFloat) {
        var animation : Animation<CGFloat> = Animation()
        animation.from = self
        animation.to = value
        animation.easing = {(p : Double) in
            return p
        }
        
        Animator.shared.addAnimation(animation)
        print("animation is \(animation)")
    }
    
    public func interpolation(change: CGFloat, progress: Double, easing: ((Double) -> Double)) -> CGFloat {
        return 0.0
    }
}