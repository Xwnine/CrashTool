//
//  NSMutableDictionary+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSMutableDictionary+CrashTool.h"
#import "CrashTool.h"

@implementation NSMutableDictionary (CrashTool)

+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        [CrashTool swizzleInstanceMetod:@selector(setObject:forKey:) withSwizzledSel:@selector(flee_setObject:forKey:) class:dictionaryM];
        [CrashTool swizzleInstanceMetod:@selector(removeObjectForKey:) withSwizzledSel:@selector(flee_removeObjectForKey:) class:dictionaryM];
    });
}


- (void)flee_setObject:(id)anObject forKey:(id<NSCopying>)aKey {

    @try {
        
        [self flee_setObject:anObject forKey:aKey];
        
    } @catch (NSException *exception) {
        //打印出异常数据
        
        [CrashTool  printExceptionLog:exception];
        
    } @finally {
     
    }

}

- (void)flee_removeObjectForKey:(id)aKey {

    @try {
        [self flee_removeObjectForKey:aKey];
    } @catch (NSException *exception) {
        //打印出异常数据
        [CrashTool  printExceptionLog:exception];
    } @finally {
    }
}



@end
