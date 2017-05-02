//
//  NSArray+SafeMRC.h
//  CrashToolDemo
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>


/*

 在键盘出现的状态下，按下Home键使得App从Foreground切换到Background的时候，App就会触发一个exception导致crash， 错误堆栈信息如下

        [UIKeyboardLayoutStar release]: message sent to deallocated instance 解决


*/
@interface NSArray (SafeMRC)

@end
