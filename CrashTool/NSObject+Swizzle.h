//
//  NSObject+Swizzle.h
//  CrashTool
//
//  Created by Andrew on 2017/5/2.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DLOG(...) safeLog(__VA_ARGS__)

void safeLog(NSString *fmt, ...) NS_FORMAT_FUNCTION(1, 2);

@interface NSObject (Swizzle)
+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel;
+ (void)swizzleInstanceMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel;

@end
