//
//  Controller1.m
//  ViewController
//
//  Created by AugustRush on 5/24/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "Controller1.h"

@implementation Controller1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    NSLog(@"touch moved");
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
