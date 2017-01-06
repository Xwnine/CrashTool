//
//  CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashTool : NSObject


+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel class:(Class)anClass;
+ (void)swizzleInstanceMetod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel class:(Class )anClass;

+ (void)printExceptionLog:(NSException *)exception;
+ (void)crashToolActive;

@end
