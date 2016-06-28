//
//  ViewController.m
//  MsgSendDemo
//
//  Created by AugustRush on 6/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
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
    
    NSLog(@"UIView alloc is %@",[UIView alloc]);
    
    class_addProtocol([UIView class], @protocol(UIViewExport));
    
    JSContext *context = [[JSContext alloc] init];
    context[@"UIView"] = [UIView class];
    
    [context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"context error is %@",context.exception);
    }];
    UIView *view = [[context evaluateScript:@"UIView.new()"] toObject];
    UIView *view1 = [[context evaluateScript:@"UIView.alloc().init()"] toObject];
    NSLog(@"jsView is %@,\n view1 is %@",view,view1);
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"js"];
    NSString *mustacheJSString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    JSValue *scriptValue = [context evaluateScript:mustacheJSString];
    NSObject *object = [context[@"view"] toObject];
    NSLog(@"object is %@",object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
