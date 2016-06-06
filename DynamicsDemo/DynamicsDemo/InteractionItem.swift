//
//  InteractionItem.swift
//  DynamicsDemo
//
//  Created by AugustRush on 6/1/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class InteractionItem: NSObject, UIDynamicItem {
    
    var render: (p: CGPoint) -> Void
    
    init(render: ((p: CGPoint) -> Void)) {
        self.render = render
    }
    
    //MARK: UIDynamicItem protocol
    var center: CGPoint = CGPointZero {
        didSet {
            render(p: center)
        }
    }
    
    var transform: CGAffineTransform = CGAffineTransformIdentity
    var bounds: CGRect {
        get {
            return CGRectMake(0.0, 0.0, 100.0, 100.0)
        }
    }

}
