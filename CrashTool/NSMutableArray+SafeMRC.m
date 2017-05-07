//
//  NSMutableArray+SafeMRC.m
//  CrashTool
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSMutableArray+SafeMRC.h"
#import "NSObject+Swizzle.h"






@implementation NSMutableArray (SafeMRC)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSArrayM") swizzleInstanceMethod:@selector(objectAtIndex:) withSwizzledSel:@selector(sf_objectAtIndexM:)];
    });
}

- (id)sf_objectAtIndexM:(NSUInteger)index {
    if (index >= self.count) {
        NSLog(@"sf_objectAtIndex atIndex:[%@] out of bound:[%@]", @(index), @(self.count));
        return nil;
    }
    return [self sf_objectAtIndexM:index];
}

@end
