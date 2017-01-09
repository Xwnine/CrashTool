//
//  NSObject+Swizzling.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzleInstanceMetod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
    
    //先尝试给源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(self, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功：说明源SEL没有实现IMP，讲源SEL的IMP交换到SEL的IMP
        class_replaceMethod(self, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        //添加失败：说明原SEL已经有IMP，将源SEL的IMP替换到交换SEL的IMP
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel {
    
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method swizzledMethod = class_getClassMethod(self, swizzledSel);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


- (BOOL)containProperty:(NSString *)propName {
    
    const char *filterName = [propName UTF8String];
    BOOL isContain = NO;
    
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    for (unsigned int i = 0; i < outCount; ++i) {
        objc_property_t property = properties[i];
        
        const char *propertyName = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        if (filterName == propertyName) {
            isContain = YES;
        }
        
//        NSLog(@"%s propertyAttributes： %s", propertyName, propertyAttributes);
    }
    free(properties);
    return isContain;
}

- (BOOL)containIvar:(NSString *)ivarName {
    
    const char *filterName = [ivarName UTF8String];
    BOOL isContain = NO;
    
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(self.class, &outCount);
    
    for (unsigned int i = 0; i < outCount; ++i) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        if (filterName == name) {
            isContain = YES;
        }
//        NSLog(@"name: %s encodeType: %s", name, type);
    }
    
    free(ivars);
    return isContain;
}



@end
