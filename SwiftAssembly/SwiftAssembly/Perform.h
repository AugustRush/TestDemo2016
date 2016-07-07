//
//  perform.h
//  SwiftAssembly
//
//  Created by AugustRush on 7/2/16.
//  Copyright © 2016 August. All rights reserved.
//

#ifndef perform_h
#define perform_h

#include <stdio.h>

typedef struct objc_object *id;

    //https://en.wikipedia.org/wiki/Name_mangling#Swift
id performFunction(const char * manglingSymbol, id target,size_t returnValueSize);

//test
int getAge(void);
int (*original_getAge)(void);
int replaced_getAge(void);

#endif /* perform_h */
