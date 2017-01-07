//
//  NSObject+Swizzling.h
//  SafeTool
//
//  Created by Andrew on 2017/1/7.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)swizzleInstanceMetod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel;
+ (void)swizzleClassMethod:(SEL)originalSel withSwizzledSel:(SEL)swizzledSel;

- (BOOL)containProperty:(NSString *)propName;
- (BOOL)containIvar:(NSString *)ivarName;
@end
