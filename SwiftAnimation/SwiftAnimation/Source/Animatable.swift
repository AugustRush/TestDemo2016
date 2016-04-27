//
//  Animatable.swift
//  SwiftAnimation
//
//  Created by AugustRush on 4/24/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation


public protocol Renderable {
    func render() -> Void;
}

public protocol Animatable {
    func animateTo(_ : Self) -> Void;
}

public protocol Interpolation {
    func interpolation(change : Self, progress : Double, easing : ((Double)->Double)) -> Self;
}