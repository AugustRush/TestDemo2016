//
//  ViewController.m
//  URLSessionTask
//
//  Created by AugustRush on 1/14/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

- (IBAction)requestData:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://mco.ime.shahe.baidu.com:8015/v5/festival/list"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * data,NSURLResponse *reponse,NSError *error){
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
    }];
    [task resume];
}

@end
