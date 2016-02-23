//
//  BIGameBar.h
//  BaiduInputLib
//
//  Created by samuel on 12/31/15.
//
//

#import <UIKit/UIKit.h>

@class BIGameBar;

@protocol BIGameBarDataSourceDelegate <NSObject>

- (NSTimeInterval)gameTime;
- (NSUInteger)gameLevel;

@end

@protocol BIGameBarDelegate <NSObject>

- (void)gameBarTimeout:(BIGameBar *)bar;
- (void)gameBarClosed:(BIGameBar *)bar;

@end

@interface BIGameBar : UIView<UITextInput>

@property (nonatomic, weak) id<BIGameBarDelegate> delegate;
@property (nonatomic, weak) id<BIGameBarDataSourceDelegate> dataSourceDelegate;
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

- (void)start;
- (void)updateMoney:(NSUInteger)count;

@end
