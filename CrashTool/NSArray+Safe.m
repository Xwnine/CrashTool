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

+ (void)safeToolActive {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        @autoreleasepool {
            
            [objc_getClass("NSArray") swizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzledSel:@selector(array_arrayWithObjects:count:)];
            [objc_getClass("NSArray") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(array_subarrayWithRange:)];
            [objc_getClass("NSArray") swizzleInstanceMetod:@selector(objectsAtIndexes:) withSwizzledSel:@selector(array_objectsAtIndexes:)];
        
            [objc_getClass("__NSArrayI") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayI_subarrayWithRange:)];
            [objc_getClass("__NSArrayI") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayI_objectAtIndex:)];
            
            
            [objc_getClass("__NSArray0") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(array0_objectAtIndex:)];
            
            [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(NSSingleObjectArrayI_objectAtIndex:)];
            [objc_getClass("__NSSingleObjectArrayI") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(NSSingleObjectArrayI_subarrayWithRange:)];
            
            
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayM_objectAtIndex:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayM_subarrayWithRange:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(setObject:atIndexedSubscript:) withSwizzledSel:@selector(arrayM_setObject:atIndexedSubscript:)];
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(removeObjectAtIndex:) withSwizzledSel:@selector(arrayM_removeObjectAtIndex:)];
            
//            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(insertObject:atIndex:) withSwizzledSel:@selector(arrayM_insertObject:atIndex:)];
            
            [objc_getClass("__NSArrayM") swizzleInstanceMetod:@selector(addObject:) withSwizzledSel:@selector(arrayM_addObject:)];
            
        }
    });
}

+ (instancetype)array_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {

    NSUInteger index = 0;
    id _Nonnull __unsafe_unretained safeObjects[cnt];
    for (NSUInteger i=0; i<cnt; i++) {
        if (objects[i] != nil) {
            safeObjects[index] = objects[i];
            index++;
        }
    }
    return [self array_arrayWithObjects:safeObjects count:index];
}


- (NSArray *)array_objectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes.count >= self.count) {
        NSLog(@"array_objectsAtIndexes: range or index is beyound bounds");
        return nil;
    }
    return [self array_objectsAtIndexes:indexes];
}

#pragma mark -- subarrayWithRange:
- (NSArray *)array_subarrayWithRange:(NSRange)range {

    if ((range.location + range.length) > self.count) {
        NSLog(@"array_subarrayWithRange: range or index is beyound bounds");
        return nil;
    }
    return [self array_subarrayWithRange:range];
}

- (NSArray *)arrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"arrayI_subarrayWithRange: range or index is beyound bounds");
        return nil;
    }
    return [self arrayI_subarrayWithRange:range];
}


- (NSArray *)NSSingleObjectArrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        
        NSLog(@"NSSingleObjectArrayI_subarrayWithRange: range or index is beyound bounds");
        return nil;
    }
    return [self NSSingleObjectArrayI_subarrayWithRange:range];
}

- (NSArray *)arrayM_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) > self.count) {
        NSLog(@"arrayM_subarrayWithRange: range or index is beyound bounds");
        return nil;
    }
    return [self arrayM_subarrayWithRange:range];
}


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


#pragma mark -- MutableArray 专有
- (void)arrayM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        NSLog(@"arrayM_insertObject:atIndex: index is beyound bounds");
        return;
    }
    
    if (!anObject) {
        anObject = [NSNull null];
    }

    [self arrayM_insertObject:(id)anObject atIndex:index];
}

- (void)arrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.count) {
        NSLog(@"arrayM_setObject:atIndexedSubscript: index is beyound bounds");
        return;
    }
    
    if (!obj) {
        obj = [NSNull null];
    }
    [self arrayM_setObject:obj atIndexedSubscript:idx];
}

- (void)arrayM_addObject:(id)obj {

    if (!obj) {
        obj = [NSNull null];
    }
    [self arrayM_addObject:obj];
}

- (void)arrayM_removeObjectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        NSLog(@"arrayM_removeObjectAtIndex: index is beyound bounds");
        return;
    }
    
    [self arrayM_removeObjectAtIndex:index];
}

@end
