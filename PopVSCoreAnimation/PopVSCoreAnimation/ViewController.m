//
//  ViewController.m
//  Pop&CoreAnimation
//
//  Created by AugustRush on 15/10/25.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

// copy from https://medium.com/@beefon/should-you-use-pop-b986b10d4079#.razkc4hgg

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) UIView *caView;
@property (nonatomic, strong) UIView *timerView;

@property (nonatomic, assign) NSTimeInterval start;

@end

@implementation ViewController

static CGFloat const kDuration = 2.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.caView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    self.caView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.caView];
    
    self.timerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 100 - 50, 50, 100, 100)];
    self.timerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.timerView];
    
    [self performSelector:@selector(repeatedlyBlockMainThread) withObject:nil afterDelay:3];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.toValue = @(M_PI);
    anim.duration = kDuration;
    anim.repeatCount = 500;
    [self.caView.layer addAnimation:anim forKey:@"anim"];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkFire:)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.start = CACurrentMediaTime();
}

- (void)displayLinkFire:(CADisplayLink *)sender
{
    CGFloat progress = (sender.timestamp - self.start)/kDuration;
    CGAffineTransform t = CGAffineTransformMakeRotation(progress * M_PI);
    self.timerView.transform = t;
}

- (void)repeatedlyBlockMainThread
{
    NSLog(@"blocking main thread!");
    [NSThread sleepForTimeInterval:0.25];
    [self performSelector:@selector(repeatedlyBlockMainThread) withObject:nil afterDelay:1];
}

@end
