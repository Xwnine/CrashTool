//
//  UINavigationController+Safe.m
//  CrashTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "UINavigationController+Safe.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@interface UINavigationController () <UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL isTransition;

@end


@implementation UINavigationController (Safe)

- (void)setIsTransition:(BOOL)transition{

    objc_setAssociatedObject(self, @selector(isTransition), @(transition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isTransition {

    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(pushViewController:animated:) withSwizzledSel:@selector(sf_pushViewController:animated:)];
    });
}

- (void)sf_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.isTransition) {
        return;
    }
    
    [self sf_pushViewController:viewController animated:animated];
    
    if (animated) {
        self.isTransition = YES;
    }
}



- (UIViewController *)sf_popViewControllerAnimated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    UIViewController *controller = [self sf_popViewControllerAnimated:animated];
    if (controller == nil) {
        self.isTransition = NO;
    }
    return controller;
}



- (NSArray *)sf_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    NSArray *controllers = [self sf_popToViewController:viewController animated:animated];
    if (controllers.count == 0) {
        self.isTransition = NO;
    }
    return controllers;

}


- (NSArray *)sf_popToRootViewControllerAnimated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    NSArray *controllers = [self sf_popToRootViewControllerAnimated:animated];
    if (controllers.count == 0) {
        self.isTransition = NO;
    }
    return controllers;
}

@end


@implementation UIViewController (SafeTransitionLock)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(viewDidAppear:) withSwizzledSel:@selector(sf_viewDidAppear:)];
    });
    
}

- (void)sf_viewDidAppear:(BOOL)animated {
    
    if (self.navigationController) {
        self.navigationController.isTransition = NO;
    }
    [self sf_viewDidAppear:animated];
}

@end
