//
//  JSContextModel.h
//  JSCoreOC
//
//  Created by AugustRush on 6/12/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContextModel : NSObject

+ (instancetype)shared;

- (void)evaluateScript:(NSString *)script;

@end
