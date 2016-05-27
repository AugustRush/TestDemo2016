//
//  ViewController.swift
//  JSDemo
//
//  Created by AugustRush on 5/7/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {

    let context = JSContext()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(self.showAlert)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let simplifyString: @convention(block) String -> String = { input in
//            let mutableString = NSMutableString(string: input) as CFMutableStringRef
//            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
//            CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
//            return mutableString as String
            self.showAlert()
            return ""
        }
        context.setObject(unsafeBitCast(simplifyString, AnyObject.self), forKeyedSubscript: "simplifyString")
        
        print(context.evaluateScript("simplifyString('안녕하새요!')"))
        // annyeonghasaeyo!
    }
    
    dynamic func showAlert() {
        let alert = UIAlertController(title: "title",message: "message text",preferredStyle: .Alert);
        self.showViewController(alert, sender: alert)
    }

}

