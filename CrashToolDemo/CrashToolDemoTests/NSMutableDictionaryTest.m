//
//  NSMutableDictionary.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSMutableDictionaryTest : XCTestCase

@end

@implementation NSMutableDictionaryTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testSetObjectForKey {
    
    NSMutableDictionary *dict = @{@"name": @"Andrew", @"gender":@"man"}.mutableCopy;
    NSString *ageKey = nil;
    dict[ageKey] = @(24);
    NSLog(@"%@",dict);
}


- (void)testRemoveObjectForKey {
    
    //    __NSDictionaryM
    NSMutableDictionary *dict = @{@"name": @"Andrew", @"gender":@"man"}.mutableCopy;
    NSString *ageKey = nil;
    
    [dict removeObjectForKey:ageKey];
    [dict removeObjectForKey:@"age"];
    NSLog(@"%@",dict);
}

@end
