//
//  UINavigationController+Safe.m
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "UINavigationController+Safe.h"
#import "NSObject+Swizzling.h"
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
        [self swizzleInstanceMetod:@selector(pushViewController:animated:) withSwizzledSel:@selector(safe_pushViewController:animated:)];
        
    });
    
    
}

- (void)safe_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.isTransition) {
        return;
    }
    
    [self safe_pushViewController:viewController animated:animated];
    
    if (animated) {
        self.isTransition = YES;
    }
}



- (UIViewController *)safe_popViewControllerAnimated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    UIViewController *controller = [self safe_popViewControllerAnimated:animated];
    if (controller == nil) {
        self.isTransition = NO;
    }
    return controller;
}



- (NSArray *)safe_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    NSArray *controllers = [self safe_popToViewController:viewController animated:animated];
    if (controllers.count == 0) {
        self.isTransition = NO;
    }
    return controllers;

}



- (NSArray *)safe_popToRootViewControllerAnimated:(BOOL)animated {

    if (self.isTransition) {
        return  nil;
    }
    
    if (animated) {
        self.isTransition = YES;
    }
    
    NSArray *controllers = [self safe_popToRootViewControllerAnimated:animated];
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
        [self swizzleInstanceMetod:@selector(viewDidAppear:) withSwizzledSel:@selector(safe_viewDidAppear:)];
    });
    
}

- (void)safe_viewDidAppear:(BOOL)animated {
    
    if (self.navigationController) {
        self.navigationController.isTransition = NO;
    }
    [self safe_viewDidAppear:animated];
}

@end
