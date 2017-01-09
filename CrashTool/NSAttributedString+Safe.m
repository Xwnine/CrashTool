//
//  NSAttributedString+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSAttributedString+Safe.h"
#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSAttributedString (Safe)

+ (void)safeToolActive {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
            [objc_getClass("NSConcreteAttributedString") swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(aString_initWithString:)];
            [objc_getClass("NSConcreteAttributedString") swizzleInstanceMetod:@selector(initWithAttributedString:) withSwizzledSel:@selector(aString_initWithAttributedString:)];
            [objc_getClass("NSConcreteAttributedString") swizzleInstanceMetod:@selector(initWithString:attributes:) withSwizzledSel:@selector(aString_initWithString:attributes:)];
            
            [objc_getClass("NSConcreteMutableAttributedString") swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(maString_initWithString:)];
            [objc_getClass("NSConcreteMutableAttributedString") swizzleInstanceMetod:@selector(initWithString:attributes:) withSwizzledSel:@selector(maString_initWithString:attributes:)];
        }
    });
    
}


#pragma mark -- NSAttributedString

- (instancetype)aString_initWithString:(NSString *)str {

    if (str == nil || str.length == 0 || str == [NSNull class]) {
        
        NSLog(@"aString_initWithString: init with a nil string");
        return nil;
    }
    return [self aString_initWithString:str];
}

- (instancetype)aString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {

    if (str == nil || str.length == 0 || str ==[NSNull class]) {
        NSLog(@"aString_initWithString:attributes: init with a nil string ");
        return nil;
    }
    
    if (attrs == nil || [attrs isKindOfClass:[NSNull class]]) {
        NSLog(@"aString_initWithString:attributes: init with a nil attrs ");
        return nil;
    }
    return [self aString_initWithString:str attributes:attrs];
}

- (instancetype)aString_initWithAttributedString:(NSAttributedString *)attrStr {

    if (attrStr == nil || attrStr.length == 0 || attrStr == [NSNull class]) {
        NSLog(@"aString_initWithString: init with a nil attrStr");
        return nil;
    }
    return [self aString_initWithAttributedString:attrStr];
}


#pragma mark -- NSMutableAttributedString
- (instancetype)maString_initWithString:(NSString *)str {

    if (str == nil || str.length == 0 || str == [NSNull class]) {
        NSLog(@"maString_initWithString: init with a nil string");
        return nil;
    }
    return [self maString_initWithString:str];
    
}

- (instancetype)maString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    
    if (str == nil || str.length == 0 || str == [NSNull class]) {
        NSLog(@"maString_initWithString:attributes: init with a nil string");
        return nil;
    }
    
    if (attrs == nil || [attrs isKindOfClass:[NSNull class]]) {
        NSLog(@"maString_initWithString:attributes: init with a nil attrs");
        return nil;
    }
    return [self maString_initWithString:str attributes:attrs];
}



@end
