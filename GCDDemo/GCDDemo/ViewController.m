//
//  ViewController.m
//  GCDDemo
//
//  Created by AugustRush on 1/18/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ViewController.h"
#import <libkern/OSAtomic.h>
#import <pthread.h>

@interface ViewController ()

@property(nonatomic, strong) dispatch_queue_t queueOne; // concurrent
@property(nonatomic, strong) dispatch_queue_t queueTwo;   // serial
@property(nonatomic, strong) dispatch_queue_t queueThree; // high concurrent

@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation ViewController {
  
    OSSpinLock _lock;
    dispatch_semaphore_t _semaphore;
    NSCondition *_condition;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  [self setUp];

    _condition = [[NSCondition alloc] init];
    _products = @[].mutableCopy;
    
      [self testSemaphoreLock];
//  [self testPhreadMutextLock];
}

#pragma mark - private methods

- (void)setUp {
  _lock = OS_SPINLOCK_INIT;
  _semaphore = dispatch_semaphore_create(0);

  _queueOne =
      dispatch_queue_create("com.august.queueOne", DISPATCH_QUEUE_CONCURRENT);
  _queueTwo =
      dispatch_queue_create("com.august.queueTwo", DISPATCH_QUEUE_SERIAL);

  _queueThree =
      dispatch_queue_create("com.augsut.queueThree", DISPATCH_QUEUE_CONCURRENT);
  dispatch_queue_t refQueue =
      dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
  dispatch_set_target_queue(_queueThree, refQueue);
    
}

#pragma mark - test methods

- (void)testOsspinLock {

  OSSpinLockLock(&_lock); // not safe
  NSLog(@"%@ start sleep", [NSThread currentThread]);
  sleep(5);
  NSLog(@"%@ end sleep", [NSThread currentThread]);
  OSSpinLockUnlock(&_lock);
}

- (void)testSemaphoreLock {
  dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

  dispatch_async(_queueOne, ^{
    NSLog(@"start one....");
    sleep(2);
    dispatch_semaphore_signal(semaphore);
  });
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

  dispatch_async(_queueTwo, ^{
    NSLog(@"start two ....");
    sleep(2);
    dispatch_semaphore_signal(semaphore);
  });
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

  dispatch_async(_queueThree, ^{
    NSLog(@"start three ....");
    sleep(1);
    dispatch_semaphore_signal(semaphore);
  });
}

- (void)testPhreadMutextLock {
  static pthread_mutex_t mutext;
  pthread_mutex_init(&mutext, NULL);

  pthread_mutex_lock(&mutext);
  dispatch_async(_queueOne, ^{
    NSLog(@"start one....");
    sleep(2);
    pthread_mutex_unlock(&mutext);
  });

  pthread_mutex_lock(&mutext);
  dispatch_async(_queueTwo, ^{
    NSLog(@"start two ....");
    sleep(2);
    pthread_mutex_unlock(&mutext);
  });

  pthread_mutex_lock(&mutext);
  dispatch_async(_queueThree, ^{
    NSLog(@"start three ....");
    sleep(1);
    pthread_mutex_unlock(&mutext);
  });
}

- (void)example0 {
    dispatch_async(_queueThree, ^{
        dispatch_barrier_async(_queueOne, ^{
            for (int i = 0; i < 100000; i++) {
                
            }
            NSLog(@"one");
        });
        NSLog(@"two");
    });
}

- (void)example1 {
   
}

- (void)createProduct {
    [_condition lock];
    NSLog(@"create a product");
    [self.products addObject:@"test"];
    NSLog(@"send a signal!");
    [_condition signal];
    NSLog(@"unlock....after create product");
    [_condition unlock];
}

- (void)costProduct {
    [_condition lock];
    
    while (_products.count == 0) {
        NSLog(@"wait a product to use");
        [_condition wait];
        NSLog(@"exit wait product");
    }
    NSLog(@"use a product");
    [self.products removeLastObject];
    [_condition unlock];
}

- (IBAction)segmentControl1Clicked:(UISegmentedControl *)sender {
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self performSelectorInBackground:@selector(createProduct) withObject:nil];
            break;
        case 1:
            [self performSelectorInBackground:@selector(costProduct) withObject:nil];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
