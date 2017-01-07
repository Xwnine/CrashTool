//
//  NSArray+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CrashTool)



+ (void)crashToolActive;

@end

/**
 *
 *   NSArray的快速创建方式 即使用字面量创建的方式，本质其实调用的是2中的方法
 *  1. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt
 *  2. - (id)objectAtIndex:(NSUInteger)index
 *  3. - (void)getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range
 */

