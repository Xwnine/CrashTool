//
//  NSAttributedString+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/23.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSAttributedString+CrashTool.h"
#import "CrashTool.h"



@implementation NSAttributedString (CrashTool)
+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class anClass = NSClassFromString(@"NSConcreteAttributedString");
        [CrashTool swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(flee_initWithString:) class:anClass];
        
        [CrashTool swizzleInstanceMetod:@selector(initWithAttributedString:) withSwizzledSel:@selector(flee_initWithAttributedString:) class:anClass];
        [CrashTool swizzleInstanceMetod:@selector(initWithString:attributes:) withSwizzledSel:@selector(flee_initWithString:attributes:) class:anClass];
    });
    
    
}

- (instancetype)flee_initWithString:(NSString *)str {

    id instance = nil;
    @try {
        instance = [self flee_initWithString:str];
    } @catch (NSException *exception) {
        
        [CrashTool  printExceptionLog:exception];
        
    } @finally {
        
        return instance;
    }
}

- (instancetype)flee_initWithAttributedString:(NSAttributedString *)attrStr {
    id instance = nil;
    @try {
        instance = [self flee_initWithAttributedString:attrStr];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
    } @finally {
        return instance;
    }
    
}

- (instancetype)flee_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {

    id instance = nil;
    @try {
        instance = [self flee_initWithString:str attributes:attrs];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
        
    } @finally {
        return instance;
    }
}




@end
