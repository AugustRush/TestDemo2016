//
//  SizeView.swift
//  AutolayoutSizeDemo
//
//  Created by AugustRush on 6/10/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class SizeView: UIView {

    private var contentSize = CGSizeMake(100, 100)
    var attributes = [NSFontAttributeName:UIFont.boldSystemFontOfSize(30),NSForegroundColorAttributeName:UIColor.whiteColor()]
    var text: NSString = "" {
        didSet {
            let size = text.sizeWithAttributes(attributes)
            changeContentSize(size)
            setNeedsDisplay()
        }
    }
    
    
    override func intrinsicContentSize() -> CGSize {
        return contentSize
    }
    
    private func changeContentSize(s: CGSize) -> Void {
        CATransaction.lock()
        CATransaction.begin()
        self.contentSize = s
        self.invalidateIntrinsicContentSize()
        CATransaction.commit()
        CATransaction.unlock()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        text.drawInRect(rect, withAttributes: attributes)
    }
}
