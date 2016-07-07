//
//  perform.c
//  SwiftAssembly
//
//  Created by AugustRush on 7/2/16.
//  Copyright © 2016 August. All rights reserved.
//

#include "perform.h"
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#import <objc/runtime.h>

int getAge(void)
{
    return 21;
}

int (*original_getAge)(void);
int replaced_getAge(void) {
    return 99;
}

void * performFunction(const char * manglingSymbol, id target,size_t returnValueSize) {
    id (*functionImplementation)(id);
    *(void **) (&functionImplementation) = dlsym(RTLD_DEFAULT, manglingSymbol);
    char *error;
    
    if ((error = dlerror()) != NULL)  {
        printf("Method not found \n");
    } else {
        //        ffi_cif cif;
        //        ffi_type * types[1] = {&ffi_type_pointer};
        //        void *paramaters[1] = {&target};
        //        void * returnV = alloca(returnValueSize);
        //        ffi_status status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, 1, &ffi_type_pointer, types);
        //        if (status == FFI_OK) {
        //            ffi_call(&cif, (void *)functionImplementation, returnV, paramaters);
        //        }
        //        return *(void **)returnV;
        return functionImplementation(target); // <--- call the function
    }
    return NULL;
}