//
//  JSOCTestModel.h
//  JSCoreOC
//
//  Created by AugustRush on 6/5/16.
//  Copyright © 2016 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSExportTest <JSExport>

JSExportAs(add, - (NSInteger)add:(NSInteger)a b:(NSInteger)b);


//- (void)add:(NSInteger)a b:(NSInteger)b;

@property (nonatomic, assign) NSInteger sum;

@end

@interface JSOCTestModel : NSObject<JSExportTest>

@property (nonatomic, assign) NSInteger sum;

@end