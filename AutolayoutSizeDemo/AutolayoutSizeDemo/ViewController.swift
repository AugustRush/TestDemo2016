//
//  ViewController.swift
//  AutolayoutSizeDemo
//
//  Created by AugustRush on 6/10/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sizeView: SizeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        let texts: [NSString] = ["123456789","qwertyuiop","hello my name is August","jkjsdhfj skdjfskjhf ursjkfsjdg sjdfskusdfj"]
        let t = texts[Int(arc4random()%4)]
        sizeView.text = t
        
    }
}

