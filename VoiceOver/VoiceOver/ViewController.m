//
//  ViewController.m
//  VoiceOver
//
//  Created by AugustRush on 3/21/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "BIAccessibilityController.h"
#import "TestVoiceOverView.h"
#import "ViewController.h"
#import "BlueView.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet BlueView *blueView;
@property(weak, nonatomic) IBOutlet TestVoiceOverView *testVoiceOverView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.testVoiceOverView.userInteractionEnabled = YES;
  [self.testVoiceOverView addTarget:self
                             action:@selector(testVoiceOverControlTaped:)
                   forControlEvents:UIControlEventTouchUpInside];

  [BIAccessibilityController shareInstance];

  self.blueView.userInteractionEnabled = YES;
  self.blueView.isAccessibilityElement = YES;
  self.blueView.accessibilityLabel = @"蓝色的视图";

  UILongPressGestureRecognizer *longPress =
      [[UILongPressGestureRecognizer alloc]
          initWithTarget:self
                  action:@selector(longPressBlueView:)];
    longPress.numberOfTouchesRequired = 1;
  [self.blueView addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (void)testVoiceOverControlTaped:(id)sender {
  [[BIAccessibilityController shareInstance]
      speakSomething:@"双击可以干什么！"];
}

- (IBAction)speakSomething:(id)sender {
  NSString *localizedString =
      NSLocalizedStringFromTable(@"Just Test", @"VoiceOver", nil);

  [[BIAccessibilityController shareInstance] speakSomething:localizedString];
}

- (void)longPressBlueView:(UILongPressGestureRecognizer *)gesture {
  UIGestureRecognizerState state = gesture.state;
  switch (state) {
  case UIGestureRecognizerStatePossible: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Possible"];
    break;
  }
  case UIGestureRecognizerStateBegan: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Began"];
    break;
  }
  case UIGestureRecognizerStateChanged: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Changed"];
    break;
  }
  case UIGestureRecognizerStateEnded: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Ended"];
    break;
  }
  case UIGestureRecognizerStateCancelled: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Canceled"];
    break;
  }
  case UIGestureRecognizerStateFailed: {
    [[BIAccessibilityController shareInstance] speakSomething:@"Failed"];
    break;
  }
  
  }
}

@end
