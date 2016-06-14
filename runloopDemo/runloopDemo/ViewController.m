//
//  ViewController.m
//  runloopDemo
//
//  Created by AugustRush on 6/7/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (nonatomic, assign) BOOL running;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)setUp {
    _running = YES;
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(addRunloop) object:nil];
    [_thread start];
}

- (void)addRunloop {
    CFRunLoopSourceContext context ;
    context.perform = &threadPerfrom;
    context.schedule = &threadSchedule;
    context.cancel = &threadCancel;
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(NULL, 0, &context);
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
//    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    CFRunLoopAddSource(runloop, source, kCFRunLoopDefaultMode);
    
    while (_running) {
        NSLog(@"run");
        CFRunLoopRun();
    }

    CFRunLoopRemoveSource(runloop, source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

void threadPerfrom(void *info) {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

void	threadSchedule(void *info, CFRunLoopRef rl, CFStringRef mode) {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

void	threadCancel(void *info, CFRunLoopRef rl, CFStringRef mode) {
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

#pragma mark - event methods

- (IBAction)startButtonClicked:(id)sender {
    [self performSelector:@selector(stopRunloop) onThread:_thread withObject:nil waitUntilDone:YES];
}

- (IBAction)perfromButtonClicked:(id)sender {
    [self performSelector:@selector(test) onThread:_thread withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
}

- (void)test {
    NSLog(@"aaaaaaa");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"bbb");
    });
}

@end
