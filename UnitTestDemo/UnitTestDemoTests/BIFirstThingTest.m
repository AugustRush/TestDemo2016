//
//  BIFirstThingTest.m
//  UnitTestDemo
//
//  Created by AugustRush on 15/10/16.
//  Copyright © 2015年 AugustRush. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BIFirstThing.h"

@interface BIFirstThingTest : XCTestCase

@property (nonatomic, strong) BIFirstThing *firstThing;

@end

@implementation BIFirstThingTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.firstThing = [[BIFirstThing alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testFirsyThing {
    XCTAssertNotNil(self.firstThing,"first thing shoud not be nil");
    XCTAssertTrue([self.firstThing toDoSomethingTwo],"to do something should not be %lu",(unsigned long)[self.firstThing toDoSomethingTwo]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [self caculateRegexTime];
    }];
}

- (BOOL)caculateRegexTime {
    NSString *emailRegex = @"^([a-zA-Z0-9]+[-|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[-|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:@"bensonauto@pingan.comafasdfadfa"];return result;
}

@end
