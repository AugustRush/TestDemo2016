//
//  BlueView.m
//  VoiceOver
//
//  Created by AugustRush on 4/14/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView
{
    NSArray *_elements;
}

- (BOOL)isAccessibilityElement {
    return NO;
}

- (BOOL)shouldGroupAccessibilityChildren {
    return YES;
}

- (BOOL)accessibilityElementsHidden {
    return NO;
}

- (NSInteger)accessibilityElementCount {
    return _elements.count;
}

- (NSArray *)accessibilityElements {
    NSMutableArray *array = @[].mutableCopy;
    for (int i = 0; i < 2; i++) {
        UIAccessibilityElement *element = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
        element.accessibilityIdentifier = @"sss";
        element.accessibilityLabel = @"jkashgdfihasgdf";
        element.accessibilityTraits = UIAccessibilityTraitStaticText;
        element.accessibilityContainer = nil;
        element.isAccessibilityElement = YES;
        element.accessibilityFrame = UIAccessibilityConvertFrameToScreenCoordinates(CGRectMake(100 * i, 0, 100, 100), self);
        [array addObject:element];
    }
        _elements = array.copy;
    return _elements;
}

@end
