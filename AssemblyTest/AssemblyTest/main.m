//
//  main.m
//  AssemblyTest
//
//  Created by AugustRush on 6/27/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

id MSGSend(id self,SEL selector,...) {
    return self;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
