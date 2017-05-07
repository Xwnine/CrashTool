//
//  NSDictionary+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzle.h"


@implementation NSDictionary (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSPlaceholderDictionary") swizzleInstanceMethod:@selector(initWithObjects:forKeys:count:) withSwizzledSel:@selector(sf_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)sf_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id<NSCopying> safeKeys[cnt];
    NSUInteger index = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] && keys[i]) {
            safeKeys[index] = keys[i];
            safeObjects[index] = objects[i];
            ++index;
        }else {
            NSLog(@"sf_dictionaryWithObjects:[%@] forKey:[%@]", objects[i], keys[i]);
        }
    }
    return [self sf_initWithObjects:safeObjects forKeys:safeKeys count:index];
}


@end
