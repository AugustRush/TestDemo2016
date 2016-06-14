//
//  demoView1.swift
//  CoreGraphicsDemo
//
//  Created by AugustRush on 6/11/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class demoView1: UIView {

    var image: UIImage?
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 0.2, 0.2, 0.2, 1.0)
        CGContextFillRect(context, CGRectMake(0, 0, 100, 100))
        CGContextSetRGBFillColor(context, 0.8, 0.8, 0.8, 1.0)
        CGContextFillRect(context, CGRectMake(100, 0, 100, 100))

        let image = CGBitmapContextCreateImage(context)
        UIGraphicsEndImageContext()
        
        self.image = UIImage(CGImage: image!)
    }
}
