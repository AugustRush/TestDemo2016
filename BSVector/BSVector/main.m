//
//  main.m
//  BSVector
//
//  Created by AugustRush on 2/6/16.
//  Copyright © 2016 ProfessionIsFunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSVector.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        CGFloat floats[4] = {1.5,2.3,3.4,4.8};
        BSVector *vector = [[BSVector alloc] initWithValues:floats count:4];
        NSLog(@"vector is %@",vector);
        [vector clearAllNodes];
        NSLog(@"vector is %@",vector);
    }
    return 0;
}
