//
//  main.m
//  AttribureTest
//
//  Created by AugustRush on 1/4/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+__AttributeTest__.h"
#import <stdlib.h>


__attribute__((constructor)) void pre_process1(void){
    printf("pre just test !!!");
}

__attribute__((destructor)) void aft_process1(void){
    printf("aft just test !!!");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"main excute");
    }
    return 0;
}
