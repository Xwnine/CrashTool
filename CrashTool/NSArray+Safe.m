//
//  NSArray+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzle.h"


@implementation NSArray (Safe)

+ (void)load {

    static dispatch_once_t onceTokne;
    @autoreleasepool {
        dispatch_once(&onceTokne, ^{
            //NSArray
            [self swizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzledSel:@selector(sf_arrayWithObjects:count:)];
            
            [NSClassFromString(@"__NSPlaceholderArray") swizzleInstanceMethod:@selector(initWithObjects:count:) withSwizzledSel:@selector(sf_initWithObjects:count:)];
            
            //__NSArrayI
            [NSClassFromString(@"__NSArrayI") swizzleInstanceMethod:@selector(objectAtIndex:) withSwizzledSel:@selector(sf_objectAtIndex:)];
            [NSClassFromString(@"__NSArrayI") swizzleInstanceMethod:@selector(subarrayWithRange:) withSwizzledSel:@selector(sf_subarrayWithRange:)];
            [NSClassFromString(@"__NSArrayI") swizzleInstanceMethod:@selector(arrayByAddingObject:) withSwizzledSel:@selector(sf_arrayByAddingObject:)];
            
            //__NSSingleObjectArrayI
            [NSClassFromString(@"__NSSingleObjectArrayI") swizzleInstanceMethod:@selector(objectAtIndex:) withSwizzledSel:@selector(sf_singleObjectArrayI:)];
            [NSClassFromString(@"__NSSingleObjectArrayI") swizzleInstanceMethod:@selector(subarrayWithRange:) withSwizzledSel:@selector(sf_singleObjectArraySubarrayWithRange:)];
            //__NSArray0
            [NSClassFromString(@"__NSArray0") swizzleInstanceMethod:@selector(objectAtIndex:) withSwizzledSel:@selector(sf_objectAtIndex0:)];
            [NSClassFromString(@"__NSArray0") swizzleInstanceMethod:@selector(subarrayWithRange:) withSwizzledSel:@selector(sf_subarrayWithRange:)];
        });
    }
}


+ (instancetype)sf_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {

    NSInteger index = 0;
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (objects[i]) {
            objs[index++] = objects[i];
        }
    }
    return [self sf_arrayWithObjects:objs count:index];
}

- (instancetype)sf_initWithObjects:(const id [])objects count:(NSUInteger)cnt {
    
    NSInteger index = 0;
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (objects[i]) {
            objs[index++] = objects[i];
        }
    }
    return [self sf_initWithObjects:objs count:index];
}

- (id)sf_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"sf_objectAtIndex atIndex:[%@] out of bound:[%@]", @(index), @(self.count));
        return nil;
    }
    return [self sf_objectAtIndex:index];
}


- (id)sf_singleObjectArrayI:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"sf_objectAtIndex atIndex:[%@] out of bound:[%@]", @(index), @(self.count));
        return nil;
    }
    return [self sf_singleObjectArrayI:index];
}

- (NSArray *)sf_singleObjectArraySubarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count){
        NSLog(@"sf_subarrayWithRange:[%@]", NSStringFromRange(range));
        return self;
    }
    return [self sf_singleObjectArraySubarrayWithRange:range];
}

- (id)sf_objectAtIndex0:(NSUInteger)index {
    return nil;
}

- (NSArray *)sf_subarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count){
        NSLog(@"sf_subarrayWithRange:[%@]", NSStringFromRange(range));
        return self;
    }
    return [self sf_subarrayWithRange:range];
}

- (NSArray *)sf_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        return self;
    }
    return [self sf_arrayByAddingObject:anObject];
}

@end


