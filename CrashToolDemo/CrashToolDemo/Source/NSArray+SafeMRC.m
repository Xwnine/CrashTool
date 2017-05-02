//
//  NSArray+SafeMRC.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSArray+SafeMRC.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>


@implementation NSArray (SafeMRC)



#pragma mark -- objectAtIndex:
- (id)NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        NSLog(@"NSSingleObjectArrayI_objectAtIndex: index is beyound bounds");
        return nil;
    }
    return [self NSSingleObjectArrayI_objectAtIndex:index];
}

- (id)array0_objectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        NSLog(@"array0_objectAtIndex: index is beyound bounds");
        return nil;
    }
    return [self array0_objectAtIndex:index];
}

- (id)arrayI_objectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        NSLog(@"arrayI_objectAtIndex: index is beyound bounds");
        return nil;
    }
    return [self arrayI_objectAtIndex:index];
}

- (id)arrayM_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"arrayM_objectAtIndex: index is beyound bounds");
        return nil;
    }
    return [self arrayM_objectAtIndex:index];
}




+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayI_objectAtIndex:)];
        [objc_getClass("__NSArray0") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(array0_objectAtIndex:)];
        [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayM_objectAtIndex:)];
        [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(NSSingleObjectArrayI_objectAtIndex:)];
    });
}
@end
