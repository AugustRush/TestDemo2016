
//
//  ViewController.m
//  JSCoreOC
//
//  Created by AugustRush on 6/5/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "JSContextModel.h"
#import "JSOCTestModel.h"
#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@property(nonatomic, strong) JSContext *context;
@property(nonatomic, strong) JSOCTestModel *testModel;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  //    void(^testBinding)(ViewController *controller) = ^(ViewController
  //    *controller){
  //        NSLog(@"view controller is %@",controller);
  //
  //    };

  //    IMP implemention = imp_implementationWithBlock(testBinding);
  //
  ////    Method method = class_getInstanceMethod([ViewController class],
  ///@selector(ocCalljs));
  //    class_addMethod([ViewController class], @selector(testBlock:),
  //    implemention, "v@:v");
  //
  //    [self performSelectorOnMainThread:@selector(testBlock:) withObject:nil
  //    waitUntilDone:YES];
  //    [self jsCallObjectiveCBlock];
  //    [self JSExportTest];
  //    [self ocCalljs];

      [self JSCreateView];

//  [self customTest];
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
    NSLog(@"exception:%@", exception);
  };

  NSString *js = @"function add(a,b) { return a+b }";
  [self.context evaluateScript:js];

  JSValue *value = [self.context[@"add"] callWithArguments:@[ @1, @2 ]];

  NSLog(@"value is %d", [value toInt32]);
}

- (void)jsCallObjectiveCBlock {

  self.context = [[JSContext alloc] init];

  //设置异常处理
  self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
    [JSContext currentContext].exception = exception;
    NSLog(@"exception:%@", exception);
  };

  NSInteger (^test)(NSString *des) = ^NSInteger(NSString *des) {
    NSLog(@"%s des is %@", __PRETTY_FUNCTION__, des);
    return 100;
  };

  self.context[@"aTest"] = test;

  NSLog(@"test a block is %d",
        [[self.context evaluateScript:@"aTest('kjsdhfkjd')"] toInt32]);
}

- (void)JSExportTest {
  self.context = [[JSContext alloc] init];

  //设置异常处理
  self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
    [JSContext currentContext].exception = exception;
    NSLog(@"exception:%@", exception);
  };

  //    //oc 对象
  //
  //    self.testModel = [[JSOCTestModel alloc] init];
  //将obj添加到context中
  self.context[@"OCClass"] = [JSOCTestModel class];
  // JS里面调用Obj方法，并将结果赋值给Obj的sum属性
  self.testModel =
      [[self.context evaluateScript:@"OCClass.newObject(0)"] toObject];

  self.context[@"OCModel"] = self.testModel;
  [self.context evaluateScript:@"OCModel.sum = OCModel.add(2,3)"];

  NSLog(@"model is %@", self.testModel);
}

- (void)JSCreateView {

  self.context = [[JSContext alloc] init];

  [self.context setExceptionHandler:^(JSContext *context, JSValue *value) {
    NSLog(@"exception:%@ value is %@", context.exception, value);
  }];

  self.context[@"NewObject"] = ^id(NSString *className) {
    Class class = NSClassFromString(className);
    return [[class alloc] init];
  };

  // 1
  UIButton *button =
      [[self.context evaluateScript:@"NewObject('UIButton')"] toObject];
  button.frame = CGRectMake(100, 100, 100, 100);
  button.backgroundColor = [UIColor redColor];
  [button setTitle:@"test button" forState:UIControlStateNormal];
  [self.view addSubview:button];

  // 2
  NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
  NSString *mustacheJSString =
      [NSString stringWithContentsOfFile:file
                                encoding:NSUTF8StringEncoding
                                   error:nil];
  [self.context evaluateScript:mustacheJSString];

  //    NSString *value = [self.context[@"controlClass"] toString];
  //    JSValue *newObjectBlock = self.context[@"NewObject"];
  //
  //    UIButton *button1 = [[newObjectBlock callWithArguments:@[value]]
  //    toObject];
  //    button1.frame = CGRectMake(100, 210, 100, 100);
  //    button1.backgroundColor = [UIColor redColor];
  //    [button1 setTitle:@"test button" forState:UIControlStateNormal];
  //    [self.view addSubview:button1];
  //
  //    //3
  //    UIButton *buttonValue = [self.context[@"testButton"] toObject];
  //    buttonValue.frame = CGRectMake(100, 320, 100, 100);
  //    buttonValue.backgroundColor = [UIColor redColor];
  //    [buttonValue setTitle:@"test button" forState:UIControlStateNormal];
  //    [self.view addSubview:buttonValue];
  //
  //    //4
  //
  //    JSValue *funtion = self.context[@"array"];
  //    NSArray *array = [funtion toObject];
  //    NSLog(@"array is %@",array);
}

- (void)customTest {
  JSContextModel *model = [JSContextModel shared];
  NSString *testFile =
      [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
  NSString *testJs = [NSString stringWithContentsOfFile:testFile
                                               encoding:NSUTF8StringEncoding
                                                  error:nil];
  [model evaluateScript:testJs];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self customTest];
}

@end
