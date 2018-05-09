//
//  StubProxy.m
//  CrashToolDemo
//
//  Created by Andrew on 2018/5/8.
//  Copyright © 2018 Andrew. All rights reserved.
//

#import "StubProxy.h"
#import <objc/runtime.h>



@implementation StubProxy

void proxyIMP(id self, SEL _cmd) {
	NSLog(@"消息转发给我了");
	return;
}

//第一次消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel {
	//动态绑定一个实现
	class_addMethod(self, sel, (IMP)proxyIMP, "@@:");
	return YES;
}

@end
