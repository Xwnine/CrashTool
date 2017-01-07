//
//  NSObject+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSObject+Safe.h"
#import "StubProxy.h"
#import "NSObject+Swizzling.h"


#import <objc/runtime.h>

@implementation NSObject (Safe)

+ (void)safeToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMetod:@selector(forwardingTargetForSelector:) withSwizzledSel:@selector(safe_forwardingTargetForSelector:)];
        [self swizzleInstanceMetod:@selector(setValue:forUndefinedKey:) withSwizzledSel:@selector(safe_setValue:forUndefinedKey:)];
    });
}

- (void)safe_setValue:(id)value forUndefinedKey:(NSString *)key {

    if (![self containProperty:key] || !key) {
        return;
    }
    if (!value) {
      value = [NSNull null];
    }
    [self safe_setValue:value forUndefinedKey:key];
}


- (id)safe_forwardingTargetForSelector:(SEL)aSelector {

   id proxy = [self safe_forwardingTargetForSelector:aSelector];
    if (!proxy) {
        NSLog(@"[%@ %@]unrecognized selector crash\n\n%@\n", [self class], NSStringFromSelector(aSelector), [NSThread callStackSymbols]);
        proxy = [[StubProxy alloc] init];
    }
    return proxy;
}




@end
