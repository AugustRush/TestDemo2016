//
//  BSJavaScriptBridge.h
//  SwiftComplierDemo
//
//  Created by AugustRush on 12/3/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


NS_ASSUME_NONNULL_BEGIN

NS_INLINE NSString *BSTypeEncoding(NSString *typeDes) {

#define ENCODESTR(type) [NSString stringWithUTF8String:@encode(type)]

    static NSDictionary *encodes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        encodes = @{@"Int":ENCODESTR(NSInteger),
                    @"NSInteger":ENCODESTR(NSInteger),
                    @"UInt":ENCODESTR(NSUInteger),
                    @"NSUInteger":ENCODESTR(NSUInteger),
                    @"int":ENCODESTR(int),
                    @"float":ENCODESTR(float),
                    @"CGFloat":ENCODESTR(CGFloat),
                    @"double":ENCODESTR(double),
                    @"id":ENCODESTR(id)};
    });
    
    if (encodes[typeDes]) {
        return encodes[typeDes];
    }
    
    return ENCODESTR(id);
}

FOUNDATION_EXPORT NSString *const BSRegisteClassBlockJavaScriptName;
FOUNDATION_EXPORT NSString *const BSCreateObjectBlockJavaScriptName;
FOUNDATION_EXPORT NSString *const BSFunctionObjcNameKey;
FOUNDATION_EXPORT NSString *const BSFunctionTypeKey;
FOUNDATION_EXPORT NSString *const BSFunctionJSNameKey;
FOUNDATION_EXPORT NSString *const BSFunctionObjcEncodeKey;
FOUNDATION_EXPORT NSString *const BSFunctionArgsCountKey;

@interface BSJavaScriptBridge : NSObject

@property (nonatomic, strong, readonly) JSContext *context;

+ (instancetype)sharedInstance;

@end
NS_ASSUME_NONNULL_END
