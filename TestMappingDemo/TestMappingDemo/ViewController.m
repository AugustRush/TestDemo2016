//
//  ViewController.m
//  TestMappingDemo
//
//  Created by AugustRush on 12/20/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self testAsyncGroupWait];
    NSLog(@"eeeee");
}

- (void)testAsyncGroupWait {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"aaa");
        sleep(1);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"bbb");
        sleep(1);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"ccc");
        sleep(1);
    });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
