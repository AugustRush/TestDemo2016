//
//  FooTest.c
//  AssemblyTest
//
//  Created by AugustRush on 6/27/16.
//  Copyright © 2016 August. All rights reserved.
//

#include <stdio.h>
#include <stdarg.h>

//int sum(int n,...)
//{
//    int sum = n;
//    va_list vap;
//    va_start(vap , n);     //指向可变参数表中的第一个参数
//    
//    int value = 0;
//    while (value != -1) {
//        sum += value;
//        value = va_arg(vap , int);
//    }
//    va_end(vap);    //把指针vap赋值为0
//    return sum;
//}

int testMethod() {
    return 1;
}

int testMethod2() {
    return 2;
}