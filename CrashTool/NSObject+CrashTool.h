//
//  NSObject+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CrashTool)


/**
 实现下面的一些方法的交换，这里没有写在load方法中有几个方面的原因：
 1、swizzle技术影响到整个os框架，为了规避测试力度不够导致的各类离奇的bug，以及旧代码用到新工程中出现的各种位置的错误
 2、使用可控
 
 3、应对新的iOS系统发布，系统框架的更新导致一些API发生变化，所交换的方法不存在，导致未知的bug
 */
+ (void)crashToolActive;

//替换KVC相关的方法

/*
*
*  1.- (void)setValue:(id)value forKey:(NSString *)key
*  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
*  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
*  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
*  5.- (void)forwardingTargetForSelector:(SEL)aSelector;
*/

@end
