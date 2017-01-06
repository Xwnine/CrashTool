//
//  NSMutableDictionary+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CrashTool)

+ (void)crashToolActive;
/*
*  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
*  2. - (void)removeObjectForKey:(id)aKey
*/


@end
