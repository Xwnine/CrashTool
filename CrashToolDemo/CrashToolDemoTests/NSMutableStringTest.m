//
//  NSMutableString.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSMutableStringTest : XCTestCase

@end

@implementation NSMutableStringTest

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

- (void)testReplaceCharInRange {
    
    NSMutableString *strM = [NSString stringWithFormat:@"osiosiosos"].copy;
    //-[__NSCFString replaceCharactersInRange:withString:]
    NSRange range = NSMakeRange(0, 1000);
    [strM replaceCharactersInRange:range withString:@"--"];
    NSLog(@"strM: %@",strM);
}

- (void)testInsertStringAtIndex{
    NSMutableString *strM = [NSString stringWithFormat:@"xxxooAndew"].copy;
    
    //-[__NSCFString insertString:atIndex:]:
    [strM insertString:@"cool" atIndex:1000];
    NSLog(@"str: %@",strM);
}

- (void)testDeleteCharAtRange{
    NSMutableString *strM = [NSString stringWithFormat:@"xxxooAndew"].copy;
    //-[__NSCFString deleteCharactersInRange:]
    [strM deleteCharactersInRange:NSMakeRange(0, 100)];
    NSLog(@"str: %@",strM);
}

@end
