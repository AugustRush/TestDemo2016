//
//  JSContextModel.m
//  JSCoreOC
//
//  Created by AugustRush on 6/12/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "JSContextModel.h"

@protocol JSContextModelProtocol <JSExport>

JSExportAs(createObject, - (id)createObjectWithClassName:(NSString *)className selectors:(NSArray *)selectors);

@end

@interface JSContextModel ()<JSContextModelProtocol>


@end

@implementation JSContextModel {
    JSContext *_context;
}

+ (instancetype)shared {
    static JSContextModel * shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[JSContextModel alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    
    _context = [[JSContext alloc] init];
    [_context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"exception:%@ value is %@",context.exception, value);
        
        NSArray *args = [JSContext currentArguments];
        NSLog(@"args is %@",args);
    }];
    
    id (^CreateObject)(NSDictionary *) = ^id(NSDictionary *info){
        NSLog(@"info is %@",info);
        return nil;
    };
    
    [_context setObject:CreateObject forKeyedSubscript:@"__Create"];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"GLOBAL" ofType:@"js"];
    NSString *mustacheJSString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    [_context evaluateScript:mustacheJSString];
    
    JSManagedValue *value = [JSManagedValue]
}

- (void)evaluateScript:(NSString *)script {
    NSString *handledScript = [self handleScript:script];
    [_context evaluateScript:handledScript];
}

- (NSString *)handleScript:(NSString *)script {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#" options:NSRegularExpressionAnchorsMatchLines error:&error];
    NSString *string = [regex stringByReplacingMatchesInString:script options:0 range:NSMakeRange(0, script.length) withTemplate:@"NewObject('"];
    
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@";" options:NSRegularExpressionAnchorsMatchLines error:&error];
    string = [regex1 stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, script.length) withTemplate:@"');"];
    
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:script options:NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, script.length)];
    if (result) {
        for (int i = 0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            NSLog(@"str is %@", [script substringWithRange:res.range]);
        }
    }else{
        NSLog(@"error is %@",error.description);
    }
    return string;
}

- (id)createObjectWithClassName:(NSString *)className selectors:(NSArray *)selectors {
    id class = NSClassFromString(className);
    id value = class;
    for (NSString *string in selectors) {
        value = [class performSelector:NSSelectorFromString(string)];
    }
    return value;
}

@end
