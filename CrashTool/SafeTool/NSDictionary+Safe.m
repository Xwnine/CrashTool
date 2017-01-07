//
//  NSDictionary+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzling.h"


@implementation NSDictionary (Safe)
+ (void)safeToolActive {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSel:@selector(safe_dictionaryWithObjects:forKeys:count:)];
        
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        [dictionaryM swizzleInstanceMetod:@selector(setObject:forKey:) withSwizzledSel:@selector(safe_setObject:forKey:)];
        [dictionaryM swizzleInstanceMetod:@selector(removeObjectForKey:) withSwizzledSel:@selector(safe_removeObjectForKey:)];
    });
}


+ (instancetype)safe_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {

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
    return [self safe_dictionaryWithObjects:safeObjects forKeys:safeKeys count:index];
}

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (!aKey) {
        return;
    }
    
    if (!anObject) {
        anObject = [NSNull null];
    }
    [self safe_setObject:anObject forKey:aKey];
}


- (void)safe_removeObjectForKey:(id)aKey {
    
    if (!aKey) {
        return;
    }
    [self safe_removeObjectForKey:aKey];
}

@end
