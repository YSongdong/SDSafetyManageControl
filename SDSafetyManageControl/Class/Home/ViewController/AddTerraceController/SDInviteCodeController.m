//
//  SDInviteCodeController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDInviteCodeController.h"

#import "SDInviteCodeView.h"
#import "SDShowPromptView.h"

@interface SDInviteCodeController ()

//view
@property (nonatomic,strong) SDInviteCodeView *inviteView;

@end

@implementation SDInviteCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    
    [self createInvteView];
    
}

//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"邀请码激活" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(inviteLeftBtn:) isLeft:YES];
}
-(void) inviteLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createInvteView{
    self.inviteView = [[SDInviteCodeView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [self.view addSubview:self.inviteView];
    
    __weak typeof(self) weakSelf = self;
    //点击确定按钮
    self.inviteView.tureBtnBlock = ^(NSString *code) {
        [weakSelf requestLoadDataCode:code];
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
            // 修改userID/
            [SDUserInfo alterUserID:showdata];
        
            [weakSelf.inviteView.inviteTF resignFirstResponder];
            weakSelf.inviteView.inviteTF.text = @"";
            
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
