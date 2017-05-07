//
//  NSMutableString+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/5/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSMutableString+Safe.h"
#import "NSObject+Swizzle.h"



@implementation NSMutableString (Safe)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"__NSCFString") swizzleInstanceMethod:@selector(replaceCharactersInRange:withString:) withSwizzledSel:@selector(sf_replaceCharactersInRange:withString:)];
        [NSClassFromString(@"__NSCFString") swizzleInstanceMethod:@selector(insertString:atIndex:) withSwizzledSel:@selector(sf_insertString:atIndex:)];
        [NSClassFromString(@"__NSCFString") swizzleInstanceMethod:@selector(deleteCharactersInRange:) withSwizzledSel:@selector(sf_deleteCharactersInRange:)];
    });
}

- (void)sf_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {

    if (range.location + range.length > self.length) {
        NSLog(@"sf_replaceCharactersInRange: [%@]", NSStringFromRange(range));
        return;
    }
    
    if (!aString) {
        NSLog(@"sf_replaceCharactersInRange:%@", aString);
        return;
    }

    [self sf_replaceCharactersInRange:range withString:aString];
}

- (void)sf_insertString:(NSString *)aString atIndex:(NSUInteger)loc {

    if (!aString) {
        NSLog(@"sf_replaceCharactersInRange:%@", aString);
        return;
    }
    
    if (loc > self.length) {
        NSLog(@"characterAtIndex: loc is beyound of bounds: %lu", loc);
        return;
    }
    [self sf_insertString:aString atIndex:loc];
}

- (void)sf_deleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        NSLog(@"sf_deleteCharactersInRange: [%@]", NSStringFromRange(range));
        return;
    }
    [self sf_deleteCharactersInRange:range];
}

@end
