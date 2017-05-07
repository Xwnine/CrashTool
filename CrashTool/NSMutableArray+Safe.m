//
//  NSMutableArray+Safe.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzle.h"


@implementation NSMutableArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        //__NSArrayM
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(setObject:atIndexedSubscript:) withSwizzledSel:@selector(sf_setObject:atIndexedSubscript:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(insertObject:atIndex:) withSwizzledSel:@selector(sf_insertObject:atIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(removeObjectAtIndex:) withSwizzledSel:@selector(sf_removeObjectAtIndex:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(replaceObjectAtIndex:withObject:) withSwizzledSel:@selector(sf_replaceObjectAtIndex:withObject:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(removeObjectsInRange:) withSwizzledSel:@selector(sf_removeObjectsInRange:)];
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(subarrayWithRange:) withSwizzledSel:@selector(sf_subarrayWithRangeM:)];
    });
}


- (void)sf_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {

    if (idx >= self.count) {
        NSLog(@"sf_setObject[%@] idx:[%@] out of bound:[%@]", obj, @(idx), @(self.count));
        return;
    }
    
    if (!obj) {
        NSLog(@"sf_insertObject:[%@] atIndex:[%@]", obj, @(idx));
        return;
    }
    [self sf_setObject:obj atIndexedSubscript:idx];
}

- (void)sf_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        NSLog(@"sf_insertObject[%@] atIndex:[%@] out of bound:[%@]", anObject, @(index), @(self.count));
        return;
    }
    if (!anObject) {
        NSLog(@"sf_insertObject:[%@] atIndex:[%@]", anObject, @(index));
        return;
    }
    [self sf_insertObject:anObject atIndex:index];
}

- (void)sf_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"sf_removeObjectAtIndex atIndex:[%@] out of bound:[%@]", @(index), @(self.count));
        return;
    }
    return [self sf_removeObjectAtIndex:index];
}
- (void)sf_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= self.count) {
        NSLog(@"sf_replaceObjectAtIndex[%@] atIndex:[%@] out of bound:[%@]", anObject, @(index), @(self.count));
        return;
    }
    if (!anObject) {
        NSLog(@"sf_replaceObjectAtIndex:[%@] atIndex:[%@]", anObject, @(index));
        return;
    }
    [self sf_replaceObjectAtIndex:index withObject:anObject];
}


- (void)sf_removeObjectsInRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        NSLog(@"sf_removeObjectsInRange:[%@]", NSStringFromRange(range));
    }else {
        [self sf_removeObjectsInRange:range];
    }
}

- (NSArray *)sf_subarrayWithRangeM:(NSRange)range {
    if (range.location + range.length > self.count){
        NSLog(@"sf_subarrayWithRangeM:[%@]", NSStringFromRange(range));
        return self;
    }
    return [self sf_subarrayWithRangeM:range];
}

@end
