//
//  NSObject+Safe.m
//  CrashToolDemo
//
//  Created by Andrew on 2018/5/8.
//  Copyright © 2018 Andrew. All rights reserved.
//

#import "NSObject+Safe.h"
#import "StubProxy.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"



@implementation NSObject (Safe)

+ (void)load {
	[self swizzleInstanceMethod:@selector(forwardingTargetForSelector:) withSwizzledSel:@selector(safe_forwardingTargetForSelector:)];
}

//1. 
//+ (BOOL)resolveClassMethod:(SEL)sel {
//	return YES;
//}

//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//	
//}

//2. 消息转发的第二步去拦截动态转发到代理target上
- (id)safe_forwardingTargetForSelector:(SEL)aSelector {
	
//	判断子类是否有重写 forwardInvocation，如果子类重写了forwardInvocation，那么forwardingTargetForSelector 会不走正常的转发流程
	IMP clsIMP = class_getMethodImplementation([self class], @selector(forwardInvocation:));
	IMP superClsIMP = class_getMethodImplementation([self class].superclass, @selector(forwardInvocation:));
	
	//仅针对自己创建的类来进行防护。
	BOOL isMainBundle = [[NSBundle bundleForClass:[self class]] isEqual:[NSBundle mainBundle]];
	if (!isMainBundle || (clsIMP != superClsIMP)) {
		return [self safe_forwardingTargetForSelector:aSelector];
	}
	
	//貌似真机上，hook forwardingTargetForSelector 方法，下面这些方法会造成程序异常。这个是系统本身就存在的bug !!! 
 	if ([NSStringFromClass([self class]) hasPrefix:@"_"] || [self isKindOfClass:NSClassFromString(@"UITextInputController")] || [NSStringFromClass([self class]) hasPrefix:@"UIKeyboard"] || [NSStringFromSelector(aSelector) isEqualToString:@"dealloc"]) {
		return [self safe_forwardingTargetForSelector:aSelector];
	}
	
	NSString *methodName = NSStringFromSelector(aSelector);
	NSLog(@"unrecognized selector crash:%@:%@",NSStringFromClass([self class]), methodName);
	NSLog(@"%@", [NSThread callStackSymbols]);
	
	return [StubProxy new];
}


////3.最后一次去消息转发
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//	
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//	
//}


@end
