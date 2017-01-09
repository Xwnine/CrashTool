//
//  NSDictionary+CrashTool.m
//  AndrewOCKit
//
//  Created by Andrew on 2016/12/20.
//  Copyright © 2016年 Andrew. All rights reserved.
//

#import "NSDictionary+CrashTool.h"
#import "CrashTool.h"


@implementation NSDictionary (CrashTool)


+ (void)crashToolActive {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [CrashTool swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withSwizzledSel:@selector(flee_dictionaryWithObjects:forKeys:count:) class:[self class]];
    });
}

+ (instancetype)flee_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {

    id instance = nil;

    @try {
        
       instance = [self flee_dictionaryWithObjects:objects forKeys:keys count:cnt];
        
    } @catch (NSException *exception) {
        //打印出异常数据
        
        [CrashTool  printExceptionLog:exception];
        
        //处理错误的数据，然后创建一个新的字典
        NSUInteger index = 0;
        
        //也可以使用NSMutableArray，来实现
        
        //定义一个指针，指向objects的初始位置
        id _Nonnull __unsafe_unretained clearObjects[cnt];
        //定义一个指针，指向keys的初始位置
        id <NSCopying> _Nonnull __unsafe_unretained clearKeys[cnt];
        

        
        for (int i=0; i<cnt; i++) {
            if (objects[i] && keys[i]) {
                clearObjects[index] = objects[i];
                clearKeys[index] = keys[i];
                index++;
            }
        }
        
        instance = [self flee_dictionaryWithObjects:clearObjects forKeys:clearKeys count:index];
        
    } @finally {
        
        return instance;
    }
    
    
}

@end
