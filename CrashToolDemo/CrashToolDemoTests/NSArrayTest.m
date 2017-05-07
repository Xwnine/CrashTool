//
//  NSArrayTest.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSArrayTest : XCTestCase

@end

@implementation NSArrayTest

- (void)setUp {
    [super setUp];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {

    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testInstance {
    NSString *nilStr = nil;
    NSString *nullStr = NULL;
    NSArray *array = @[@"Andrew", nilStr, @"ios", nullStr];
    NSLog(@"array: %@",array);
}

- (void)testObjectAtIndex {
    
    NSArray *arrI = @[@"iOS", @"Andrew", @"Man"]; //__NSArrayI
    NSArray *oneArrI = @[@"1"];  //__NSSingleObjectArrayI
    NSArray *arr = @[];            //__NSArray0
    NSObject *object = arr[100];
    object = arrI[100];
    object = oneArrI[100];
    NSLog(@"object: %@",object);
}

- (void)testArrayByAddingObject {
    id value = nil;
    NSArray *arrI = @[@"iOS", @"Andrew", @"Man"];
    [arrI arrayByAddingObject:value];
}

- (void)testSubArrayWithObject {
    NSArray *arrI = @[@"iOS", @"Andrew", @"Man"];
    arrI = [arrI subarrayWithRange:NSMakeRange(10, 10)];
}

@end
