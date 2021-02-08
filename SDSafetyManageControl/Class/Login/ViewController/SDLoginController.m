//
//  SDLoginController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDLoginController.h"

#import "SDSelectPlatformController.h"
#import "SDRegisterController.h"
#import "SDRootTabBarcontrolller.h"
#import "AppDelegate.h"

#import "SDLoginHeaderView.h"
#import "HWWeakTimer.h"


typedef enum {
    SDLoginStyleAccount = 0, //账号密码登录
    SDLoginStylePhone,  // 电话登录
}SDLoginStyle;
@interface SDLoginController () <UITextFieldDelegate>{
    NSTimer *_timer;
}
//头部视图
@property (nonatomic,strong)SDLoginHeaderView *headerView;
//账号
@property (nonatomic,strong) UITextField *phoneTF;
//公司名字
@property (nonatomic,strong) UITextField *orgTF;
//发送验证码
@property (nonatomic,strong) UIButton *sendBtn;
//密码
@property (nonatomic,strong) UITextField *passwordTF;
//表示登录type
@property (nonatomic,assign) SDLoginStyle loginType;
//登录按钮
@property (nonatomic,strong) UIButton *loginBtn;
//忘记密码
@property (nonatomic,strong) UIButton *forgetPsdBtn;
//注册Lab
@property (nonatomic,strong) YYLabel *registLab;
//
@property (nonatomic,strong) NSString *type;
//显示时间
@property (nonatomic,assign) NSInteger timerPage;

//记录userID
@property (nonatomic,strong) NSString *userID;

@end

@implementation SDLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.type = @"account";
    //设置导航栏
   // [self createNavi];
    //创建headerView'
    [self createHeaderView];
    //创建ui
    [self createView];
 

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navBarBgAlpha = @"0.0";

}
-(void) createNavi{
    
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(selectBackBtn:) isLeft:YES];
    
}
-(void) createHeaderView{
    __weak typeof(self) weakSelf =self;
    self.headerView = [[SDLoginHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 279)];
    self.headerView.loginTypeBlock = ^(NSString *type) {
        weakSelf.type = type;
    };
    [self.view addSubview:self.headerView];
}
-(void)setType:(NSString *)type{
    _type = type;
    
    //清空
    self.phoneTF.text = @"";
    
//     __weak typeof(self) weakSelf = self;
    if ([type isEqualToString:@"account"]) {
        //账号登录
         self.phoneTF.placeholder = @"请输入登录用户名";
         self.passwordTF.placeholder = @"请输入登录密码";
         self.sendBtn.hidden = YES;
        
         self.forgetPsdBtn.hidden = NO;
//        [self.registLab mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(weakSelf.loginBtn).offset(-20);
//            make.centerY.equalTo(weakSelf.forgetPsdBtn.mas_centerY);
//        }];
       
    }else{
         self.phoneTF.placeholder = @"请输入手机号";
         self.passwordTF.placeholder = @"请输入验证码";
         self.sendBtn.hidden = NO;
        
         self.forgetPsdBtn.hidden = YES;
//        [self.registLab mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.loginBtn.mas_bottom).offset(25);
//            make.centerX.equalTo(weakSelf.loginBtn.mas_centerX);
//        }];

    }
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    
    //公司名字
    self.orgTF = [[UITextField alloc]init];
    self.orgTF.placeholder = @"组织代码";
    [self.view addSubview:self.orgTF];
    self.orgTF.layer.cornerRadius = 3;
    self.orgTF.layer.masksToBounds = YES;
    self.orgTF.clearButtonMode =UITextFieldViewModeAlways;
    self.orgTF.returnKeyType = UIReturnKeyDone;
    self.orgTF.font = [UIFont systemFontOfSize:14];
    self.orgTF.leftViewMode = UITextFieldViewModeAlways;
    self.orgTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_org"]];
    UIView *orgLeftView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    leftImage.center = orgLeftView.center;
    [orgLeftView addSubview:leftImage];
    self.orgTF.leftView =orgLeftView;
    [self.orgTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.mas_bottom).offset(48);
        make.right.equalTo(weakSelf.view).offset(-38);
        make.height.equalTo(@60);
        make.width.equalTo(@100);
    }];

    UILabel *lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    lab.text = @"@";
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@20);
        make.right.equalTo(weakSelf.orgTF.mas_left);
        make.centerY.equalTo(weakSelf.orgTF.mas_centerY);
    }];

    self.phoneTF = [[UITextField alloc]init];
    [self.view addSubview:self.phoneTF];
    self.phoneTF.delegate = self;
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(38);
        make.right.equalTo(lab.mas_left);
        make.height.equalTo(weakSelf.orgTF);
        make.centerY.equalTo(weakSelf.orgTF.mas_centerY);
    }];
    UIImageView *loginLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_account"]];
    UIView *loginLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    loginLeftImage.center = loginLeftView.center;
    [loginLeftView addSubview:loginLeftImage];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.leftView =loginLeftView;
    self.phoneTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.phoneTF.placeholder = @"请输入登录用户名";
    self.phoneTF.font = [UIFont systemFontOfSize:15];
   
//    //发送验证码
//    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.sendBtn];
//    [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//    [self.sendBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
//    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@69);
//        make.height.equalTo(@27);
//        make.right.equalTo(weakSelf.view).offset(-42);
//        make.centerY.equalTo(weakSelf.phoneTF.mas_centerY);
//    }];
//    self.sendBtn.layer.borderWidth = 0.5;
//    self.sendBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
//    self.sendBtn.layer.cornerRadius = 27/2;
//    self.sendBtn.layer.masksToBounds = YES;
//    [self.sendBtn addTarget:self action:@selector(selectSendBtn:) forControlEvents:UIControlEventTouchUpInside];
//     self.sendBtn.hidden = YES;
//
    UIView *accountLineView = [[UIView alloc]init];
    [self.view addSubview:accountLineView];
    [accountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneTF.mas_bottom);
        make.left.equalTo(weakSelf.phoneTF);
        make.right.equalTo(weakSelf.view).offset(-38);
        make.height.equalTo(@1);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    accountLineView.backgroundColor = [UIColor colorWithHexString:@"#b9c1d6"];

    //密码
    self.passwordTF = [[UITextField alloc]init];
    [self.view addSubview:self.passwordTF];
    self.passwordTF.delegate = self;
    self.passwordTF.secureTextEntry = YES;
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountLineView.mas_bottom);
        make.left.equalTo(weakSelf.phoneTF);
        make.right.equalTo(weakSelf.view).offset(-38);
        make.height.equalTo(weakSelf.phoneTF.mas_height);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    UIImageView *psdLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_account_psd"]];
    UIView *psdLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    psdLeftImage.center = psdLeftView.center;
    [psdLeftView addSubview:psdLeftImage];
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.leftView =psdLeftView;
    self.passwordTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.passwordTF.placeholder = @"请输入登录密码";
    self.passwordTF.font = [UIFont systemFontOfSize:15];

    UIView *phoneLIneView = [[UIView alloc]init];
    [self.view addSubview:phoneLIneView];
    [phoneLIneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTF.mas_bottom);
        make.left.width.equalTo(weakSelf.passwordTF);
        make.height.equalTo(@1);
        make.centerX.equalTo(weakSelf.passwordTF.mas_centerX);
    }];
    phoneLIneView.backgroundColor =  [UIColor colorWithHexString:@"#b9c1d6"];

    //登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passwordTF.mas_bottom).offset(52);
        make.left.equalTo(weakSelf.passwordTF.mas_left);
        make.width.equalTo(weakSelf.passwordTF);
        make.height.equalTo(@44);
        make.centerX.equalTo(weakSelf.passwordTF.mas_centerX);
    }];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.loginBtn.backgroundColor =[UIColor colorWithHexString:@"#1390fe"];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn addTarget:self action:@selector(selectdLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    //忘记密码
//    self.forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:self.forgetPsdBtn];
//    [self.forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.loginBtn.mas_bottom).offset(25);
//        make.left.equalTo(weakSelf.loginBtn.mas_left).offset(10);
//    }];
//    [self.forgetPsdBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
//    [self.forgetPsdBtn setTitleColor:[UIColor colorWithHexString:@"#808080"] forState:UIControlStateNormal];
//    self.forgetPsdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.forgetPsdBtn addTarget:self action:@selector(selectForgetBtn:) forControlEvents:UIControlEventTouchUpInside];
//     self.forgetPsdBtn.hidden = NO;
//
//    //注册密码
//    self.registLab = [[YYLabel alloc]init];
//    [self.view addSubview:self.registLab];
//
//    self.forgetPsdBtn.hidden = NO;
//    [self.registLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.loginBtn.mas_bottom).offset(25);
//        make.centerX.equalTo(weakSelf.loginBtn.mas_centerX);
//    }];
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"暂无账号，立即注册>"];
//    text.lineSpacing = 5;
//    text.font = [UIFont systemFontOfSize:14];
//    text.color = [UIColor colorWithHexString:@"#808080"];
//    [text setTextHighlightRange:NSMakeRange(7, 3) color:[UIColor colorTextBlueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//
//       //点击注册
//        weakSelf.hidesBottomBarWhenPushed = YES;
//        SDRegisterController *registVC = [[SDRegisterController alloc]init];
//        [weakSelf.navigationController pushViewController:registVC animated:YES];
//
//    }];
//    self.registLab.numberOfLines = 0;
//    self.registLab.attributedText = text;
}

#pragma mark ----UITextFeildDelegate---
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    else if ([textField isEqual:self.passwordTF]) {
        //密码
        if ([self.type isEqualToString:@"phone"]) {
           return textField.text.length < 11;
        }

    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.passwordTF) {
        CGRect viewFrame =self.view.frame;
        viewFrame.origin.y -= 50;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = viewFrame;
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.passwordTF) {
        CGRect viewFrame =self.view.frame;
        viewFrame.origin.y += 50;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = viewFrame;
        }];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark -----按钮点击事件-----
//点击登录按钮
-(void)selectdLoginBtn:(UIButton *) sender{
    
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.orgTF resignFirstResponder];
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入登录用户名"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (self.passwordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if (self.orgTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入组织代码"];
            [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    [self requestLoginData];
}
//发送验证码
-(void)selectSendBtn:(UIButton *) sender{
    
    if (self.phoneTF.text.length > 0) {
        [self requsetTestCode];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:1.5];
    }

}
//点击忘记密码
-(void)selectForgetBtn:(UIButton *) sender{

   
}
//返回按钮
-(void)selectBackBtn:(UIButton *) sender{

    //返回
    if (self.isBackHome) {
        self.tabBarController.selectedIndex = 0;
        //隐藏tabbar
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
//时间实现方法
-(void)repeat
{
    if (self.timerPage > 0) {
        self.timerPage --;
        [self.sendBtn setTitle:[NSString stringWithFormat:@"%ld 重新发送",(long)self.timerPage] forState:UIControlStateNormal];
    }else{
        self.sendBtn.enabled = YES;
        [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
    }
}
#pragma mark ---- 数据相关----
-(void) requestLoginData{
    
    __weak typeof(self) weakSelf = self;
    
    if ([self.type isEqualToString:@"account"]) {
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"epid"] = self.orgTF.text;
        param[@"username"] =self.phoneTF.text;
        param[@"password"] = self.passwordTF.text;
        param[@"type"] = @"login";
        [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ACCOUT_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
          //  NSLog(@"------%@---",showdata);
            
            if (!error) {
                // 保存用户信息
                [SDUserInfo saveUserData:showdata];
               
                //否则直接进入应用
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SDRootTabBarcontrolller *custTabVC = [sb instantiateViewControllerWithIdentifier:@"SDRootTabBarcontrolller"];
                AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                appdel.window.rootViewController =custTabVC;

            }else{
                [SVProgressHUD  showErrorWithStatus:error];
                [SVProgressHUD  dismissWithDelay:1];
            }
        }];
    }else{
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"phone"] =self.phoneTF.text;
        param[@"code"] = self.passwordTF.text;
        param[@"userid"] = self.userID;
        [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_IPHONE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            
            if (!error) {
                // 保存用户信息
                [SDUserInfo saveUserData:showdata];
   
                //返回
                if (weakSelf.isBackHome) {
                    weakSelf.tabBarController.selectedIndex = 0;
                    //隐藏tabbar
                    weakSelf.tabBarController.tabBar.hidden = YES;
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    //选择平台
                    SDSelectPlatformController *platformVC = [[SDSelectPlatformController alloc]init];
                    [weakSelf.navigationController pushViewController:platformVC animated:YES];
                }
                
            }else{
                [SVProgressHUD  showErrorWithStatus:error];
                [SVProgressHUD  dismissWithDelay:1];
            }
            
        }];
    }
}
-(void)requsetTestCode{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] =self.phoneTF.text;
    param[@"cdoe"] = @"login";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_TEXTCODE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            [SVProgressHUD  showSuccessWithStatus:@"发送成功"];
            [SVProgressHUD  dismissWithDelay:1.5];
            
            weakSelf.timerPage = 60;
            
            _timer = [HWWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeat)userInfo:nil repeats:YES];
            
            weakSelf.userID = showdata[@"userid"];
            
          
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];
}




@end
