//
//  ViewController.m
//  CrashToolDemo
//
//  Created by Andrew on 2017/1/6.
//  Copyright © 2017年 Andrew. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)clicked:(id)sender {
    
    UIViewController *controller = [UIViewController new];
    [self.navigationController pushViewController:controller animated:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
