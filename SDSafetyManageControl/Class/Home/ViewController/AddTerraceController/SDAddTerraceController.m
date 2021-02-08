//
//  SDAddTerraceController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAddTerraceController.h"

#import "SDShowPromptView.h"

#import "SDInviteCodeController.h"

#import "SDAddTerraceView.h"

#import "HWScanViewController.h"

@interface SDAddTerraceController ()

@end

@implementation SDAddTerraceController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    //添加视图
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navBarBgAlpha = @"0.0";
   
}
//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"添加平台" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
}
-(void) addLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) createView{
    SDAddTerraceView *addView = [[SDAddTerraceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view addSubview:addView];
    
    __weak typeof(self) weakSelf = self;
    addView.selectBtnBlock = ^(NSInteger index) {
        switch (index) {
            case 0:
            {  //二维码激活
                self.hidesBottomBarWhenPushed = YES;
                HWScanViewController *scanVC = [[HWScanViewController alloc]init];
                [self.navigationController pushViewController:scanVC animated:YES];
                scanVC.tureBtnBlock = ^(NSString *code) {
                    [weakSelf requestLoadDataCode:code];
                };
                break;
                
            }
            case 1:
            { //邀请码激活
                self.hidesBottomBarWhenPushed = YES;
                SDInviteCodeController *inviteVC = [[SDInviteCodeController alloc]init];
                [weakSelf.navigationController pushViewController:inviteVC animated:YES];
                break;

            }
            default:
                break;
        }
    };
    
    
}


#pragma mark -----数据相关------
-(void) requestLoadDataCode:(NSString *)code{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"code"] = code;
    param[@"gdl_userid"] = [SDUserInfo obtainWithGdlUserID];
    
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_PLAFORMCODE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            
            // 修改
            [SDUserInfo alterUserID:showdata];
            
            //显示成功view
            SDShowPromptView *showView = [[SDShowPromptView alloc]initWithFrame:weakSelf.view.bounds];
            [weakSelf.view addSubview:showView];
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [showView removeFromSuperview];
            });
            
        }else{
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    }];
    
}


@end
