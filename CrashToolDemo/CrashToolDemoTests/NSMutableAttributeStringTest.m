//
//  NSMutableAttributeStringTest.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSMutableAttributeStringTest : XCTestCase

@end

@implementation NSMutableAttributeStringTest

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

- (void)testInitWithString {
    
    NSString *nilStr = nil;
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:nilStr];//NSConcreteMutableAttributedString initWithString:
    
    NSLog(@"attribue: %@",attribute);
}

- (void)testInitWithStringAttributes {
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSString *nilStr = nil;
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr attributes:attributes]; //NSConcreteMutableAttributedString initWithString:attributes:
    NSLog(@"%@",attrStrM);
    
}

@end
