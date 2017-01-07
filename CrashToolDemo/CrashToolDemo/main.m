//
//  main.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/1/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


void printExceptionLog(NSException * exception) {
    
    NSArray *symbols = [NSThread callStackSymbols];
    
    //log格式，+[类名 方法名] 或者 -[类名 方法名]
    __block NSString *symbolsMessage = nil;
    
    //匹配格式
    NSString *regluarStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regluarExp = [[NSRegularExpression alloc] initWithPattern:regluarStr options:NSRegularExpressionCaseInsensitive error:nil];
    for (int idx = 2; idx<symbols.count; idx++) {
        
        NSString *symbolStr = symbols[idx];
        
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
    
    NSString *errorReason = exception.reason;
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"fleeCrash" withString:@""];
    NSString *logMsg = [NSString stringWithFormat:@"\n%@\n%@\n", errorReason, symbolsMessage];
    NSLog(@"crash: %@",logMsg);
}

int main(int argc, char * argv[]) {
    
    NSSetUncaughtExceptionHandler(&printExceptionLog);
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
