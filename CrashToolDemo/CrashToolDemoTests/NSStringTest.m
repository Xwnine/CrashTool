//
//  NSStringTest.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSStringTest : XCTestCase

@end

@implementation NSStringTest

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


- (void)testCharacterAtIndex {
    
    NSString *str  = @"Andrew";
    unichar characteristic = [str characterAtIndex:100];// __NSCFConstantString characterAtIndex:
    NSLog(@"--c-- : %c",characteristic);
}

- (void)testSubStringFromIndex {
    
    NSString *str = @"iosdeveloper";
    NSString *subStr = [str substringFromIndex:100]; //__NSCFConstantString substringFromIndex:
    NSLog(@"subStr: %@", subStr);
}

- (void)testSubStringWithRange {
    
    NSString *str = @"iosDeveloper";
    NSString *subStr = [str substringWithRange:NSMakeRange(0, 100)]; //-[__NSCFConstantString substringWithRange:]
    NSLog(@"subStr: %@", subStr);
}

- (void)testStringByReplacingOccurrenesOfString {
    
    NSString *str = @"AndrewDeveloper";
    //    NSString *nilStr = nil;
    NSString *targetStr = @"age";
    str = [str stringByReplacingOccurrencesOfString:targetStr withString:targetStr]; //[__NSCFConstantString stringByReplacingOccurrencesOfString:withString:options:range:]
    NSLog(@"subStr: %@",str);
    
}


- (void)testStringByReplacingOccurrencesOfStringRange {
    
    NSString *str = @"ioososososo";
    NSRange range = NSMakeRange(0, 1000);
    str = [str stringByReplacingOccurrencesOfString:@"chen" withString:@"" options:NSCaseInsensitiveSearch range:range]; //-[__NSCFString replaceOccurrencesOfString:withString:options:range:]
    
    NSLog(@"%@",str);
}

- (void)testStringReplacingCharactersInRangWithString {
    
    NSString *str = @"iphoneiosmacmacos";
    NSRange range = NSMakeRange(0, 100);
    str = [str stringByReplacingCharactersInRange:range withString:@"os"];//__NSCFString replaceCharactersInRange:withString:]
    NSLog(@"str: %@", str);
}

@end
