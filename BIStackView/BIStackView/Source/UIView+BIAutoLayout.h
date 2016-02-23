//
//  UIView+BIAutoLayout.h
//  BIStackView
//
//  Created by AugustRush on 12/2/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView * (^BALRelation)(UIView *toView);
typedef UIView * (^BALAttribute)(CGFloat constant);

@interface UIView (BIAutoLayout)

- (BALAttribute)BAL_left;
- (BALRelation)BAL_equalTo;

@end
