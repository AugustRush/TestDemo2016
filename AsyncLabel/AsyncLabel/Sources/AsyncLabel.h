//
//  AsyncLabel.h
//  AsyncLabel
//
//  Created by AugustRush on 6/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface AsyncLabel : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
//@property (nonatomic, assign) CGFloat preferredMaxLayoutWidth;
@property (nonatomic, assign) NSUInteger numberOfLines;
@property (nonatomic, assign) BOOL asyncDisplay;

@end
NS_ASSUME_NONNULL_END
