//
//  NSString+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSString+CrashTool.h"
#import "CrashTool.h"




@implementation NSString (CrashTool)

+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class strClass = NSClassFromString(@"__NSCFConstantString");
        
        [CrashTool swizzleInstanceMetod:@selector(characterAtIndex:) withSwizzledSel:@selector(flee_characterAtIndex:) class:strClass];
        [CrashTool swizzleInstanceMetod:@selector(substringFromIndex:) withSwizzledSel:@selector(flee_substringFromIndex:) class:strClass];
        [CrashTool swizzleInstanceMetod:@selector(substringWithRange:) withSwizzledSel:@selector(flee_substringWithRange:) class:strClass];
        
        [CrashTool swizzleInstanceMetod:@selector(stringByReplacingOccurrencesOfString:withString:) withSwizzledSel:@selector(flee_stringByReplacingOccurrencesOfString:withString:) class:strClass];
        
        [CrashTool swizzleInstanceMetod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSel:@selector(flee_stringByReplacingOccurrencesOfString:withString:options:range:) class:strClass];
        
        [CrashTool swizzleInstanceMetod:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSel:@selector(flee_stringByReplacingCharactersInRange:withString:) class:strClass];
        
    });
    
}


- (unichar)flee_characterAtIndex:(NSUInteger)index {

    unichar character;
    @try {
        character = [self flee_characterAtIndex:index];
    } @catch (NSException *exception) {
   
        [CrashTool  printExceptionLog:exception];
        
    } @finally {
        return character;
    }
}

- (NSString *)flee_substringFromIndex:(NSUInteger)from {

    NSString *str = nil;
    @try {
        str = [self flee_substringFromIndex:from];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
        str = nil;
    } @finally {
        
        return str;
    }
}

- (NSString *)flee_substringToIndex:(NSUInteger)to {

    NSString *str = nil;
    @try {
        str = [self flee_substringToIndex:to];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
        str = nil;
    } @finally {
        
        return str;
    }
}

- (NSString *)flee_substringWithRange:(NSRange)range {

    NSString *str = nil;
    @try {
        str = [self flee_substringWithRange:range];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
        //越界，将str赋值为nil，以免取到垃圾值
        str = nil;
    } @finally {
        return str;
    }
}

- (NSString *)flee_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {

    NSString *anotherStr = nil;
    @try {
        anotherStr = [self flee_stringByReplacingOccurrencesOfString:target withString:replacement];
    } @catch (NSException *exception) {
        //越界，或者目标字符串不存在
        [CrashTool  printExceptionLog:exception];
        anotherStr = nil;
    } @finally {
        
        return anotherStr;
    }
}

- (NSString *) flee_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {

    NSString *anotherStr = nil;
    @try {
        anotherStr = [self flee_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    } @catch (NSException *exception) {
        
        [CrashTool  printExceptionLog:exception];
        anotherStr = nil;
        
    } @finally {
        return  anotherStr;
    }
}

- (NSString *)flee_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {

    NSString *anotherStr = nil;
    @try {
        anotherStr = [self flee_stringByReplacingCharactersInRange:range withString:replacement];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
        anotherStr = nil;
        
    } @finally {
        return anotherStr;
    }
}




@end
