//
//  MetalView.swift
//  MetalDemo1
//
//  Created by AugustRush on 2/18/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

class MetalView: UIView {
    
    lazy var metalLayer : CAMetalLayer = {
        let layer = self.layer as! CAMetalLayer
        return layer
    }()
    
    let device = MTLCreateSystemDefaultDevice()
    
    override class func layerClass() -> AnyClass {
        return CAMetalLayer.self
    }
    
    override func didMoveToWindow() {
        redraw()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.metalLayer.device = device
        self.metalLayer.pixelFormat = MTLPixelFormat.BGRA8Unorm
    }
}
