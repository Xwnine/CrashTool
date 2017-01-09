//
//  NSObject+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSObject+CrashTool.h"
#import "CrashTool.h"
#import "StubProxy.h"
#import <objc/runtime.h>


//static char *const kZombieKey = "Zombiekey";
//
//static NSArray* blackList() {
//    static NSArray *list = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        list = @[];
//    });
//    return list;
//}

@implementation NSObject (CrashTool)



+ (void)crashToolActive {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [CrashTool swizzleInstanceMetod:@selector(setValue:forKey:) withSwizzledSel:@selector(flee_setValue:forKey:) class:[self class]];
        
        [CrashTool swizzleInstanceMetod:@selector(setValue:forKeyPath:) withSwizzledSel:@selector(flee_setValue:forKeyPath:) class:[self class]];
        
        [CrashTool swizzleInstanceMetod:@selector(setValue:forUndefinedKey:) withSwizzledSel:@selector(flee_setValue:forKeyUndefineKey:) class:[self class]];
        [CrashTool swizzleInstanceMetod:@selector(setValuesForKeysWithDictionary:) withSwizzledSel:@selector(flee_setValuesForKeysWithDictionary:) class:[self class]];
        
        [CrashTool swizzleInstanceMetod:@selector(forwardingTargetForSelector:) withSwizzledSel:@selector(flee_forwardingTargetForSelector:) class:[self class]];
    });
}

//在交换了方法的实现后，flee_setValue:forKey:方法的实现已经被替换为了 NSObject setValue:forKey:的原生实现，所以这里并不是在递归调用。由于 flee_setValue:key: 这个方法的实现已经被替换为了 setValue:forKey: 的实现，所以，当我们在这个方法中再调用 setValue:forKey: 时便会造成递归循环


- (void)flee_setValue:(id)value forKey:(NSString *)key {

    @try {
        [self flee_setValue:value forKey:key];
        
    } @catch (NSException *exception) {
        //打印出异常数据
        [CrashTool  printExceptionLog:exception];
    } @finally {
        
    }
    
}


- (void)flee_setValue:(id)value forKeyPath:(NSString *)keyPath {

    @try {
        [self flee_setValue:value forKeyPath:keyPath];
        
    } @catch (NSException *exception) {
        //打印出异常数据
        [CrashTool  printExceptionLog:exception];
        
    } @finally {

    }
}

//通常消息转发，解析失败之后，这个方法在runtime期间会被调用，并且会抛出异常
- (void)flee_setValue:(id)value forKeyUndefineKey:(NSString *)key {

    @try {
        [self flee_setValue:value forKeyUndefineKey:key];
    } @catch (NSException *exception) {
        
        //打印出异常数据
        [CrashTool  printExceptionLog:exception];
        
    } @finally {
        
    }
}

- (void)flee_setValuesForKeysWithDictionary:(NSDictionary *) keydValues{

    @try {
        [self flee_setValuesForKeysWithDictionary:keydValues];
    } @catch (NSException *exception) {
        //打印出异常数据
        [CrashTool  printExceptionLog:exception];
    } @finally {
        
    }
}

- (id)flee_forwardingTargetForSelector:(SEL)aSelector {
    
    id proxy = [self flee_forwardingTargetForSelector:aSelector];
    if (!proxy) {
        NSLog(@"[%@ %@]unrecognized selector crash\n\n%@\n", [self class], NSStringFromSelector(aSelector), [NSThread callStackSymbols]);        
        proxy = [[StubProxy alloc] init];
    }
    return proxy;
}

//解决 EXC_BAD_ACCESS（野指针）：
/*
 
 * 出现这个 crash的原因： 访问一个已经释放的对象，或者向一个已经释放的对象发送消息，就会出现这种crash
 * 实现一个类似于Xcode的 NSZombieEnable环境变量机制：用僵尸实现来代替实例的dealloc，在某个实例的引用计数降到0时，该僵尸实现会将该对象转换成僵尸对象。
 * 关于僵尸对象：在启用Xcode的NSZombieEnable的调试机制，runtime系统会将所有已经回收的实例转化成特殊的“僵尸对象”，而不会真正的回收它们。给僵尸对象发送消息后，会抛出异常，并说明异常消息
 
 */


//+ (id)flee_allocWithZone:(NSZone *)zone {
//
//    id object = nil;
//    @try {
//        object = [self flee_allocWithZone:zone];
//    } @catch (NSException *exception) {
//        
//        [CrashTool printExceptionLog:exception];
//        if (![blackList() containsObject:[object class]]) {
//            //添加僵尸标识
//            objc_setAssociatedObject(object, kZombieKey, @(YES), OBJC_ASSOCIATION_RETAIN);
//        }
//        
//        
//    } @finally {
//        
//        return object;
//    }
//}














@end
