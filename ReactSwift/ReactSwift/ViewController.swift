//
//  ViewController.swift
//  ReactSwift
//
//  Created by AugustRush on 6/23/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

func add(a: Int, b: Int) -> Int {
    return 34
}

class ViewController: UIViewController {

    var testView: TestView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        test1()
        
        testMutating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func test1() {
        let numbers = [1,2,3,4,5,6]
        let indexes = [0,2,3,1,3,4,5]
        
        let value = indexes.map ({"\(numbers[$0])"})
        print("map result is \(value)")
        let text = value.reduce("", combine: { (a, b) -> String in
            return a + String(b)
        })
        print("reduce text is \(text)")
        
        let sum = numbers.reduce(0) {$0 + $1}
        print("numbers sum is \(sum)")
        
        let filter = numbers.filter { $0 > 1 }
        print("number fileter >1 is \(filter)")
        
        let flat = numbers.flatMap { (a) -> [Int] in
            return [a * 2]
        }
        
        print("flat a+1 is \(flat)")
        
        let array = [1,2,3,[4,5,6]]
        
        let flatArray = array.flatMap { $0 }
        print("flat array is \(flatArray)")
        
        let nestedArray = [[1,2,3],7, [4,5,6]]
        
        let flattenedArray = nestedArray.flatMap { $0 }
        
        print("flattenedArray is \(flattenedArray)")
    }
    
    
    func testMutating() {
        self.testView = TestView()
        self.testView.backgroundColor = UIColor.redColor()
        self.testView.frame = CGRect(x: 100, y: 100,width: 10, height: 10)
        self.view.addSubview(testView)
        
        self.testView.changedSize.x = 100
        
    }
}

protocol Observer {
    func complete() -> Void
    func error(error: ErrorType) -> Void
    func onNext() -> Any
}

protocol Observable {
    func subscribe() -> Observer
}

class TestView: UIView {
    var changedSize = Changed() {
        didSet {
            self.bounds.size = CGSize(width: changedSize.x,height: changedSize.y)
        }
    }
}

struct Changed {
    var x: Double = 10
    var y: Double = 10
    
    mutating func x(v: Double) {
        self.x = v
    }
    
    mutating func setY(v: Double) {
        self.y = v
    }
}
