//
//  BIGameBarLevelView.h
//  BaiduInputLib
//
//  Created by AugustRush on 1/4/16.
//
//

#import <UIKit/UIKit.h>

@interface BIGameBarLevelView : UIView

@property (nonatomic, assign) NSUInteger level;

@end


@interface BIGameBarStarView : UIView

@property (nonatomic, strong, readonly) CALayer *contentsLayer;
@property (nonatomic, assign) NSUInteger starsCount;

@end