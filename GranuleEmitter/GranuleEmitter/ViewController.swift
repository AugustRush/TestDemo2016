//
//  ViewController.swift
//  GranuleEmitter
//
//  Created by AugustRush on 4/2/16.
//  Copyright © 2016 August. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emitterLayer : CAEmitterLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emitterLayer = CAEmitterLayer()
        emitterLayer!.frame = self.view.bounds
        emitterLayer?.emitterShape = kCAEmitterLayerCuboid
        emitterLayer?.emitterMode = kCAEmitterLayerSurface
        emitterLayer?.renderMode = kCAEmitterLayerBackToFront
        emitterLayer?.seed = 10
        emitterLayer?.emitterPosition = CGPointMake(self.view.center.x, 50)
        emitterLayer?.emitterDepth = 100
        emitterLayer?.emitterZPosition = 150
        emitterLayer?.emitterSize = CGSizeMake(50, 50)
        self.view.layer.addSublayer(emitterLayer!)
        
        var cells : [CAEmitterCell] = Array()
        
        for _ in 1..<5 {
            let emitterCell = CAEmitterCell()
            emitterCell.contents = UIImage(named: "flower")?.smallImage(CGSizeMake(20, 20)).CGImage
            emitterCell.birthRate = 60
            emitterCell.lifetime = 3
            emitterCell.lifetimeRange = 3
            emitterCell.xAcceleration = 20
            emitterCell.yAcceleration = 120
            emitterCell.velocity = 40
            emitterCell.emissionLongitude = CGFloat(-M_PI) //向左
            emitterCell.velocityRange = 200.0   //随机速度 -200+20 --- 200+20
            emitterCell.emissionRange = CGFloat(M_PI_2) //随机方向 -pi/2 --- pi/2
            
            emitterCell.redRange = 0.3
            emitterCell.greenRange = 0.3
            emitterCell.blueRange = 0.3
            emitterCell.scale = 0.9
            emitterCell.scaleRange = 0.9  //0 - 1.6
            emitterCell.scaleSpeed = -0.1 //逐渐变小
            
            emitterCell.alphaRange = 0.75   //随机透明度
            emitterCell.alphaSpeed = -0.15  //逐渐消失
            
            emitterCell.spin = 1
            emitterCell.spinRange = 8
            
            cells.append(emitterCell)
        }
        
        emitterLayer?.emitterCells = cells
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

