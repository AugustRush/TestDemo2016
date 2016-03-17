//
//  JustTest.h
//  JustTest
//
//  Created by AugustRush on 3/17/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JustTestProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface JustTest : NSObject <JustTestProtocol>
@end
