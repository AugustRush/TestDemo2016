//
//  ViewController.m
//  ViewController
//
//  Created by AugustRush on 5/24/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "Controller1.h"

@interface ViewController ()

@property (nonatomic, strong) Controller1 *controller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeController:nil];
//    });
    
//    self.view.nextResponder = [[Controller1 alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"self parent controller is %@",self.parentViewController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addController:(id)sender {
    _controller = [[Controller1 alloc] init];
    [_controller willMoveToParentViewController:self];
    [self addChildViewController:_controller];
    [self.view addSubview:_controller.view];
    _controller.view.frame  = CGRectMake(0, 0, 320, 200);
    [_controller didMoveToParentViewController:self];
    
    
    Controller1 *subController = [[Controller1 alloc] init];
    [_controller addChildViewController:subController];
    [_controller.view addSubview:subController.view];
    [subController didMoveToParentViewController:_controller];
    subController.view.frame = CGRectMake(0, 0, 100, 100);
    subController.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)removeController:(id)sender {
//    [self.controller willMoveToParentViewController:nil];
//    [self.controller removeFromParentViewController];
    [self.controller.view  removeFromSuperview];
//    [self.controller didMoveToParentViewController:nil];
    
    self.controller = nil;
}

@end
