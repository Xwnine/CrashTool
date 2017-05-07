//
//  NSMutableArrayTest.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSMutableArrayTest : XCTestCase

@end

@implementation NSMutableArrayTest

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


- (void)testObjectAtIndex {
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"ios", @"Andrew", @"Man", nil];
    id value = [arr objectAtIndex:10];
    XCTAssert(value == nil);
    value = arr[10];
    XCTAssert(value == nil);
}

- (void)testSetObjectAtIndexedSubscript {
    //本质是调用了 [__NSArrayM setObject:atIndexedSubscript:]
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    arr[4] = @"25";
    NSLog(@"arr: %@",arr);
}

- (void)testAddObjectAtIndex {
    
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    NSString *nilStr = nil;
    [arr addObject:nilStr];
    NSLog(@"arr: %@",arr);
}

- (void)testInsertObjectAtIndex {
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    [arr insertObject:@"cool" atIndex:5];
}

- (void)testRemoveObjectAtIndex {
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    [arr removeObjectAtIndex:5]; //[__NSArrayM removeObjectsInRange:]
}


- (void)testReplaceObjectAtIndex {
    id value = nil;
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    [arr replaceObjectAtIndex:10 withObject:value];
}


@end
