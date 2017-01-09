//
//  UINavigationController+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2017/1/5.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "UINavigationController+CrashTool.h"
#import <objc/runtime.h>
#import "CrashTool.h"



@implementation UINavigationController (CrashTool)

+ (void)crashToolActive {
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [CrashTool swizzleInstanceMetod:@selector(popViewControllerAnimated:) withSwizzledSel:@selector(flee_popViewControllerAnimated:) class:[self class]];

            [CrashTool swizzleInstanceMetod:@selector(popToRootViewControllerAnimated:) withSwizzledSel:@selector(flee_popToRootViewControllerAnimated:) class:[self class]];

            [CrashTool swizzleInstanceMetod:@selector(popToViewController:animated:) withSwizzledSel:@selector(flee_popToViewController:animated:) class:[self class]];

            [CrashTool swizzleInstanceMetod:@selector(pushViewController:animated:) withSwizzledSel:@selector(flee_pushViewController:animated:) class:[self class]];
        }
    });
    
}


#pragma mark popViewControllerAnimated pushViewController popToViewController  popToRootViewControllerAnimated
- (UIViewController *)flee_popViewControllerAnimated:(BOOL)animated {
    
    UIViewController *controller;
    @try {
        controller = [self flee_popViewControllerAnimated:animated];
    } @catch (NSException *exception) {
        [CrashTool printExceptionLog:exception];
    } @finally {
        return controller;
    }
    
}

- (NSArray *)flee_popToRootViewControllerAnimated:(BOOL)animated {

    NSArray *controllers;
    @try {
        controllers = [self flee_popToRootViewControllerAnimated:animated];
    } @catch (NSException *exception) {
        [CrashTool printExceptionLog:exception];
    } @finally {
        return controllers;
    }
    
}

- (NSArray *)flee_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {

    NSArray *controllers;
    @try {
        controllers = [self flee_popToViewController:viewController animated:animated];
    } @catch (NSException *exception) {
        [CrashTool printExceptionLog:exception];
    } @finally {
        return controllers;
    }
}

- (void)flee_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    @try {
        [self flee_pushViewController:viewController animated:animated];
    } @catch (NSException *exception) {
        [CrashTool printExceptionLog:exception];
    } @finally {
        
    }
}

@end


