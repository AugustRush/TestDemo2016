//
//  ViewController.m
//  TestHotPatch
//
//  Created by AugustRush on 4/15/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testCrash1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testCrash1 {
    NSArray *array = @[@1,@"asd"];
    NSLog(@"array[2] is %@",array[2]);
}

@end
