//
//  NSString+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSString+Safe.h"
#import "NSObject+Swizzling.h"



@implementation NSString (Safe)


+ (void)safeToolActive {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class cfString = NSClassFromString(@"__NSCFString");
        [cfString swizzleInstanceMetod:@selector(replaceCharactersInRange:withString:) withSwizzledSel:@selector(cfString_replaceCharactersInRange:withString:)];
        [cfString swizzleInstanceMetod:@selector(insertString:atIndex:) withSwizzledSel:@selector(cfString_insertString:atIndex:)];
        [cfString swizzleInstanceMetod:@selector(deleteCharactersInRange:) withSwizzledSel:@selector(cfString_deleteCharactersInRange:)];
        
        
        
        Class constantStr = NSClassFromString(@"__NSCFConstantString");
        
        [constantStr swizzleInstanceMetod:@selector(characterAtIndex:) withSwizzledSel:@selector(constanStr_characterAtIndex:)];
        [constantStr swizzleInstanceMetod:@selector(substringFromIndex:) withSwizzledSel:@selector(constanStr_substringFromIndex:)];
        [constantStr swizzleInstanceMetod:@selector(substringWithRange:) withSwizzledSel:@selector(constantStr_substringWithRange:)];
        
        
        [constantStr swizzleInstanceMetod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSwizzledSel:@selector(constantStr_stringByReplacingOccurrencesOfString:withString:options:range:)];
        
        [constantStr swizzleInstanceMetod:@selector(stringByReplacingCharactersInRange:withString:) withSwizzledSel:@selector(constantStr_stringByReplacingCharactersInRange:withString:)];
    });
}

#pragma NSMutableString
- (void)cfString_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    
    if (aString == nil || aString.length == 0 || aString == [NSNull class]) {
        return;
    }
    if ((range.length + range.location) >= self.length) {
        NSLog(@"error: range or index beyond bounds");
        return;
    }
    [self cfString_replaceCharactersInRange:range withString:aString];
}



- (void)cfString_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    if (aString == nil || aString.length == 0 || aString == [NSNull class] || loc >= self.length) {
        NSLog(@"error: range or index beyond bounds ,maybe aString is nil...");
        return;
    }
    [self cfString_insertString:aString atIndex:loc];
    
}

- (void)cfString_deleteCharactersInRange:(NSRange)range {
    
    if ((range.length + range.location) >= self.length) {
        NSLog(@"error: range or index beyond bounds");
        return;
    }
    [self cfString_deleteCharactersInRange:range];
}







#pragma mark -- NSAttributeString

- (unichar)constanStr_characterAtIndex:(NSUInteger)index {
    unichar character;
    if (index >= self.length) {
        NSLog(@"error: index is beyound of bounds: %lu", index);
        return character;
    }
    return [self constanStr_characterAtIndex:index];
}

- (NSString *)constanStr_substringFromIndex:(NSUInteger)from {
    
    if (from >= self.length) {
        NSLog(@"error: from is beyound of bounds: %lu", from);
        return nil;
    }
    return [self constanStr_substringFromIndex:from];
}

- (NSString *)constanStr_substringToIndex:(NSUInteger)to {

    if (to >= self.length) {
        NSLog(@"error: to is beyound of bounds: %lu", to);
        return nil;
    }
    return [self constanStr_substringToIndex:to];

}

- (NSString *)constantStr_substringWithRange:(NSRange)range {

    if ((range.length + range.location) >= self.length) {
        NSLog(@"error: range or index is beyound of bounds");
        return nil;
    }

   return  [self constantStr_substringWithRange:range];
}


- (NSString *) constantStr_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {

    
    if (target == nil || target.length == 0 || target == [NSNull class]) {
        
        NSLog(@"error: target is nil");
        return nil;
    }
    
    if (replacement == nil || replacement.length == 0 || replacement == [NSNull class]) {
        
        NSLog(@"error: replacement is nil");
        return nil;
    }
    
    if ((searchRange.length + searchRange.location) >= self.length) {
        NSLog(@"error: range or index is beyound bounds");
        return nil;
    }
    
    return [self constantStr_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}


- (NSString *)constantStr_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    if (replacement == nil || replacement.length == 0 || replacement == [NSNull class]) {
        
        NSLog(@"error: replacement is nil");
        return nil;
    }
    
    if ((range.length + range.location) >= self.length) {
        NSLog(@"error: range or index is beyound bounds");
        return nil;
    }
    return [self constantStr_stringByReplacingCharactersInRange:range withString:replacement];
}


@end
