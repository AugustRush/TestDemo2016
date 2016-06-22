//
//  ViewController.swift
//  RecordDemo
//
//  Created by AugustRush on 6/18/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let queue1 = dispatch_queue_create("123", DISPATCH_QUEUE_CONCURRENT)
    let queue2 = dispatch_queue_create("1234", DISPATCH_QUEUE_CONCURRENT)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.greenColor()
        let record = MemoryRecord.sharedRecord
        
        record.set("1111", forKey: "abcd")
        record.set("2222", forKey: "abcc")
        record.set("3333", forKey: "abcd")
        record.set("4444", forKey: "abcc")
        
        dispatch_async(queue1) {
            print("start write.....\(CACurrentMediaTime())")
            for index in 0...1000000 {
                let str = String(index)
                record.set(str, forKey: "test" + str )
            }
            print("end write.......\(CACurrentMediaTime())")
            
            print("start read.....\(CACurrentMediaTime())")
            for index in 0...record.count {
                let str = String(index)
                let _ = record.value(forKey: "test" + str)
            }
            print("end read.......\(CACurrentMediaTime())")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touched")
        MemoryRecord.sharedRecord.removeAll()
    }
}

