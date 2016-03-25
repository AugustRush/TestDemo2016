//
//  TestVoiceOverView.m
//  VoiceOver
//
//  Created by AugustRush on 3/21/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "TestVoiceOverView.h"
#import "TestViewGrid.h"

@implementation TestVoiceOverView
{
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}


- (void)setUp {
    //indicate self is a accessibility element
//    self.isAccessibilityElement = YES;
    self.accessibilityIdentifier = @"Test VVV";
    self.accessibilityLabel = @"一个红色的视图";
    self.accessibilityHint = @"双击可以触发相应的操作";
    self.accessibilityTraits = UIAccessibilityTraitNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds) / 4.0 - 1;
    CGFloat height = CGRectGetHeight(self.bounds) / 4.0 - 1;
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            CGRect frame = CGRectMake(i * width + i*1, j * height + j * 1, width, height);
            TestViewGrid *view = [[TestViewGrid alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view.frame = frame;
            // if it's superView is an accessibility element , set to NO, superView can recieve event
//            view.userInteractionEnabled = NO;
            view.isAccessibilityElement = YES;
            view.accessibilityLabel = [NSString stringWithFormat:@"第%d行第%d列",j+1,i+1];
            view.accessibilityTraits = UIAccessibilityTraitButton;
            [self addSubview:view];
        }
    }
//all subviews
//    self.accessibilityElements = self.subviews;
}

@end
