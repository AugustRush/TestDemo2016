//
//  TestViewGrid.m
//  VoiceOver
//
//  Created by AugustRush on 3/24/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "TestViewGrid.h"

@implementation TestViewGrid

- (instancetype)init {
    self = [super init];
    if (self) {
        UIAccessibilityCustomAction *customAction1 = [[UIAccessibilityCustomAction alloc] initWithName:@"操作一" target:self selector:@selector(firstPerformActionMethod:)];
        UIAccessibilityCustomAction *customAction2 = [[UIAccessibilityCustomAction alloc] initWithName:@"操作二" target:self selector:@selector(secondPerformActionMethod:)];
        UIAccessibilityCustomAction *customAction3 = [[UIAccessibilityCustomAction alloc] initWithName:@"操作三" target:self selector:@selector(thirdPerformActionMethod:)];
        self.isAccessibilityElement = YES;
        self.accessibilityCustomActions = @[customAction1,customAction2,customAction3];
    }
    return self;
}

- (void)firstPerformActionMethod:(UIAccessibilityCustomAction *)action {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.backgroundColor = [UIColor redColor];
//    return YES;
}

- (void)secondPerformActionMethod:(UIAccessibilityCustomAction *)action {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.backgroundColor = [UIColor blueColor];
//    return YES;
}

- (void)thirdPerformActionMethod:(UIAccessibilityCustomAction *)action {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.backgroundColor = [UIColor blueColor];
//    return YES;
}


- (BOOL)accessibilityActivate {
    return YES;
}

- (BOOL)accessibilityPerformMagicTap {
    return YES;
}

@end
