//
//  NSMutableDictionary+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/5/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Swizzle.h"



@implementation NSMutableDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSDictionaryM") swizzleInstanceMethod:@selector(setObject:forKey:) withSwizzledSel:@selector(sf_setObject:forKey:)];
        [NSClassFromString(@"__NSDictionaryM") swizzleInstanceMethod:@selector(removeObjectForKey:) withSwizzledSel:@selector(sf_removeObjectForKey:)];
    });
}

- (void)sf_removeObjectForKey:(id)aKey {
    if (!aKey) {
        return;
    }
    [self sf_removeObjectForKey:aKey];
}

- (void)sf_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    [self sf_setObject:anObject forKey:aKey];
}

@end
