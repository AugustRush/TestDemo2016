//
//  BSVector.h
//  BSVector
//
//  Created by AugustRush on 2/6/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSVector : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat z;
@property (nonatomic, assign) CGFloat w;

- (instancetype)initWithValues:(CGFloat *)values count:(size_t)count;

- (void)clearAllNodes;

@end
