//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by AugustRush on 5/16/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationView: UIView!
    
    var animator = UIDynamicAnimator()
    
    var snaped: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     */

    @IBAction func buttonClicked(sender: AnyObject) {
        
//        gravity()
//        gravityAndCollision()
//        snap()
//        attachment()
//        push()
        gravityAndCollsionAndItemBehavior()
//        snapAndItemBehavior()
//        snapAndGravity()
        
//        customItem()
    }
    
    func gravity() {
        animator.removeAllBehaviors()
        let gravity = UIGravityBehavior()
        gravity.addItem(self.animationView)
        animator.addBehavior(gravity)
    }
    
    func gravityAndCollision() {
        animator.removeAllBehaviors()
        //
        let gravity = UIGravityBehavior()
        gravity.addItem(self.animationView)
        animator.addBehavior(gravity)
        //
        let collision = UICollisionBehavior()
        collision.addItem(self.animationView)
        let path = UIBezierPath(rect: self.view.bounds)
        collision.addBoundaryWithIdentifier("testCollisionBoundary", forPath: path)
        animator.addBehavior(collision)
    }
    
    func snap() {
        animator.removeAllBehaviors()
        //
        let x =  CGFloat(arc4random() % 300)
        let y =  CGFloat(arc4random() % 500)
        let snap = UISnapBehavior(item: self.animationView,snapToPoint: CGPointMake(x, y))
        animator.addBehavior(snap)
    }
    
    func attachment() {
        animator.removeAllBehaviors()
        //
        let x =  CGFloat(arc4random() % 300)
//        let y =  CGFloat(arc4random() % 500)
        let attachment = UIAttachmentBehavior(item: self.animationView,attachedToAnchor:CGPointMake(160, 80))
        attachment.length = x
        attachment.damping = 0.3
        attachment.frequency = 2
        animator.addBehavior(attachment)
        //
        
    }
    
    func push() {
        animator.removeAllBehaviors()
        //
        let x =  CGFloat(arc4random() % 500) - 250
        let y =  CGFloat(arc4random() % 500) - 250
        let push = UIPushBehavior()
        push.addItem(self.animationView)
        push.magnitude = 2
        push.pushDirection = CGVectorMake(x, y)
        animator.addBehavior(push)
        
        //
        let collision = UICollisionBehavior()
        collision.addItem(self.animationView)
        let path = UIBezierPath(rect: self.view.bounds)
        collision.addBoundaryWithIdentifier("testCollisionBoundary", forPath: path)
        animator.addBehavior(collision)
    }
    
    func gravityAndCollsionAndItemBehavior() {
        animator.removeAllBehaviors()
        //
        let gravity = UIGravityBehavior()
        gravity.addItem(self.animationView)
        animator.addBehavior(gravity)
        //
        let collision = UICollisionBehavior()
        collision.addItem(self.animationView)
        let path = UIBezierPath(rect: self.view.bounds)
        collision.addBoundaryWithIdentifier("testCollisionBoundary", forPath: path)
        animator.addBehavior(collision)
        //
        let itemBehavior = UIDynamicItemBehavior()
        itemBehavior.addItem(self.animationView)
        itemBehavior.elasticity = 1;
//        itemBehavior.friction = 0.5;
        itemBehavior.density = 1;
        itemBehavior.resistance = 10;
        itemBehavior.angularResistance = 0.5;//no effect but has angular
        animator.addBehavior(itemBehavior)
    }
    
    func snapAndItemBehavior() {
        animator.removeAllBehaviors()
        //
        let x =  CGFloat(arc4random() % 300)
        let y =  CGFloat(arc4random() % 500)
        let snap = UISnapBehavior(item: self.animationView,snapToPoint: CGPointMake(x, y))
        animator.addBehavior(snap)
        
        //
        let itemBehavior = UIDynamicItemBehavior()
        itemBehavior.addItem(self.animationView)
        itemBehavior.elasticity = 1;
        itemBehavior.friction = 100;
        itemBehavior.density = 1;
        itemBehavior.resistance = 100;
        itemBehavior.angularResistance = 1;//no effect but has angular
        animator.addBehavior(itemBehavior)
    }
    
    func snapAndGravity() {
        animator.removeAllBehaviors()
        //
        let x =  CGFloat(arc4random() % 300)
        let y =  CGFloat(arc4random() % 500)
        let snap = UISnapBehavior(item: self.animationView,snapToPoint: CGPointMake(x, y))
        animator.addBehavior(snap)
        
        //
        let gravity = UIGravityBehavior()
        gravity.addItem(self.animationView)
        animator.addBehavior(gravity)
    }
    
    func customItem() {
        let interaction = InteractionItem(render: { (p) in
            self.animationView.transform = CGAffineTransformMakeScale(p.x/100, p.x/100)
            self.animationView.center = p
        })
        
        snaped = UISnapBehavior(item: interaction,snapToPoint:self.animationView.center)
        snaped.damping = 0.5
        animator.addBehavior(snaped)
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        let point = touches.first?.locationInView(self.view)
        
        snaped.snapPoint = point!
    }
}

