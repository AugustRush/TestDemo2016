//
//  ViewController.m
//  XPCDemo
//
//  Created by AugustRush on 3/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/NSXPCConnection.h>
#import "JustTestProtocol.h"

@implementation ViewController
{
    NSXPCConnection *_connectionToService;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _connectionToService = [[NSXPCConnection alloc] initWithServiceName:@"AR.JustTest"];
    _connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(JustTestProtocol)];
    [_connectionToService resume];
}

- (IBAction)JustXPCTest:(id)sender {
    NSString *string = [NSString stringWithFormat:@"date is %@",[NSDate date]];
    [[_connectionToService remoteObjectProxy] upperCaseString:string withReply:^(NSString *aString) {
        // We have received a response. Update our text field, but do it on the main thread.
        NSLog(@"Result string was: %@ thread is %@", aString,[NSThread currentThread]);
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
