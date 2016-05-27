//
//  ViewController.swift
//  PhysicsDemo
//
//  Created by AugustRush on 5/14/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    var displaylink: CADisplayLink!
    var physic1: Physic1!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displaylink = CADisplayLink(target: self, selector: #selector(self.render))
        displaylink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        displaylink.paused = true
        
        physic1 = Physic1(view: self.blueView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(sender: AnyObject) {
        displaylink.paused = !displaylink.paused
    }

    func render() {
        physic1.onEachStep()
    }
}

struct Physic1 {
    var g: CGFloat = 0.1; // acceleration due to gravity
    var x: CGFloat = 50.0;  // initial horizontal position
    var y: CGFloat = 50.0;  // initial vertical position
    var vx: CGFloat = 2;  // initial horizontal speed
    var vy: CGFloat = 0;  // initial vertical speed
    
    weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
    
    mutating func onEachStep() -> Void {
        vy += g; // gravity increases the vertical speed
        x += vx; // horizontal speed increases horizontal position
        y += vy; // vertical speed increases vertical position
        let radius = CGRectGetHeight(self.view!.bounds)
        let canvasHeight = CGRectGetHeight(view!.superview!.bounds)
        let canvasWidth = CGRectGetWidth(view!.superview!.bounds)
        if (y > canvasHeight - radius){ // if ball hits the ground
            y = canvasHeight - radius; // reposition it at the ground
            vy *= -0.8; // then reverse and reduce its vertical speed
        }
        if (x > canvasWidth + radius){ // if ball goes beyond canvas
            x = -radius; // wrap it around
        }
        
        self.view?.center = CGPointMake(x, y)
    }
    
}

