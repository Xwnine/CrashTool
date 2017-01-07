//
//  NSArray+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzling.h"


@implementation NSArray (Safe)

+ (void)safeToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        [self swizzleClassMethod:@selector(arrayWithObjects:count:) withSwizzledSel:@selector(safe_arrayWithObjects:count:)];
        [self swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(safe_subarrayWithRange:)];
        [self swizzleInstanceMetod:@selector(objectsAtIndexes:) withSwizzledSel:@selector(safe_objectsAtIndexes:)];

        
        Class arrayI = NSClassFromString(@"__NSArrayI");
        [arrayI swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayI_subarrayWithRange:)];
        [arrayI swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayI_objectAtIndex:)];

        
        Class array0 = NSClassFromString(@"__NSArray0");
        [array0 swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(array0_objectAtIndex:)];
        
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        [__NSSingleObjectArrayI swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(NSSingleObjectArrayI_objectAtIndex:)];
        [__NSSingleObjectArrayI swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(NSSingleObjectArrayI_subarrayWithRange:)];
        
        
        Class arrayM = NSClassFromString(@"__NSArrayM");
        [arrayM swizzleInstanceMetod:@selector(objectAtIndex:) withSwizzledSel:@selector(arrayM_objectAtIndex:)];
        
        
        [arrayM swizzleInstanceMetod:@selector(subarrayWithRange:) withSwizzledSel:@selector(arrayM_subarrayWithRange:)];
        [arrayM swizzleInstanceMetod:@selector(insertObject:atIndex:) withSwizzledSel:@selector(arrayM_insertObject:atIndex:)];
        [arrayM swizzleInstanceMetod:@selector(setObject:atIndexedSubscript:) withSwizzledSel:@selector(arrayM_setObject:atIndexedSubscript:)];
        [arrayM swizzleInstanceMetod:@selector(removeObjectAtIndex:) withSwizzledSel:@selector(arrayM_removeObjectAtIndex:)];
        
    });
}

+ (instancetype)safe_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {

    //去掉nil，然后初始化数组
    NSUInteger index = 0;
    //创建一个C语言类型的数组
    id _Nonnull __unsafe_unretained safeObjects[cnt];
    for (NSUInteger i=0; i<cnt; i++) {
        if (objects[i] != nil) {
            safeObjects[index] = objects[i];
            index++;
        }
    }
    return [self safe_arrayWithObjects:safeObjects count:index];
}


- (NSArray *)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes.count >= self.count) {
        return nil;
    }
    return [self safe_objectsAtIndexes:indexes];
}


#pragma mark -- subarrayWithRange:
- (NSArray *)safe_subarrayWithRange:(NSRange)range {

    if ((range.location + range.length) >= self.count) {
        return nil;
    }
    return [self safe_subarrayWithRange:range];
}

- (NSArray *)arrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) >= self.count) {
        return nil;
    }
    return [self arrayI_subarrayWithRange:range];
}


- (NSArray *)NSSingleObjectArrayI_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) >= self.count) {
        return nil;
    }
    return [self NSSingleObjectArrayI_subarrayWithRange:range];
}

- (NSArray *)arrayM_subarrayWithRange:(NSRange)range {
    
    if ((range.location + range.length) >= self.count) {
        return nil;
    }
    return [self arrayM_subarrayWithRange:range];
}


#pragma mark -- objectAtIndex:
- (id)NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {

    if (index >= self.count) {
        return nil;
    }
    return [self NSSingleObjectArrayI_objectAtIndex:index];
}

- (id)array0_objectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        return nil;
    }
    return [self array0_objectAtIndex:index];
}

- (id)arrayI_objectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) {
        return nil;
    }
    return [self arrayI_objectAtIndex:index];
}

- (id)arrayM_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self arrayM_objectAtIndex:index];
}


#pragma mark -- MutableArray 专有
- (void)arrayM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (anObject && index < self.count) {
        [self arrayM_insertObject:(id)anObject atIndex:index];
    }
}

- (void)arrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    if (obj && idx < self.count) {
        [self arrayM_setObject:obj atIndexedSubscript:idx];
    }
}

- (void)arrayM_removeObjectAtIndex:(NSUInteger)index {
    
    if (index < self.count) {
        [self arrayM_removeObjectAtIndex:index];
    }
}




@end
