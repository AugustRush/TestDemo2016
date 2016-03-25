//
//  BIAccessibilityController.m
//  VoiceOver
//
//  Created by AugustRush on 3/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "BIAccessibilityController.h"
#import <UIKit/UIAccessibility.h>

@implementation BIAccessibilityController {

}

#pragma mark - life cycle methods

+ (instancetype)shareInstance {
    static BIAccessibilityController *__speechController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __speechController = [[BIAccessibilityController alloc] init];
    });
    return __speechController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

- (BOOL)postAccessibilityNotification:(UIAccessibilityNotifications)accessibilityNotification withObject:(id)object {
    BOOL succeed = NO;
    if (UIAccessibilityIsVoiceOverRunning()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAccessibilityPostNotification(accessibilityNotification, object);
        });
        succeed = YES;
    }
    return succeed;
}

- (BOOL)speakSomething:(NSString *)text {
    return [self postAccessibilityNotification:UIAccessibilityAnnouncementNotification withObject:text];
}

- (BOOL)moveFocusTo:(id)another {
    return [self postAccessibilityNotification:UIAccessibilityScreenChangedNotification withObject:another];
}

#pragma mark - private methods

- (void)setUp {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessibilityStatusDidChanged:) name:UIAccessibilityVoiceOverStatusChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessibilityAnnouncementDidFinished:) name:UIAccessibilityAnnouncementDidFinishNotification object:nil];
}

#pragma mark - UIAccessibility notification methods

- (void)accessibilityStatusDidChanged:(NSNotification *)notification {
    NSLog(@"%@ %@",NSStringFromSelector(_cmd),notification);
}

- (void)accessibilityAnnouncementDidFinished:(NSNotification *)notification {
    NSLog(@"%@ %@ string value is %@",NSStringFromSelector(_cmd),notification,[[notification userInfo] objectForKey:UIAccessibilityAnnouncementKeyStringValue]);
}

@end
