//
//  ViewController.m
//  MsgSendDemo
//
//  Created by AugustRush on 6/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
//#import <objc/runtime.h>
#import <objc/message.h>

#define TYPE(...)

#define MsgSend1(caller,method,arg) (((id(*)(__typeof__(caller),SEL,__typeof__(arg)))objc_msgSend)(caller,@selector(method),arg))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    id r = (((id(*)(id,SEL,id))objc_msgSend)(self.view,@selector(setBackgroundColor:),[UIColor purpleColor]));
    id r = MsgSend1(self.view, setBackgroundColor:, [UIColor redColor]);
    NSLog(@"result is %@",r);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
