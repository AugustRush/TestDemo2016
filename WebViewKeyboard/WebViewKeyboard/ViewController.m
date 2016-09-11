//
//  ViewController.m
//  WebViewKeyboard
//
//  Created by AugustRush on 9/2/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
