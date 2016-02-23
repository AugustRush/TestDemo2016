//
//  ViewController.m
//  GameBarDemo
//
//  Created by AugustRush on 1/4/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "BIGameBar.h"
#import "UIView+BIAutoLayout.h"
#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface ViewController () <BIGameBarDelegate, BIGameBarDataSourceDelegate>

@property(nonnull, strong) BIGameBar *gameBar;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.\

  BIGameBar *gameBar = [[BIGameBar alloc]
      init];
  gameBar.backgroundColor = [UIColor redColor];
  gameBar.delegate = self;
  gameBar.dataSourceDelegate = self;
    [gameBar updateMoney:10000];
  [self.view addSubview:gameBar];

  self.gameBar = gameBar;

  [gameBar makeWidthEqual:self.view];
  [gameBar autoSetHeight:60];
  [gameBar anchor:BILayoutAttributeLeft toSuperView:BILayoutAttributeLeft];
  [gameBar anchor:BILayoutAttributeRight toSuperView:BILayoutAttributeRight];
  [gameBar anchor:BILayoutAttributeTop
      toSuperView:BILayoutAttributeTop
         constant:100];
}

- (IBAction)buttonClicked:(id)sender {
    [self.gameBar becomeFirstResponder];
//  [self.gameBar start];
}
- (IBAction)setlevel:(id)sender {
    UIButton *button = [self.gameBar valueForKey:@"_exitButton"];
    [button setEnabled:!button.enabled];
}

- (IBAction)updateMoney:(id)sender {
  [self.gameBar updateMoney:arc4random() % 1000];
}

- (void)gameBarTimeout:(BIGameBar *)bar {
  NSLog(@"time out ....");
}

- (void)gameBarClosed:(BIGameBar *)bar {
  NSLog(@"closed ....");
  [UIView
      transitionWithView:_gameBar
                duration:1.0
                 options:UIViewAnimationOptionTransitionFlipFromLeft
              animations:nil
              completion:^(BOOL finished) {
                [UIView animateKeyframesWithDuration:1.0
                    delay:0.0
                    options:UIViewKeyframeAnimationOptionCalculationModeLinear
                    animations:^{
                      [UIView
                          addKeyframeWithRelativeStartTime:0.0
                                          relativeDuration:0.3
                                                animations:^{
                                                  _gameBar.transform =
                                                      CGAffineTransformMakeScale(
                                                          1.1, 1.1);
                                                }];
                      [UIView
                          addKeyframeWithRelativeStartTime:0.3
                                          relativeDuration:0.4
                                                animations:^{
                                                  _gameBar.transform =
                                                      CGAffineTransformMakeScale(
                                                          0.8, 0.8);

                                                }];
                      [UIView
                          addKeyframeWithRelativeStartTime:0.7
                                          relativeDuration:0.3
                                                animations:^{
                                                  _gameBar.transform =
                                                      CGAffineTransformMakeScale(
                                                          1.0, 1.0);

                                                }];

                    }
                    completion:^(BOOL finished){

                    }];
              }];
}

- (NSTimeInterval)gameTime {
  return 6.6;
}

- (NSUInteger)gameLevel {
  return 3;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
