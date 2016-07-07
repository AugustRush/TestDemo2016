//
//  ViewController.m
//  ViewController
//
//  Created by AugustRush on 5/24/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import "Controller1.h"

@interface ViewController ()

@property (nonatomic, strong) Controller1 *controller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self removeController:nil];
//    });
    
//    self.view.nextResponder = [[Controller1 alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"self parent controller is %@",self.parentViewController);
    
    NSString *dlink = @"itms-services://?action=download-manifest&url=https://cp01-ocean-2456.epc.baidu.com:8989/lcmanage/index.php?r=DownloadAction&prodline=baiduinput&os=IPhone&original_type=1&channel=&imei=&version_name=6.5.5.1&version_code=&cuid=&atuo=0&wifi_flag=0&platform=ios&fullupdate=0&usermd5=&jb=1&brand=&model=&resolution=%2A&screen_size=&network=gprs&area=&ip=172.18.27.64&type=apk&cpu=&package_name=com.baidu.input&active_time=0&sdk_version=0&down_from=lc&original_id=2226&upgradeid=820&ori_version_name=7.0.1&ori_version_code=7.0.1.14&path=/original_new/89/3/1/1467113368906/baiduinput.plist";
    
        NSURL *URL = [NSURL URLWithString:dlink];
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL];
        }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addController:(id)sender {
    _controller = [[Controller1 alloc] init];
    [_controller willMoveToParentViewController:self];
    [self addChildViewController:_controller];
    [self.view addSubview:_controller.view];
    _controller.view.frame  = CGRectMake(0, 0, 320, 200);
    [_controller didMoveToParentViewController:self];
    
    
    Controller1 *subController = [[Controller1 alloc] init];
    [_controller addChildViewController:subController];
    [_controller.view addSubview:subController.view];
    [subController didMoveToParentViewController:_controller];
    subController.view.frame = CGRectMake(0, 0, 100, 100);
    subController.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)removeController:(id)sender {
//    [self.controller willMoveToParentViewController:nil];
//    [self.controller removeFromParentViewController];
    [self.controller.view  removeFromSuperview];
//    [self.controller didMoveToParentViewController:nil];
    
    self.controller = nil;
}

@end
