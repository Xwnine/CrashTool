//
//  StubProxy.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "StubProxy.h"
#import <objc/runtime.h>
@implementation StubProxy

void dynamicMethodIMP(id self, SEL _cmd) {

    NSLog(@"message forward...");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {

    class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {

    NSLog(@"sel is %@", NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}





@end
