//
//  NSMutableAttributedString+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/5/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSMutableAttributedString+Safe.h"
#import "NSObject+Swizzle.h"


@implementation NSMutableAttributedString (Safe)



+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"NSConcreteMutableAttributedString") swizzleInstanceMethod:@selector(initWithString:) withSwizzledSel:@selector(sf_initWithStringM:)];
        
        [NSClassFromString(@"NSConcreteMutableAttributedString") swizzleInstanceMethod:@selector(initWithString:attributes:) withSwizzledSel:@selector(sf_initWithStringM:attributes:)];
        
    });
}


- (instancetype)sf_initWithStringM:(NSString *)str {
    
    if (!str) {
        NSLog(@"sf_initWithStringM: init with a nil string");
        return nil;
    }
    return [self sf_initWithStringM:str];
}

- (instancetype)sf_initWithStringM:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    
    if (!str) {
        NSLog(@"sf_initWithStringM:attributes: init with a nil string");
        return nil;
    }
    
    if (!attrs) {
        NSLog(@"sf_initWithStringM:attributes: init with a nil attrs");
        return nil;
    }
    return [self sf_initWithStringM:str attributes:attrs];
}
@end
