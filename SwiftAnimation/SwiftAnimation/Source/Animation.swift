//
//  Animation.swift
//  SwiftAnimation
//
//  Created by AugustRush on 4/24/16.
//  Copyright © 2016 August. All rights reserved.
//

import Foundation

public struct Animation<T : Interpolation> : Renderable {
    
    var from : T!
    var to : T!
    var easing : ((Double)->Double)!
    
    
    //MARK: Renderable
    
    public func render() {
        print("render \(self)")
    }
}