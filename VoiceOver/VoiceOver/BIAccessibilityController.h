//
//  BIAccessibilityController.h
//  VoiceOver
//
//  Created by AugustRush on 3/22/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BIAccessibilityController : NSObject

+ (instancetype)shareInstance;

- (BOOL)speakSomething:(NSString *)text;
- (BOOL)moveFocusTo:(id)another;

@end
NS_ASSUME_NONNULL_END