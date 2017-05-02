//
//  NSObject+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSObject+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Safe)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("NSObject") swizzleInstanceMetod:@selector(setValue:forUndefinedKey:) withSwizzledSel:@selector(object_setValue:forUndefinedKey:)];
            [objc_getClass("NSObject") swizzleInstanceMetod:@selector(setValue:forKey:) withSwizzledSel:@selector(object_setValue:forKey:)];
        }
    });
}

- (void)object_setValue:(id)value forKey:(NSString *)key {

    if (!key) {
        NSLog(@"setValue:forKey: key is nil");
        return;
    }
    if (!value) {
        NSLog(@"setValue:forKey: value is nil");
        value = [NSNull null];
    }
    [self object_setValue:value forKey:key];
}


- (void)object_setValue:(id)value forUndefinedKey:(NSString *)key {

    if (!key || ![self containProperty:key]) {
        NSLog(@"setValue:forUndefinedKey: key is nil or key not exist");
        return;
    }
    
    if (!value) {
        NSLog(@"setValue:forUndefinedKey: value is nil");
        value = [NSNull null];
    }
    [self object_setValue:value forUndefinedKey:key];
}





@end
