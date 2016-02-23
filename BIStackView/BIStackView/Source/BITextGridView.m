//
//  BIStackView.m
//  BIStackView
//
//  Created by AugustRush on 12/2/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "BITextGridView.h"
#import "BITextGridViewCell.h"
#import "BITextGridViewLayoutAttribute.h"

@interface BITextGridView ()

@property (nonatomic, strong) NSMutableArray<BITextGridViewLayoutAttribute *> *layoutAttributes;
@property (nonatomic, strong) BITextGridViewCell *caculateSizeCell;

@end

@implementation BITextGridView

#pragma mark - init methods

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _layoutAttributes = [NSMutableArray array];
    _aligmentMode = BITextGridViewAlignmentModeJustfield;
    _caculateSizeCell = [[BITextGridViewCell alloc] init];
    _caculateSizeCell.titleLabel.minimumFontSize
}

#pragma mark - private methods

- (void)prepareLayout {
    NSUInteger numberOfItems = [self.dataSource numberOfItemInGridView:self];
    for (NSUInteger i = 0; i < numberOfItems; i++) {
        NSString *text = [self.dataSource gridView:self textAtIndex:i];
        _caculateSizeCell.titleLabel.text = text;
        CGSize size = [_caculateSizeCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        BITextGridViewLayoutAttribute *attribute = [[BITextGridViewLayoutAttribute alloc] init];
        attribute.index = i;
        attribute.size = size;
        attribute.text = text;
        [_layoutAttributes addObject:attribute];
    }
}

- (void)reloadData {
    [self prepareLayout];
    for (BITextGridViewLayoutAttribute *attribute in _layoutAttributes) {
        BITextGridViewCell *cell = [[BITextGridViewCell alloc] init];
        cell.titleLabel.text = attribute.text;
        cell.frame = CGRectMake(0, 0, attribute.size.width, attribute.size.height);
        [self addSubview:cell];
    }
}

@end
