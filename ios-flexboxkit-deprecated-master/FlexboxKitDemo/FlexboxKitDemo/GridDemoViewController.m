//
//  ViewController.m
//  FlexboxKitDemo
//
//  Created by Alex Usbergo on 09/05/15.
//  Copyright (c) 2015 Alex Usbergo. All rights reserved.
//

#include <stdlib.h>
#import "UIColor+Demo.h"
#import "GridDemoViewController.h"
#import <FlexboxKit/FlexboxKit.h>

@interface GridDemoViewController ()

@property (nonatomic, strong) FLEXBOXContainerView *containerView;
@property (nonatomic, strong) NSArray *firstRowViews;

@end

@implementation GridDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // the flexbox containers
    FLEXBOXContainerView *container = [[FLEXBOXContainerView alloc] initWithFrame:self.view.bounds];
    container.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    container.backgroundColor = [UIColor darkGrayColor];
    container.flexDirection = FLEXBOXFlexDirectionColumn;
    container.flexWrap = YES;
    container.flexPadding = UIEdgeInsetsMake(20, 20, 20, 20);
    container.flexMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    container.flexJustifyContent = CSS_JUSTIFY_FLEX_START;
    container.flexMaximumSize = CGSizeMake(40, 60);
    [self.view addSubview:container];
    
    NSArray *views = [self createFirstRowViews];
    
    for (UIView *view in views) {
        [container addSubview:view];
    }
    
    self.containerView = container;
    
}

- (void)didPressButton:(UIButton*)sender
{
    [self layout:sender.tag];
}

#pragma mark - Different layouts

- (void)layout:(NSInteger)index
{
    self.containerView.flexDirection = index % 3;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.containerView layoutSubviews];
                     }];
}

#pragma mark - Test view (No layout logic)

// creates some test views
- (NSArray*)createFirstRowViews
{
    NSArray *labels = @[@"1", @"2", @"3", @"4",@"5",@"6",@"7"];
    
    //Dum
    NSMutableArray *buttons = @[].mutableCopy;
    for (NSUInteger i = 0; i < labels.count; i++) {
        
        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b setTitle:labels[i] forState:UIControlStateNormal];
        [b setBackgroundColor:@[UIColor.tomatoColor, UIColor.steelBlueColor][i%2]];
        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
        b.layer.cornerRadius = 8;
        b.tag = i;
        [buttons addObject:b];
    }
    
    return buttons.copy;
}

//- (NSArray*)createSecondRowViews
//{
//    NSArray *labels = @[@"A fixed size item",@"Another fixed size item"];
//
//    //Dum
//    NSMutableArray *buttons = @[].mutableCopy;
//    for (NSUInteger i = 0; i < labels.count; i++) {
//        
//        UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [b setTitle:labels[i] forState:UIControlStateNormal];
//        [b setBackgroundColor:@[UIColor.tomatoColor, UIColor.steelBlueColor][i%2]];
//        [b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [b addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
//        b.layer.cornerRadius = 8;
//        b.tag = 4;
//        [buttons addObject:b];
//    }
//    
//    return buttons.copy;
//}

@end
