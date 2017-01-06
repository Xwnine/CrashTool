//
//  NSArray+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSArray+CrashTool.h"
#import "CrashTool.h"



@implementation NSArray (CrashTool)

+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        

        [CrashTool swizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzledSel:@selector(flee_arrayWithObjects:count:) class:[self class]];
        
        //1.NSArray 本身的
        [CrashTool swizzleInstanceMetod:@selector(getObjects:range:) withSwizzledSel:@selector(flee_getObjects:range:) class:[self class]];
        
        [CrashTool swizzleInstanceMetod:@selector(objectsAtIndexes:) withSwizzledSel:@selector(flee_objectsAtIndexes:) class:[self class]];
        

        //运行时中间会被调用的
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");

        [CrashTool swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(__NSArray_objectAtIndex:) class:__NSArrayI];
        [CrashTool swizzleInstanceMetod:@selector(getObjects:range:) withSwizzledSel:@selector(__NSArray_getObjects:range:) class:__NSArrayI];
     
        
        
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        [CrashTool swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(__NSArray0_objectAtIndex:) class:__NSArray0];
  
        
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        [CrashTool swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(__NSSingleObjectArrayI_objectAtIndex:) class:__NSSingleObjectArrayI];

        [CrashTool swizzleInstanceMetod:@selector(getObjects:range:) withSwizzledSel:@selector(__NSSingleObjectArrayI_getObjects:range:) class:__NSSingleObjectArrayI];
        
    });
}



#pragma Mark  -- NSArray相关
+ (instancetype)flee_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {

    id instance = nil;
    @try {
        instance = [self flee_arrayWithObjects:objects count:cnt];
        
    } @catch (NSException *exception) {
        
        NSLog(@"exception: %@",exception.reason);
        NSLog(@"exception: %@", [NSThread callStackSymbols]);

        //去掉nil，然后初始化数组
        NSInteger fleeObjcIndex = 0;
        
        //创建一个C语言类型的数组
        id _Nonnull __unsafe_unretained fleeObjects[cnt];
        for (int i=0; i<cnt; i++) {
            
            if (objects[i] != nil) {
                fleeObjects[fleeObjcIndex] = objects[i];
                fleeObjcIndex++;
            }
        }
        
      instance = [self flee_arrayWithObjects:fleeObjects count:fleeObjcIndex];
    } @finally {
        return instance;
    }
}


- (NSArray *)flee_objectsAtIndexes:(NSIndexSet *)indexes {

    NSArray *objects = nil;
    @try {
        objects = [self flee_objectsAtIndexes:indexes];
        
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
    } @finally {
        return objects;
    }
}



- (void)flee_getObjects:(const id _Nonnull __unsafe_unretained *)objects range:(NSRange)range{

    @try {
        [self flee_getObjects:objects range:range];
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}


#pragma mark -- __NSArrayI
- (id)__NSArray_objectAtIndex:(NSUInteger)index {
    
    id objc = nil;
    
    @try {
        objc = [self __NSArray_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
        
    } @finally {
        return objc;
    }
}

- (void)__NSArray_getObjects:(const id _Nonnull __unsafe_unretained *)objects range:(NSRange)range {

    @try {
        [self __NSArray_getObjects:objects range:range];
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}

#pragma mark -- __NSArray0
- (id)__NSArray0_objectAtIndex:(NSUInteger)index {
    
    id objc = nil;
    
    @try {
        objc = [self __NSArray0_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
        
    } @finally {
        return objc;
    }
}

#pragma mark __NSSingleObjectArrayI
- (id)__NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    
    id objc = nil;
    
    @try {
        objc = [self __NSSingleObjectArrayI_objectAtIndex:index];
        
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
        
    } @finally {
        return objc;
    }
}

- (void)__NSSingleObjectArrayI_getObjects:(const id _Nonnull __unsafe_unretained *)objects range:(NSRange)range {
    
    @try {
        [self __NSSingleObjectArrayI_getObjects:objects range:range];
    } @catch (NSException *exception) {
        NSLog(@"exception reason: %@",exception.reason);
        NSLog(@"exception : %@", [NSThread callStackSymbols]);
    } @finally {
        
    }
}



@end
