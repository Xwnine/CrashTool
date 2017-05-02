//
//  NSString+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSString+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>


@implementation NSString (Safe)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        @autoreleasepool {
            
            [objc_getClass("__NSCFString") swizzleInstanceMetod:@selector(replaceCharactersInRange:withString:) withSwizzledSel:@selector(cfString_replaceCharactersInRange:withString:)];
            [objc_getClass("__NSCFString") swizzleInstanceMetod:@selector(insertString:atIndex:) withSwizzledSel:@selector(cfString_insertString:atIndex:)];
            [objc_getClass("__NSCFString") swizzleInstanceMetod:@selector(deleteCharactersInRange:) withSwizzledSel:@selector(cfString_deleteCharactersInRange:)];
            
            
            [objc_getClass("__NSCFConstantString") swizzleInstanceMetod:@selector(characterAtIndex:) withSwizzledSel:@selector(constantStr_characterAtIndex:)];
            [objc_getClass("__NSCFConstantString") swizzleInstanceMetod:@selector(substringFromIndex:) withSwizzledSel:@selector(constantStr_substringFromIndex:)];
            [objc_getClass("__NSCFConstantString") swizzleInstanceMetod:@selector(substringWithRange:) withSwizzledSel:@selector(constantStr_substringWithRange:)];
            
            [objc_getClass("__NSCFConstantString") swizzleInstanceMetod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSel:@selector(constantStr_stringByReplacingOccurrencesOfString:withString:options:range:)];
            
            [objc_getClass("__NSCFConstantString") swizzleInstanceMetod:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSel:@selector(constantStr_stringByReplacingCharactersInRange:withString:)];
        }
    });
}

#pragma NSMutableString
- (void)cfString_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    if (aString == nil || aString.length == 0 || aString == [NSNull class]) {
        NSLog(@"cfString_replaceCharactersInRange: aString is nil");
        return;
    }
    if ((range.length + range.location) > self.length) {
        NSLog(@"cfString_replaceCharactersInRange: range or index beyond bounds");
        return;
    }
    [self cfString_replaceCharactersInRange:range withString:aString];
}



- (void)cfString_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    if (aString == nil || aString.length == 0 || aString == [NSNull class] || loc > self.length) {
        NSLog(@"cfString_insertString: range or index beyond bounds ,maybe aString is nil...");
        return;
    }
    [self cfString_insertString:aString atIndex:loc];
    
}

- (void)cfString_deleteCharactersInRange:(NSRange)range {
    
    if ((range.length + range.location) > self.length) {
        NSLog(@"cfString_insertString: range or index beyond bounds");
        return;
    }
    [self cfString_deleteCharactersInRange:range];
}




#pragma mark -- NSAttributeString

- (unichar)constantStr_characterAtIndex:(NSUInteger)index {
    unichar character = 0;
    if (index >= self.length) {
        NSLog(@"characterAtInde: index is beyound of bounds: %lu", index);
        return character;
    }
    return [self constantStr_characterAtIndex:index];
}

- (NSString *)constantStr_substringFromIndex:(NSUInteger)from {
    
    if (from >= self.length) {
        NSLog(@"substringFromIndex: from is beyound of bounds: %lu", from);
        return nil;
    }
    return [self constantStr_substringFromIndex:from];
}

- (NSString *)constanStr_substringToIndex:(NSUInteger)to {

    if (to >= self.length) {
        NSLog(@"substringToIndex: to is beyound of bounds: %lu", to);
        return nil;
    }
    return [self constanStr_substringToIndex:to];

}

- (NSString *)constantStr_substringWithRange:(NSRange)range {

    if ((range.length + range.location) > self.length) {
        NSLog(@"substringWithRange: range or index is beyound of bounds");
        return nil;
    }

   return  [self constantStr_substringWithRange:range];
}


- (NSString *)constantStr_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {

    
    if (target == nil || target.length == 0 || target == [NSNull class]) {
        
        NSLog(@"stringByReplacingOccurrencesOfString:options: target is nil");
        return nil;
    }
    
    if (replacement == nil || replacement.length == 0 || replacement == [NSNull class]) {
        
        NSLog(@"stringByReplacingOccurrencesOfString:options: replacement is nil");
        return nil;
    }
    
    if ((searchRange.length + searchRange.location) > self.length) {
        NSLog(@"stringByReplacingOccurrencesOfString:options: range or index is beyound bounds");
        return nil;
    }
    
    return [self constantStr_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}


- (NSString *)constantStr_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    if (replacement == nil || replacement.length == 0 || replacement == [NSNull class]) {
        
        NSLog(@"stringByReplacingCharactersInRange: replacement is nil");
        return nil;
    }
    
    if ((range.length + range.location) > self.length) {
        NSLog(@"stringByReplacingCharactersInRange: range or index is beyound bounds");
        return nil;
    }
    return [self constantStr_stringByReplacingCharactersInRange:range withString:replacement];
}


@end
