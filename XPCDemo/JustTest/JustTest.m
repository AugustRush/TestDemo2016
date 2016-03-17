//
//  JustTest.m
//  JustTest
//
//  Created by AugustRush on 3/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "JustTest.h"

@implementation JustTest

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
- (void)upperCaseString:(NSString *)aString withReply:(void (^)(NSString *))reply {
    NSString *response = [aString uppercaseString];
    reply(response);
}

@end
