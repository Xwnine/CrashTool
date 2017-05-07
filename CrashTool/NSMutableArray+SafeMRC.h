//
//  NSMutableArray+SafeMRC.h
//  CrashTool
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 在键盘出现的状态下，按下Home键使得App从Foreground切换到Background的时候，App就会触发一个exception导致crash， 错误堆栈信息如下
 
 [UIKeyboardLayoutStar release]: message sent to deallocated instance 解决
 carsh 原因：ARC模式下，swizzle objectAtIndex：方法，会出现crash
 
 */


@interface NSMutableArray (SafeMRC)

@end
