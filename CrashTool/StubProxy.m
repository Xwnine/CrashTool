 //
//  StubProxy.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/23.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "StubProxy.h"
#import <objc/runtime.h>

@implementation StubProxy
void dynamicMethodIMP(id self, SEL _cmd) {

//    NSLog(@"dynamicMethodIMP");
}

- (void)proxyMethod {
    NSLog(@"dynamicMethodIMP");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {

    class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    
    
//    Method m = class_getInstanceMethod([self class], @selector(proxyMethod));
//    IMP proxyIMP = method_getImplementation(m);
//    class_addMethod([self class], sel, proxyIMP, "v@:");
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {

    NSLog(@"sel is %@", NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}


@end
