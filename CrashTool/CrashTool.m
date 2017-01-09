//
//  CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/21.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "CrashTool.h"
#import <objc/runtime.h>

#import "NSArray+CrashTool.h"
#import "NSMutableArray+CrashTool.h"

#import "NSDictionary+CrashTool.h"
#import "NSMutableDictionary+CrashTool.h"

#import "NSString+CrashTool.h"
#import "NSMutableString+CrashTool.h"

#import "NSAttributedString+CrashTool.h"
#import "NSMutableAttributedString+CrashTool.h"
#import "NSObject+CrashTool.h"
#import "UINavigationController+CrashTool.h"





@implementation CrashTool
+ (void)swizzleInstanceMetod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel class:(Class )anClass{
    
    Method originalMethod = class_getInstanceMethod(anClass, originalSel);
    Method swizzledMethod = class_getInstanceMethod(anClass, swizzledSel);
    
    //先尝试给源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(anClass, originalSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功：说明源SEL没有实现IMP，讲源SEL的IMP交换到SEL的IMP
        class_replaceMethod(anClass, swizzledSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        //添加失败：说明原SEL已经有IMP，将源SEL的IMP替换到交换SEL的IMP
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel class:(Class)anClass {

    Method originalMethod = class_getClassMethod(anClass, originalSel);
    Method swizzledMethod = class_getClassMethod(anClass, swizzledSel);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)printExceptionLog:(NSException *)exception {

    
    NSArray *symbols = [NSThread callStackSymbols];
    NSString *symbolsString = [CrashTool priseMainCallStackSymbols:symbols];
    
    NSString *errorReason = exception.reason;
    
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"fleeCrash" withString:@""];
    NSString *logMsg = [NSString stringWithFormat:@"\n%@\n%@\n", errorReason, symbolsString];
    NSLog(@"crash: %@",logMsg);
}

+ (NSString *)priseMainCallStackSymbols:(NSArray *)callStackSymbols {

    //log格式，+[类名 方法名] 或者 -[类名 方法名]
     __block NSString *symbolsMessage = nil;
    
    //匹配格式
    NSString *regluarStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regluarExp = [[NSRegularExpression alloc] initWithPattern:regluarStr options:NSRegularExpressionCaseInsensitive error:nil];
    for (int idx = 2; idx<callStackSymbols.count; idx++) {
        
        NSString *symbolStr = callStackSymbols[idx];

        [regluarExp enumerateMatchesInString:symbolStr options:NSMatchingReportProgress range:NSMakeRange(0, symbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *callStackSymbolMsg = [symbolStr substringWithRange:result.range];
                //get className
                NSString *className = [callStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    symbolsMessage = callStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (symbolsMessage.length) {
            break;
        }
    }
    
    return symbolsMessage;
}


+ (void)crashToolActive {

    [NSObject crashToolActive];
    [NSString crashToolActive];
    [NSMutableString crashToolActive];
    [NSAttributedString crashToolActive];
    [NSMutableAttributedString crashToolActive];
    
    [NSArray crashToolActive];
    [NSMutableArray crashToolActive];
    [NSDictionary crashToolActive];
    [NSMutableDictionary crashToolActive];
    [UINavigationController crashToolActive];
    
}



@end
