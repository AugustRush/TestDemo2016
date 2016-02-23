//
//  ViewController.swift
//  MetalDemo1
//
//  Created by AugustRush on 2/18/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var metalView: MetalView!
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Private methods
    
    func setUp() {
        self.view.backgroundColor = UIColor.greenColor()
        
    }

}

