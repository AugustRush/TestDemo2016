//
//  main.m
//  CDemo
//
//  Created by AugustRush on 15/10/12.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Byte a = (Byte)4;
        Byte c = (Byte)5;
        Byte b[2] = {0,0};
        printf("size byte is %lu, size int is %lu \n",sizeof(a),sizeof(b));
        memcpy(b, &a, sizeof(a));
        printf("b[0] is %d\n",b[0]);
        
        memcpy(b+1, &c, sizeof(c));
        printf("b[1] is %d\n",b[1]);
        
        //timestamp
        time_t timenow;
        time(&timenow);
        struct tm *current = localtime(&timenow);
        uint16_t year = current->tm_year + 1900;
        uint16_t yearCheck = year % 2;
        uint16_t m = current->tm_mon + 1;
        uint16_t d = current->tm_mday;
        uint16_t h = current->tm_hour;
        
    }
    return 0;
}

