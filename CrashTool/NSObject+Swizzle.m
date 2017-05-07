//
//  NSObject+Swizzle.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>



void safeLog(NSString *fmt, ...) {
    va_list ap;va_start(ap, fmt);
    NSString *content = [[NSString alloc] initWithFormat:fmt arguments:ap];
    NSLog(@"%@", content);
    va_end(ap);
    NSLog(@" ============= call stack ========== \n%@", [NSThread callStackSymbols]);
}


@implementation NSObject (Swizzle)

+ (void)swizzleInstanceMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
    
    //先尝试给源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(self, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功：说明源SEL没有实现IMP，讲源SEL的IMP交换到SEL的IMP
        class_replaceMethod(self,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else {
        //添加失败：说明原SEL已经有IMP，将源SEL的IMP替换到交换SEL的IMP
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel {
    
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method swizzledMethod = class_getClassMethod(self, swizzledSel);
    
    BOOL didAddMethod = class_addMethod(self,
                                        originalSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
