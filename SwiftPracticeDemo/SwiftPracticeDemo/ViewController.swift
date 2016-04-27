//
//  ViewController.swift
//  SwiftPracticeDemo
//
//  Created by AugustRush on 4/15/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 9, *) {
            self.logAString(str: ">>>>IOS 9")
        }else{
            self.logAString(str: "below IOS 9")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: test methos
    
    func logAString(str name : String) {
        print("name is \(name)");
    }

}

