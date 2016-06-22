//
//  ViewController.m
//  CIFilterDemo
//
//  Created by AugustRush on 5/27/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonnull, strong) UIImage *originImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.originImage = [UIImage imageNamed:@"test"];
//    //将UIImage转换成CIImage
//    CIImage *ciImage = [[CIImage alloc] initWithImage:originImage];
//    
//    //创建滤镜
//    CIFilter *filter = [CIFilter filterWithName:@"CIMotionBlur" keysAndValues:kCIInputImageKey, ciImage, nil];
//    [filter setValue:[NSNumber numberWithFloat: 2] forKey: @"kCIInputRadiusKey"];
//    //已有的值不改变，其他的设为默认值
//    [filter setDefaults];
//    
//    //获取绘制上下文
//    CIContext *context = [CIContext contextWithOptions:nil];
//    
//    //渲染并输出CIImage
//    CIImage *outputImage = [filter outputImage];
//    
//    //创建CGImage句柄
//    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    
//    //获取图片
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    
//    //释放CGImage句柄
//    CGImageRelease(cgImage);
   
    
    _imageView.image = [self blurWithCoreImage:self.originImage radius:10];
}

- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage radius:(CGFloat)radius
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@40 forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, self.view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, self.view.frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}
- (IBAction)valueChanged:(UISlider *)sender {
    
    CGFloat value = sender.value;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:_originImage.CGImage];
    
    //setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:value] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    //CIGaussianBlur has a tendency to shrink the image a little, this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    //add our blurred image to the scrollview
     _imageView.image = [UIImage imageWithCGImage:cgImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
