//
//  ViewController.swift
//  CoreGraphicsDemo
//
//  Created by AugustRush on 6/11/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var view1: demoView1!
    @IBOutlet weak var imageView1: UIImageView!

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
        
        self.imageView1.image = view1.image
    }

}

