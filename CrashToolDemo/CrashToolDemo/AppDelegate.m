//
//  AppDelegate.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/1/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "AppDelegate.h"





@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    

//    [self KVC_SetValueForKey];
//    [self KVC_SetValueForKeyPath];
//    [self KVC_SetValuesForKeysWithDictionary];
//    [self KVC_SetNullValueForKey];
    
//    [self NSDictionary_Test_Instance];
//    [self NSMutableDictionary_Test_setObjectForKey];
//    [self NSMutableDictionary_Test_removeObjectForKey];
    
    
//    [self NSArray_Test_Instance];
//    [self NSArray_Test_ObjectAtIndex];
//    [self NSArray_Test_ObjectAtIndexes];

//    [self NSMutableArray_Test_ObjectAtIndex];
//    [self NSMutableArray_Test_setObjetAtIndex];
//    [self NSMutableArray_Test_addObjectAtIndex];
//    [self NSMutableArray_Test_removeObjectAtIndex];
//
//
//    [self NSString_Test_characterAtIndex];
//    [self NSString_Test_subStringFromIndex];
//    [self NSString_Test_subStringWithRange];
//    [self NSString_Test_stringByReplacingOccurrenesOfString];
//    [self NSString_Test_StringByReplacingOccurrencesOfStringRange];
//    [self NSString_Test_stringReplacingCharactersInRangWithString];
//
//    [self NSMutableString_Test_replaceCharInRange];
//    [self NSMutableString_Test_InsertStringAtIndex];
//    [self NSMutableString_Test_DeleteCharAtRange];
//
//    [self NSAttributedString_Test_InitWithString];
//    [self NSAttributeString_Test_InitWithAttributeString];
//
//    [self NSAttributeString_Test_InitWithStringAttribute];
//    [self NSMutableAttributedString_Test_InitWithString];
//    [self NSMutableAttributedString_Test_InitWithStringAttributes];
    
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}


#pragma mark -- Test array
- (void)NSArray_Test_Instance {
    
    
    NSString *nilStr = nil;
    NSString *nullStr = NULL;
    
    NSArray *array = @[@"Andrew", nilStr, @"ios", nullStr];
    NSLog(@"array: %@",array);
    
}

- (void)NSArray_Test_ObjectAtIndex {
    
    NSArray *arrI = @[@"iOS", @"Andrew", @"Man"]; //__NSArrayI
    NSArray *oneArrI = @[@"1"];  //__NSSingleObjectArrayI
    NSArray *arr = @[];            //__NSArray0
    NSObject *object = arr[100];
    object = arrI[100];
    object = oneArrI[100];
    NSLog(@"object: %@",object);
}

- (void)NSArray_Test_ObjectAtIndexes {
    
    //    NSArray *arr = @[@"iOS", @"Andrew", @"Man"]; //NSArray
    //    NSArray *arr = @[@"iOS"]; //NSArray
    NSArray *arr = @[]; //NSArray
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:100];
    [arr objectsAtIndexes:indexSet];
    NSLog(@"arr: %@",arr);
    
}

- (void)NSMutableArray_Test_ObjectAtIndex {
    
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    NSObject *objc = [arr objectAtIndex:30];
    //    NSObject *objc = arr[20];
    NSLog(@"obj: %@",objc);
}

- (void)NSMutableArray_Test_setObjetAtIndex {
    
    //本质是调用了 [__NSArrayM setObject:atIndexedSubscript:]
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    arr[4] = @"25";
    
    NSLog(@"arr: %@",arr);
    
}

- (void)NSMutableArray_Test_addObjectAtIndex {
    
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    [arr insertObject:@"cool" atIndex:5]; //实际调用 __NSArrayM insertObject:atIndex:
//    NSString *nilStr = nil;
//    [arr insertObject:nilStr atIndex:0];
    
//    [arr addObject:nilStr];  //__NSArrayM insertObject:atIndex:
    NSLog(@"arr: %@",arr);
}


- (void)NSMutableArray_Test_removeObjectAtIndex {
    
    NSMutableArray *arr = @[@"ios", @"Andrew", @"Man"].mutableCopy;
    [arr removeObjectAtIndex:5]; //[__NSArrayM removeObjectsInRange:]
    
}


#pragma  mark Test dictionary

- (void)NSDictionary_Test_Instance {
    
    //__NSPlaceholderDictionary
    NSString *nilStr = nil;
    NSString *nullStr = NULL;
    NSDictionary *dict = @{@"key1": @"", @"key2":@"a", @"key3":@"", @"a":nullStr, @"b":nilStr};
    
    NSLog(@"dict: %@",dict);
}


- (void)NSMutableDictionary_Test_setObjectForKey {
    
    NSMutableDictionary *dict = @{@"name": @"Andrew", @"gender":@"man"}.mutableCopy;
    NSString *ageKey = nil;
    dict[ageKey] = @(24);
    NSLog(@"%@",dict);
}


- (void)NSMutableDictionary_Test_removeObjectForKey {
    
    //    __NSDictionaryM
    NSMutableDictionary *dict = @{@"name": @"Andrew", @"gender":@"man"}.mutableCopy;
    NSString *ageKey = nil;
    
    [dict removeObjectForKey:ageKey];
    [dict removeObjectForKey:@"age"];
    NSLog(@"%@",dict);
}


#pragma mark -- Test NSString

- (void)NSString_Test_characterAtIndex {
    
    NSString *str  = @"Andrew";
    unichar characteristic = [str characterAtIndex:100];// __NSCFConstantString characterAtIndex:
    NSLog(@"--c-- : %c",characteristic);
}

- (void)NSString_Test_subStringFromIndex {
    
    NSString *str = @"iosdeveloper";
    NSString *subStr = [str substringFromIndex:100]; //__NSCFConstantString substringFromIndex:
    NSLog(@"subStr: %@", subStr);
}

- (void)NSString_Test_subStringWithRange {
    
    NSString *str = @"iosDeveloper";
    NSString *subStr = [str substringWithRange:NSMakeRange(0, 100)]; //-[__NSCFConstantString substringWithRange:]
    NSLog(@"subStr: %@", subStr);
}

- (void)NSString_Test_stringByReplacingOccurrenesOfString {
    
    NSString *str = @"AndrewDeveloper";
    //    NSString *nilStr = nil;
    NSString *targetStr = @"age";
    str = [str stringByReplacingOccurrencesOfString:targetStr withString:targetStr]; //[__NSCFConstantString stringByReplacingOccurrencesOfString:withString:options:range:]
    NSLog(@"subStr: %@",str);
    
}


- (void)NSString_Test_StringByReplacingOccurrencesOfStringRange {
    
    NSString *str = @"ioososososo";
    NSRange range = NSMakeRange(0, 1000);
    str = [str stringByReplacingOccurrencesOfString:@"chen" withString:@"" options:NSCaseInsensitiveSearch range:range]; //-[__NSCFString replaceOccurrencesOfString:withString:options:range:]
    
    NSLog(@"%@",str);
}

- (void)NSString_Test_stringReplacingCharactersInRangWithString {
    
    NSString *str = @"iphoneiosmacmacos";
    NSRange range = NSMakeRange(0, 100);
    str = [str stringByReplacingCharactersInRange:range withString:@"os"];//__NSCFString replaceCharactersInRange:withString:]
    NSLog(@"str: %@", str);
}

- (void)NSMutableString_Test_replaceCharInRange {
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@"osiosiosos"]; //-[__NSCFString replaceCharactersInRange:withString:]
    NSRange range = NSMakeRange(0, 1000);
    [strM replaceCharactersInRange:range withString:@"--"];
    NSLog(@"strM: %@",strM);
}

- (void)NSMutableString_Test_InsertStringAtIndex{
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@"xxxooAndew"]; //-[__NSCFString insertString:atIndex:]:
    [strM insertString:@"cool" atIndex:1000];
    NSLog(@"str: %@",strM);
}

- (void)NSMutableString_Test_DeleteCharAtRange{
    
    NSMutableString *strM = [NSMutableString stringWithFormat:@"xxxooAndew"]; //-[__NSCFString deleteCharactersInRange:]
    [strM deleteCharactersInRange:NSMakeRange(0, 100)];
    NSLog(@"str: %@",strM);
}

#pragma mark -- AttributeString
- (void)NSAttributedString_Test_InitWithString {
    
    NSString *nilStr = nil;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:nilStr];//NSConcreteAttributedString initWithString:
    NSLog(@"attribue: %@",attribute);
}

- (void)NSAttributeString_Test_InitWithAttributeString {
    
    //NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"AndrewiOS"];
    
    NSAttributedString *attStr = nil;
    NSAttributedString *anotherAttrStr = [[NSAttributedString alloc] initWithAttributedString:attStr]; //'NSConcreteAttributedString initWithString:
    NSLog(@"anotherAttStr: %@",anotherAttrStr);
    
}

- (void)NSAttributeString_Test_InitWithStringAttribute {
    
    NSString *str = nil;
    NSDictionary *att = @{NSFontAttributeName :[UIFont systemFontOfSize:14]};
    NSAttributedString *anotherAttrStr = [[NSAttributedString alloc] initWithString:str attributes:att ]; //'NSConcreteAttributedString initWithString:
    
    
    NSLog(@"anotherAttStr: %@",anotherAttrStr);
    
}

- (void)NSMutableAttributedString_Test_InitWithString {
    
    NSString *nilStr = nil;
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:nilStr];//NSConcreteMutableAttributedString initWithString:
    
    NSLog(@"attribue: %@",attribute);
}

- (void)NSMutableAttributedString_Test_InitWithStringAttributes {
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSString *nilStr = nil;
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr attributes:attributes]; //NSConcreteMutableAttributedString initWithString:attributes:
    NSLog(@"%@",attrStrM);
    
}

#pragma mark -- KVC

// 下面的三个方法，在runtime时期最终都是调用 setValue:forUndefinedKey:
- (void)KVC_SetValueForKey {
    
    UIViewController *table = [UIViewController new];
    [table setValue:self forKey:@"flee"]; //setValue:forUndefinedKey:
}

- (void)KVC_SetNullValueForKey {
    id value = nil;
    UIViewController *controller = [UIViewController new]; //setValue:forUndefinedKey:
    [controller setValue:value forKey:@"view"];
    
}

- (void)KVC_SetValueForKeyPath {
    
    UIViewController *table = [UIViewController new];
    [table setValue:self forKeyPath:@"flee"]; //setValue:forUndefinedKey:
    
}

- (void)KVC_SetValuesForKeysWithDictionary {
    UIViewController *vc = [UIViewController new];
    [vc setValuesForKeysWithDictionary:@{@"name": @"Andrew"}]; //setValue:forUndefinedKey:
}





- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
