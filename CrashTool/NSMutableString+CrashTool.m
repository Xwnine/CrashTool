//
//  NSMutableString+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/23.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSMutableString+CrashTool.h"
#import "CrashTool.h"



@implementation NSMutableString (CrashTool)

+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class CFStrClass = NSClassFromString(@"__NSCFString");
        [CrashTool swizzleInstanceMetod:@selector(replaceCharactersInRange:withString:) withSwizzledSel:@selector(flee_replaceCharactersInRange:withString:) class:CFStrClass];
        [CrashTool swizzleInstanceMetod:@selector(insertString:atIndex:) withSwizzledSel:@selector(flee_insertString:atIndex:) class:CFStrClass];
        [CrashTool swizzleInstanceMetod:@selector(deleteCharactersInRange:) withSwizzledSel:@selector(flee_deleteCharactersInRange:) class:CFStrClass];
    });
}




- (void)flee_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {

    @try {
        [self flee_replaceCharactersInRange:range withString:aString];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
    } @finally {
        
    }
}



- (void)flee_insertString:(NSString *)aString atIndex:(NSUInteger)loc {

    @try {
        [self flee_insertString:aString atIndex:loc];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
    } @finally {
        
    }
}

- (void)flee_deleteCharactersInRange:(NSRange)range {

    @try {
        [self flee_deleteCharactersInRange:range];
    } @catch (NSException *exception) {
        [CrashTool  printExceptionLog:exception];
    } @finally {
        
    }
}




@end
