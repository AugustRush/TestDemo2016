//
//  ViewController.swift
//  CleanScreen_Metal
//
//  Created by AugustRush on 4/5/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit
import MetalKit
import QuartzCore

class ViewController: UIViewController {

    let metalView = MTKView()
    var device : MTLDevice!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        device = metalView.device!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

