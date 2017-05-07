//
//  NSAttributedString+Safe.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSAttributedString+Safe.h"
#import "NSObject+Swizzle.h"



@implementation NSAttributedString (Safe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"NSConcreteAttributedString") swizzleInstanceMethod:@selector(initWithString:) withSwizzledSel:@selector(sf_initWithString:)];
        
        [NSClassFromString(@"NSConcreteAttributedString") swizzleInstanceMethod:@selector(initWithAttributedString:) withSwizzledSel:@selector(sf_initWithAttributedString:)];
        [NSClassFromString(@"NSConcreteAttributedString") swizzleInstanceMethod:@selector(initWithString:attributes:) withSwizzledSel:@selector(sf_initWithString:attributes:)];
    });
}


- (instancetype)sf_initWithString:(NSString *)str {
    if (!str) {
        NSLog(@"sf_initWithString: init with a nil string");
        return nil;
    }
    return [self sf_initWithString:str];
}

- (instancetype)sf_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    
    if (!str) {
        NSLog(@"sf_initWithString:attributes: init with a nil string ");
        return nil;
    }
    if (!attrs) {
        NSLog(@"sf_initWithString:attributes: init with a nil attrs ");
        return nil;
    }
    return [self sf_initWithString:str attributes:attrs];
}

- (instancetype)sf_initWithAttributedString:(NSAttributedString *)attrStr {
    
    if (!attrStr) {
        NSLog(@"sf_initWithAttributedString: init with a nil attrStr");
        return nil;
    }
    return [self sf_initWithAttributedString:attrStr];
}

@end
