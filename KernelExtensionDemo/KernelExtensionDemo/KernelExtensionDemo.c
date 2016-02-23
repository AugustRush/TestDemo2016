//
//  KernelExtensionDemo.c
//  KernelExtensionDemo
//
//  Created by AugustRush on 1/1/16.
//  Copyright © 2016 AugustRush. All rights reserved.
//

#include <mach/mach_types.h>
#include <libkern/libkern.h>

kern_return_t KernelExtensionDemo_start(kmod_info_t * ki, void *d);
kern_return_t KernelExtensionDemo_stop(kmod_info_t *ki, void *d);

kern_return_t KernelExtensionDemo_start(kmod_info_t * ki, void *d)
{
    printf("start ...");
    return KERN_SUCCESS;
}

kern_return_t KernelExtensionDemo_stop(kmod_info_t *ki, void *d)
{
    printf("stop ...");
    return KERN_SUCCESS;
}
