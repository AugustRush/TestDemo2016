//
//  Perform.h
//  AsyncLabel
//
//  Created by AugustRush on 6/16/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
@interface CATransaction(Perfrom)

+ (void)perform:(void(^)())perform;

@end
NS_ASSUME_NONNULL_END
