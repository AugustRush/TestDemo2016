//
//  BITextGridViewCell.m
//  BIStackView
//
//  Created by AugustRush on 12/2/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "BITextGridViewCell.h"
#import "UIView+BIAutoLayout.h"

@interface BITextGridViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BITextGridViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];

}

@end
