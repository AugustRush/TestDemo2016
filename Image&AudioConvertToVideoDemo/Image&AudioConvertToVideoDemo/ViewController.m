//
//  ViewController.m
//  Image&AudioConvertToVideoDemo
//
//  Created by AugustRush on 11/21/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoSynthesizer.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *theVideoPath;

@end

@implementation ViewController

- (IBAction)start:(id)sender {
    NSArray *images = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    
    [[VideoSynthesizer shareInstance] syntheticVideoWithSettings:^(SyntheticedVideoSettings * _Nonnull configuration) {
        configuration.outputName = @"bksjdfh";
        configuration.outputFPS = 1;
    } backgroundAudioPath:[[NSBundle mainBundle] pathForResource:@"yuebanwan" ofType:@"mp3"] images:images completion:^(NSString * _Nonnull path) {
        NSLog(@"path is %@",path);
    } failed:^(NSError * _Nonnull err) {
        NSLog(@"error is %@",err);
    }];
}

- (IBAction)startRecord:(id)sender {
    AVAudioRecorder
}

- (IBAction)stopRecord:(id)sender {
    
}

- (IBAction)playRecord:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
