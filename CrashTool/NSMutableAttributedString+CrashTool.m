//
//  NSMutableAttributedString+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/23.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSMutableAttributedString+CrashTool.h"
#import "CrashTool.h"





@implementation NSMutableAttributedString (CrashTool)


+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class anClass = NSClassFromString(@"NSConcreteMutableAttributedString");
        [CrashTool swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(flee_initWithString:) class:anClass];
        
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
