//
//  SDNavigationController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDNavigationController.h"

@interface SDNavigationController ()

@end

@implementation SDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
//     [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
