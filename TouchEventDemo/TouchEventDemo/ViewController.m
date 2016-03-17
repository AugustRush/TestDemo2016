//
//  ViewController.m
//  TouchEventDemo
//
//  Created by AugustRush on 3/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "ForeView.h"
#import "BehindButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BehindButton *behindButton;
@property (weak, nonatomic) IBOutlet ForeView *foreView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
