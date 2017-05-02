//
//  NSDictionary+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSDictionaryI") swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSel:@selector(dictionaryI_dictionaryWithObjects:forKeys:count:)];
            
            [objc_getClass("__NSDictionaryM") swizzleInstanceMetod:@selector(setObject:forKey:) withSwizzledSel:@selector(dictionaryM_setObject:forKey:)];
            [objc_getClass("__NSDictionaryM") swizzleInstanceMetod:@selector(setObject:forKeyedSubscript:) withSwizzledSel:@selector(dictionaryM_setObject:forKeyedSubscript:)];
            [objc_getClass("__NSDictionaryM") swizzleInstanceMetod:@selector(removeObjectForKey:) withSwizzledSel:@selector(dictionaryM_removeObjectForKey:)];
        }
    });
}


+ (instancetype)dictionaryI_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {

    id  _Nonnull __unsafe_unretained safeObjects[cnt];
    id  <NSCopying>  _Nonnull __unsafe_unretained safeKeys[cnt];
    
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] && keys[i]) {
            safeKeys[index] = keys[i];
            safeObjects[index] = objects[i];
            index++;
        }
    }
    return [self dictionaryI_dictionaryWithObjects:safeObjects forKeys:safeKeys count:index];
}

- (void)dictionaryM_setObject:(id)anObject forKey:(id)aKey {
    
    if (!aKey) {
        return;
    }
    
    if (!anObject) {
        return;
    }
    
    [self dictionaryM_setObject:anObject forKey:aKey];
}

- (void)dictionaryM_setObject:(id)obj forKeyedSubscript:(id)key {

    if (!key) {
        return;
    }
    
    if (!obj) {
        return;
    }
    
    [self dictionaryM_setObject:obj forKeyedSubscript:key];
}


- (void)dictionaryM_removeObjectForKey:(id)aKey {
    
    if (!aKey) {
        return;
    }
    [self dictionaryM_removeObjectForKey:aKey];
}


@end


@implementation NSNull (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNull swizzleInstanceMetod:@selector(methodSignatureForSelector:) withSwizzledSel:@selector(safe_methodSignatureForSelector:)];
        [NSNull swizzleInstanceMetod:@selector(forwardInvocation:) withSwizzledSel:@selector(safe_forwardInvocation:)];
    });
}

- (NSMethodSignature *)safe_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [self safe_methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return [NSMethodSignature signatureWithObjCTypes:@encode(void)];
}

- (void)safe_forwardInvocation:(NSInvocation *)anInvocation {
    NSUInteger returnLength = [[anInvocation methodSignature] methodReturnLength];
    if (!returnLength) {
        return;
    }
    
    // set return value to all zero bits
    char buffer[returnLength];
    memset(buffer, 0, returnLength);
    
    [anInvocation setReturnValue:buffer];
}


@end
