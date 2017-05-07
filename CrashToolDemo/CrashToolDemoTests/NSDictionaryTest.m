//
//  NSDictionaryTest.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSDictionaryTest : XCTestCase

@end

@implementation NSDictionaryTest

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

- (void)testInstance {
    
    //__NSPlaceholderDictionary
    id value = nil;
    NSString *nullStr = NULL;
    NSDictionary *dict = @{@"key1": @"", @"key2":@"a", @"key3":@"", @"key4":nullStr, @"key5":value};
    
    NSLog(@"dict: %@",dict);
}

@end
