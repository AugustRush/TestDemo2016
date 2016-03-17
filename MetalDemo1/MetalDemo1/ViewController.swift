//
//  ViewController.swift
//  MetalDemo1
//
//  Created by AugustRush on 2/18/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

import UIKit
import MetalKit
import MetalPerformanceShaders

class ViewController: UIViewController, MTKViewDelegate {

    var metablView : MTKView!
    var commondQueue : MTLCommandQueue!
    var sourceTexture : MTLTexture!
    @IBOutlet weak var blurRadius: UISlider!
    //MARK: life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMetalView()
        loadAssets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Event methods
    @IBAction func blurRadiusDidChanged(sender: AnyObject) {
        metablView.setNeedsDisplay()
    }
    //MARK: Private methods
    
    func setUpMetalView() {
        metablView = MTKView(frame: CGRectMake(0, 0, 200, 200))
        metablView.layer.borderColor = UIColor.whiteColor().CGColor
        metablView.layer.borderWidth = 5
        metablView.layer.cornerRadius = 20
        metablView.clipsToBounds = true
        view.addSubview(metablView)
        
        metablView.device = MTLCreateSystemDefaultDevice()
        
        guard let metablView = metablView where MPSSupportsMTLDevice(metablView.device) else {
            print("device not support MetalPerformanceShaders")
            return
        }
        
        metablView.delegate = self
        metablView.depthStencilPixelFormat = .Depth32Float_Stencil8
        metablView.colorPixelFormat = .BGRA8Unorm
        metablView.framebufferOnly = false

    }

    func loadAssets() {
        commondQueue = metablView.device!.newCommandQueue()
        
        let textureLoader = MTKTextureLoader(device: metablView.device!)
        let image = UIImage(named: "1234")
        let mirrorImage = UIImage(CGImage: image!.CGImage!, scale: 1, orientation: UIImageOrientation.DownMirrored)
        let scaledImage = UIImage.scaleToSize(mirrorImage,size:CGSize(width:600,height:600))
        let cgimage = scaledImage.CGImage
        
        do{
            sourceTexture = try textureLoader.newTextureWithCGImage(cgimage!, options: [:])
        } catch let error as NSError {
            fatalError("unexpected error occured \(error) \n")
        }
        
    }
    //MARK: MTKViewDelegate methods
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func drawInMTKView(view: MTKView) {
        let commondBuffer = commondQueue.commandBuffer()
        let gaussianBlur = MPSImageGaussianBlur(device: view.device!, sigma: self.blurRadius.value)
        gaussianBlur.encodeToCommandBuffer(commondBuffer, sourceTexture: sourceTexture, destinationTexture: view.currentDrawable!.texture)
        //commit
        commondBuffer.presentDrawable(view.currentDrawable!)
        commondBuffer.commit()
    }
}

extension UIImage{
    
    class func scaleToSize(image:UIImage,size:CGSize)->UIImage{
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
        
        
    }
}
