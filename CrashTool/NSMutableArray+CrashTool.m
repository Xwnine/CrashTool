//
//  NSMutableArray+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/22.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSMutableArray+CrashTool.h"
#import "CrashTool.h"



@implementation NSMutableArray (FleCrash)

+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class mClass = NSClassFromString(@"__NSArrayM");
        
        [CrashTool swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(flee_objectAtIndex:) class:mClass];
        [CrashTool swizzleInstanceMetod:@selector(getObjects:range:) withSwizzledSel:@selector(flee_getObjects:range:) class:mClass];
        
        [CrashTool swizzleInstanceMetod:@selector(setObject:atIndexedSubscript:) withSwizzledSel:@selector(flee_setObject:atIndexedSubscript:) class:mClass];
        [CrashTool swizzleInstanceMetod:@selector(insertObject:atIndex:) withSwizzledSel:@selector(flee_insertObject:atIndex:) class:mClass];
        
        [CrashTool swizzleInstanceMetod:@selector(removeObjectAtIndex:) withSwizzledSel:@selector(flee_removeObjectAtIndex:) class:mClass];

    });
    
}



- (id)flee_objectAtIndex:(NSUInteger)index {

    id objc = nil;
    @try {
        objc = [self flee_objectAtIndex:index];
    } @catch (NSException *exception) {
        
        NSLog(@"exception reason: %@", exception.reason);
        NSLog(@"exception stack: %@", [NSThread callStackSymbols]);
        
    } @finally {
        return  objc;
    }
    
}

- (void)flee_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self flee_getObjects:objects range:range];
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@", exception.reason);
        NSLog(@"exception stack: %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}


- (void)flee_setObject:(id)objc atIndexedSubscript:(NSUInteger)idx {

    @try {
        [self flee_setObject:objc atIndexedSubscript:idx];
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@", exception.reason);
        NSLog(@"exception stack: %@", [NSThread callStackSymbols]);
        
    } @finally {
        
    }
    
}

- (void)flee_insertObject:(id)anObject atIndex:(NSUInteger)index {

    @try {
        [self flee_insertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        
        NSLog(@"exception reason: %@", exception.reason);
        NSLog(@"exception stack: %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}


- (void)flee_removeObjectAtIndex:(NSUInteger)index {

    @try {
        [self flee_removeObjectAtIndex:index];
        
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@", exception.reason);
        NSLog(@"exception stack: %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}











@end
