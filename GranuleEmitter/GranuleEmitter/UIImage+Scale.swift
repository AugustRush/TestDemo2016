//
//  UIImage+Scale.swift
//  GranuleEmitter
//
//  Created by AugustRush on 4/2/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

extension UIImage {

    func smallImage(size : CGSize) -> UIImage {
        
        if size.width > self.size.width {
            return self;
        }
        
        UIGraphicsBeginImageContext(size)
        drawInRect(CGRectMake(0, 0, size.width, size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}