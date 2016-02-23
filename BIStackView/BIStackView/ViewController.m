//
//  ViewController.m
//  BIStackView
//
//  Created by AugustRush on 12/2/15.
//  Copyright © 2015 AugustRush. All rights reserved.
//

#import "ViewController.h"
#import "BITextGridView.h"
#import "UIView+BIAutoLayout.h"

@interface ViewController ()<BITextGridViewDataSource,BITextGridViewDelegate>

@property (nonatomic, strong) BITextGridView *gridView;
@property (nonatomic, strong) NSArray *strings;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.strings = @[@"welcome",@"to",@"hsdudkkdkfkllldslls",@"123456900",@"what are you fucking saying!!!!",@"welcome",@"to",@"hsdudkkdkfkllldslls"];
    
    self.gridView = [[BITextGridView alloc] init];
    self.gridView.dataSource = self;
    self.gridView.delegate = self;
    [self.view addSubview:self.gridView];
    
    self.gridView.backgroundColor = [UIColor redColor];
    self.gridView.frame = CGRectMake(0, 100, 320, 200);
    
    [self.gridView reloadData];
    
    
    UICollectionView
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BITextGridViewDataSource methods

- (NSUInteger)numberOfItemInGridView:(BITextGridView *)gridView {
    return self.strings.count;
}

- (NSString *)gridView:(BITextGridView *)gridView textAtIndex:(NSUInteger)index {
    return self.strings[index];
}

#pragma mark - BITextGridViewDelegate methods

- (void)gridView:(BITextGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    NSLog(@"%s %lu",__PRETTY_FUNCTION__,(unsigned long)index);
}

@end
