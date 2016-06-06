//
//  ViewController.m
//  JSCoreOC
//
//  Created by AugustRush on 6/5/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "JSOCTestModel.h"

@interface ViewController ()

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) JSOCTestModel *testModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self jsCallObjectiveCBlock];
    [self JSExportTest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - .....

- (void)ocCalljs {
    self.context = [[JSContext alloc] init];
    
    //设置异常处理
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    
    
    NSString *js = @"function add(a,b) { return a+b }";
    [self.context evaluateScript:js];
    
    JSValue *value = [self.context[@"add"] callWithArguments:@[@1,@2]];
    
    NSLog(@"value is %d",[value toInt32]);
}

- (void)jsCallObjectiveCBlock {

    self.context = [[JSContext alloc] init];
    
    //设置异常处理
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    
    
    NSInteger (^test)(NSString *des) = ^NSInteger(NSString *des) {
        NSLog(@"%s des is %@",__PRETTY_FUNCTION__,des);
        return 100;
    };
    
    self.context[@"aTest"] = test;
    
    NSLog(@"test a block is %d",[[self.context evaluateScript:@"aTest('kjsdhfkjd')"] toInt32]);
    
}

- (void)JSExportTest {
    self.context = [[JSContext alloc] init];
    
    //设置异常处理
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        [JSContext currentContext].exception = exception;
        NSLog(@"exception:%@",exception);
    };
    
    //oc 对象
    self.testModel = [[JSOCTestModel alloc] init];
    //将obj添加到context中
    self.context[@"OCModel"] = self.testModel;
    //JS里面调用Obj方法，并将结果赋值给Obj的sum属性
    [self.context evaluateScript:@"OCModel.sum = OCModel.add(2,3)"];


    NSLog(@"model is %@",self.testModel);
}

@end
