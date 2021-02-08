//
//  SDMessageCentreController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDMessageCentreController.h"

@interface SDMessageCentreController ()




@end

@implementation SDMessageCentreController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Navi
    [self createNavi];
}

#pragma mark  ----- 设置Navi-----
-(void)createNavi{
    [self customNaviItemTitle:@"消息中心" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(selectLeftBtn:) isLeft:YES];
}
-(void) selectLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}






@end
