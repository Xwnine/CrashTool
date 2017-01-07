//
//  NSAttributedString+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSAttributedString+Safe.h"
#import "NSObject+Swizzling.h"

@implementation NSAttributedString (Safe)

+ (void)safeToolActive {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class aString = NSClassFromString(@"NSConcreteAttributedString");
        [aString swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(aString_initWithString:)];
        [aString swizzleInstanceMetod:@selector(initWithAttributedString:) withSwizzledSel:@selector(aString_initWithAttributedString:)];
        [aString swizzleInstanceMetod:@selector(initWithString:attributes:) withSwizzledSel:@selector(aString_initWithString:attributes:)];
        
        Class maString = NSClassFromString(@"NSConcreteMutableAttributedString");
        [maString swizzleInstanceMetod:@selector(initWithString:) withSwizzledSel:@selector(maString_initWithString:)];
        [maString swizzleInstanceMetod:@selector(initWithString:attributes:) withSwizzledSel:@selector(maString_initWithString:attributes:)];
    });
    
}


#pragma mark -- NSAttributedString

- (instancetype)aString_initWithString:(NSString *)str {

    if (str == nil || str.length == 0 || str == [NSNull class]) {
        return nil;
    }
    return [self aString_initWithString:str];
}

- (instancetype)aString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {

    if (str == nil || str.length == 0 || str ==[NSNull class]) {
        return nil;
    }
    
    if (attrs == nil || [attrs isKindOfClass:[NSNull class]] || attrs.allKeys == 0) {
        return nil;
    }
    return [self aString_initWithString:str attributes:attrs];
}

- (instancetype)aString_initWithAttributedString:(NSAttributedString *)attrStr {

    if (attrStr == nil || attrStr.length == 0 || attrStr == [NSNull class]) {
        return nil;
    }
    return [self aString_initWithAttributedString:attrStr];
}


#pragma mark -- NSMutableAttributedString
- (instancetype)maString_initWithString:(NSString *)str {

    if (str == nil || str.length == 0 || str == [NSNull class]) {
        return nil;
    }
    return [self maString_initWithString:str];
    
}

- (instancetype)maString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    
    if (str == nil || str.length == 0 || str == [NSNull class]) {
        return nil;
    }
    
    if (attrs == nil || [attrs isKindOfClass:[NSNull class]] || attrs.allKeys == 0) {
        return nil;
    }
    return [self maString_initWithString:str attributes:attrs];

}



@end
