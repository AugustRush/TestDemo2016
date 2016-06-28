//
//  ViewController.h
//  MsgSendDemo
//
//  Created by AugustRush on 6/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@import JavaScriptCore;

@protocol UIViewExport <JSExport>

+ (id)new;

+ (instancetype)alloc;
- (instancetype)init;

- (void)setFrame:(CGRect)frame;

@end

@interface ViewController : UIViewController

@end

