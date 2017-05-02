//
//  NSArray+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        @autoreleasepool {
            
            [objc_getClass("NSArray") swizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzledSel:@selector(array_arrayWithObjects:count:)];
            [objc_getClass("NSArray") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(array_subarrayWithRange:)];
            [objc_getClass("NSArray") swizzleInstanceMetod:@selector(objectsAtIndexes:) withSwizzledSel:@selector(array_objectsAtIndexes:)];
            [objc_getClass("__NSArrayI") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayI_subarrayWithRange:)];
            [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(NSSingleObjectArrayI_subarrayWithRange:)];

            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayM_subarrayWithRange:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(setObject:atIndexedSubscript:) withSwizzledSel:@selector(arrayM_setObject:atIndexedSubscript:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(removeObjectAtIndex:) withSwizzledSel:@selector(arrayM_removeObjectAtIndex:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(insertObject:atIndex:) withSwizzledSel:@selector(arrayM_insertObject:atIndex:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(replaceObjectAtIndex:withObject:) withSwizzledSel:@selector(arrayM_replaceObjectAtIndex:withObject:)];
            
        }
    });
}

+ (instancetype)array_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {

    NSUInteger count = 0;
    id safeObjects[cnt];
    for (NSUInteger i=0; i<cnt; i++) {
        if (objects[i] != nil) {
            safeObjects[count] = objects[i];
            count++;
        }
    }
    return [self array_arrayWithObjects:safeObjects count:count];
}


- (NSArray *)array_objectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes.count >= self.count) {
        return nil;
    }
    return [self array_objectsAtIndexes:indexes];
}

#pragma mark -- subarrayWithRange:
- (NSArray *)array_subarrayWithRange:(NSRange)range {
    if ((range.location + range.length) > self.count) {
        return nil;
    }
    return [self array_subarrayWithRange:range];
}

- (NSArray *)arrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        return nil;
    }
    return [self arrayI_subarrayWithRange:range];
}


- (NSArray *)NSSingleObjectArrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        return nil;
    }
    return [self NSSingleObjectArrayI_subarrayWithRange:range];
}

- (NSArray *)arrayM_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        return nil;
    }
    return [self arrayM_subarrayWithRange:range];
}




#pragma mark -- MutableArray 专有
- (void)arrayM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        return;
    }
    
    if (!anObject) {
        return;
    }

    [self arrayM_insertObject:(id)anObject atIndex:index];
}

- (void)arrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count) {
        return;
    }
    
    if (!obj) {
        return;
    }
    [self arrayM_setObject:obj atIndexedSubscript:idx];
}

- (void)arrayM_removeObjectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        return;
    }
    
    [self arrayM_removeObjectAtIndex:index];
}


- (void)arrayM_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= [self count]) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self arrayM_replaceObjectAtIndex:index withObject:anObject];
}
@end
