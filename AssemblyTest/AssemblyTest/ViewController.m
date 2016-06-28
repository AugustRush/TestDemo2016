//
//  ViewController.m
//  AssemblyTest
//
//  Created by AugustRush on 6/27/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import <objc/message.h>

@implementation ViewController

void fooTestAsm();
int testAddAsm(int a, int b);
int testAddAsm1(int a, int b, int c);
int testAddAsm4(int a, int b, int c, int d);
int testAddAsm5(int a , int b, int c, int d, int e, int f);
int sumAsm(int first, ... );


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    int b = testAddAsm(1, 2);
//    NSLog(@" b is %d",b);
//    int c = testAddAsm1(1, 2, 3);
//    NSLog(@" c is %d",c);
//    
//    int d = testAddAsm4(1, 2, 3, 4);
//    NSLog(@" d is %d",d);
//    
//    int e = testAddAsm5(1, 2, 3, 4, 5, 6);
//    NSLog(@" e is %d",e);
//    
//    int s = sumAsm(1, 2, 3, 4, 5, 6,1,-1);
//    NSLog(@"sum is %d",s);
    
    //
//    id model = [[NSClassFromString(@"TestModel1") alloc] init];
//    NSInteger test = [model fooWithBar:1 baz:2];
//    //test model is TestModel1 346056 如果汇编直接hook返回会打印这样
//    //test model is <TestModel1: 0x14686f00> 88 正常情况下会打印这句
//    NSLog(@"test model is %@ %d",model,test);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
