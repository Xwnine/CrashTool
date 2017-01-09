//
//  NSDictionary+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CrashTool)

+ (void)crashToolActive;




/*
 
*   a.中任意key或者value为nil, 会导致crash
    b. key为空, 造成key value 不匹配, 会crash
    c. 任意value为nil, 会crash
 
*  1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"AvoidCrash"}; //这种创建方式其实调用的是2中的方法
*  2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt
*/

@end
