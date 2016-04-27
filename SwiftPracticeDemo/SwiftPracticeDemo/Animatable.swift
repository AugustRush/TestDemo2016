//
//  Animatable.swift
//  SwiftPracticeDemo
//
//  Created by AugustRush on 4/15/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

typealias TimingFunction = (Float) -> (Float)

public enum TimingFunctionType {
    case linear
    
    func easing(type : TimingFunctionType) -> TimingFunction {
        switch type {
        case .linear:
            return {(f : Float) in return f};
        }
    }
}

public protocol _Animatable {
    func animateTo<T : _Interpolatable>(toValue : T, easingType : TimingFunctionType) -> Void;
}

public protocol _Interpolatable {
    func interpolate(change : Self , process : Float, easing : TimingFunctionType?) -> Self;
}