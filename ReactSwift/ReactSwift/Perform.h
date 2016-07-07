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
void * performFunction(const char * manglingSymbol, id target,size_t returnValueSize);
#endif /* perform_h */
