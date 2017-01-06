//
//  NSAttributedString+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/23.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSAttributedString (CrashTool)

+ (void)crashToolActive;



@end

/**
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
 *  3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *
 *
 */
