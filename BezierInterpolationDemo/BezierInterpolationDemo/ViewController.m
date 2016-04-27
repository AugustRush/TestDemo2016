//
//  ViewController.m
//  BezierInterpolationDemo
//
//  Created by AugustRush on 4/25/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPath-Points.h"

@interface ViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIView *interpolationLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.view.bounds;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:self.shapeLayer];
    
    self.interpolationLayer = [[UIView alloc] init];
    self.interpolationLayer.frame = CGRectMake(0, 0, 20, 10);
    self.interpolationLayer.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.interpolationLayer];
    
    
//    UIBezierPath *beizerPath = [UIBezierPath bezierPath];
//    [beizerPath moveToPoint:CGPointMake(100, 100)];
//    [beizerPath addQuadCurveToPoint:CGPointMake(134, 74) controlPoint:CGPointMake(140, 134)];
//    [beizerPath addLineToPoint:CGPointMake(240, 234)];
//    [beizerPath addLineToPoint:CGPointMake(240, 334)];
//    [beizerPath addLineToPoint:CGPointMake(140, 234)];
//    [beizerPath closePath];
//    self.shapeLayer.path = beizerPath.CGPath;
    
    UIBezierPath *testPath = [UIBezierPath bezierPath];
    [testPath moveToPoint:CGPointMake(10, 245)];
//    [testPath addQuadCurveToPoint:CGPointMake(300, 350) controlPoint:CGPointMake(150, 150)];
    [testPath addCurveToPoint:CGPointMake(300, 350) controlPoint1:CGPointMake(150, 150) controlPoint2:CGPointMake(200, 200)];
    
    self.shapeLayer.path = testPath.CGPath;
    NSLog(@"all points is %@",[testPath points]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawing:(UISlider *)sender {
    
    CGFloat value = sender.value;
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.shapeLayer.path];
    CGPoint slope;
    CGPoint interPoint = [path pointAtPercent:value withSlope:&slope];
    self.interpolationLayer.center = interPoint;
    self.interpolationLayer.transform = CGAffineTransformMakeRotation(atan2f(slope.y, slope.x));
}

- (IBAction)keyframeAnimation:(id)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.shapeLayer.path;
    animation.duration = 5;
    [self.interpolationLayer.layer addAnimation:animation forKey:@"test"];
}

@end
