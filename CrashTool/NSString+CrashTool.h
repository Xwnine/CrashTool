//
//  NSString+CrashTool.h
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (CrashTool)
+ (void)crashToolActive;



/**
 *
 *  1. - (unichar)characterAtIndex:(NSUInteger)index
 *  2. - (NSString *)substringFromIndex:(NSUInteger)from
 *  3. - (NSString *)substringToIndex:(NSUInteger)to {
 *  4. - (NSString *)substringWithRange:(NSRange)range {
 *  5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
 *  6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
 *  7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
 *
 */
@end
