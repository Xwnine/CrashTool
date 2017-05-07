//
//  NSString+Safe.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/3.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSString+Safe.h"
#import "NSObject+Swizzle.h"


@implementation NSString (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"__NSCFConstantString") swizzleInstanceMethod:@selector(characterAtIndex:) withSwizzledSel:@selector(sf_characterAtIndex:)];
        [NSClassFromString(@"__NSCFConstantString") swizzleInstanceMethod:@selector(substringFromIndex:) withSwizzledSel:@selector(sf_substringFromIndex:)];
        [NSClassFromString(@"__NSCFConstantString") swizzleInstanceMethod:@selector(substringWithRange:) withSwizzledSel:@selector(sf_substringWithRange:)];
        [NSClassFromString(@"__NSCFConstantString") swizzleInstanceMethod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSel:@selector(sf_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [NSClassFromString(@"__NSCFConstantString") swizzleInstanceMethod:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSel:@selector(sf_stringByReplacingCharactersInRange:withString:)];
    });
}


- (unichar)sf_characterAtIndex:(NSUInteger)index {
    if (index > self.length) {
        NSLog(@"characterAtIndex: index is beyound of bounds: %lu", index);
        return 0;
    }
    return [self sf_characterAtIndex:index];
}

- (NSString *)sf_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        NSLog(@"sf_subarrayWithRange:[%@]", NSStringFromRange(range));
        return self;
    }
    return [self sf_substringWithRange:range];
}

- (NSString *)sf_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        NSLog(@"characterAtIndex: index is beyound of bounds: %lu", from);
        return self;
    }
    return [self sf_substringFromIndex:from];
}

- (NSString *)sf_substringToIndex:(NSUInteger)to {

    if (to > self.length) {
        NSLog(@"sf_substringToIndex: index is beyound of bounds: %lu", to);
        return self;
    }
    return [self sf_substringToIndex:to];
}



- (NSString *)sf_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {

    if (range.location + range.length > self.length) {
        NSLog(@"sf_stringByReplacingCharactersInRange:[%@]", NSStringFromRange(range));
        return self;
    }

    if (!replacement) {
        NSLog(@"sf_stringByReplacingCharactersInRange:withString:[%@]", replacement);
        return self;
    }
    return [self sf_stringByReplacingCharactersInRange:range withString:replacement];

}

- (NSString *)sf_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {

    if (searchRange.location + searchRange.length > self.length) {
        NSLog(@"sf_stringByReplacingOccurrencesOfString:[%@]", NSStringFromRange(searchRange));
        return self;
    }
    
    if (!target) {
        NSLog(@"sf_stringByReplacingOccurrencesOfString:[%@]",target);
        return self;
    }
    
    if (!replacement) {
        NSLog(@"sf_stringByReplacingOccurrencesOfString:[%@]", replacement);
        return self;
    }
    
    return [self sf_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}
@end
