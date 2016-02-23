//
//  BITextGridView.h
//  BITextGridView
//
//  Created by AugustRush on 12/2/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BITextGridViewAlignmentMode) {
    BITextGridViewAlignmentModeJustfield = 0,//default
    BITextGridViewAlignmentModeLeft,
    BITextGridViewAlignmentModeCenter,
    BITextGridViewAlignmentModeRight,
};

@protocol BITextGridViewDataSource;
@protocol BITextGridViewDelegate;

@interface BITextGridView : UIView

@property (nonatomic, weak) IBOutlet id<BITextGridViewDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<BITextGridViewDataSource> dataSource;
@property (nonatomic, assign) BITextGridViewAlignmentMode aligmentMode;

- (void)reloadData;

@end


@protocol BITextGridViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemInGridView:(BITextGridView *)gridView;
- (NSString *)gridView:(BITextGridView *)gridView textAtIndex:(NSUInteger)index;

@end

@protocol BITextGridViewDelegate <NSObject>

- (void)gridView:(BITextGridView *)gridView didSelectItemAtIndex:(NSUInteger)index;

@end