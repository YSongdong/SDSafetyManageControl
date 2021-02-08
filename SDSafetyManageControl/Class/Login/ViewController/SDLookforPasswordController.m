//
//  SDLookforPasswordController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/3.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDLookforPasswordController.h"

@interface SDLookforPasswordController ()<UITextFieldDelegate>
//账号
@property (nonatomic,strong) UITextField *phoneTF;
//密码
@property (nonatomic,strong) UITextField *passwordTF;
//发送验证码
@property (nonatomic,strong) UIButton *sendBtn;
@end

@implementation SDLookforPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    //创建view
    [self createView];
}
#pragma mark ---- 设置导航栏----
-(void) createNavi{
    [self customNaviItemTitle:@"修改会员账号" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(backBtn:) isLeft:YES];
}
-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----创建view------
-(void)createView{
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    UILabel *lab = [[UILabel alloc]init];
    [self.view addSubview:lab];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = @"用户身份证验证";
    lab.textColor = [UIColor colorWithHexString:@"#444444"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+26);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    self.phoneTF = [[UITextField alloc]init];
    [self.view addSubview:self.phoneTF];
    self.phoneTF.delegate = self;
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(48);
        make.left.equalTo(weakSelf.view).offset(38);
        make.right.equalTo(weakSelf.view).offset(-38);
        make.height.equalTo(@60);
    }];
    UIImageView *loginLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_account"]];
    UIView *loginLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    loginLeftImage.center = loginLeftView.center;
    [loginLeftView addSubview:loginLeftImage];
    self.phoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTF.leftView =loginLeftView;
    self.phoneTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.phoneTF.placeholder = @"请输入手机号/身份证号码";
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    
    //发送验证码
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.sendBtn];
    [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@69);
        make.height.equalTo(@27);
        make.right.equalTo(weakSelf.view).offset(-42);
        make.centerY.equalTo(weakSelf.phoneTF.mas_centerY);
    }];
    self.sendBtn.layer.borderWidth = 0.5;
    self.sendBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
    self.sendBtn.layer.cornerRadius = 27/2;
    self.sendBtn.layer.masksToBounds = YES;
    [self.sendBtn addTarget:self action:@selector(selectSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn.hidden = YES;
    
    UIView *accountLineView = [[UIView alloc]init];
    [self.view addSubview:accountLineView];
    [accountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneTF.mas_bottom);
        make.left.width.equalTo(weakSelf.phoneTF);
        make.height.equalTo(@1);
        make.centerX.equalTo(weakSelf.phoneTF.mas_centerX);
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
        make.width.equalTo(weakSelf.phoneTF.mas_width);
        make.height.equalTo(weakSelf.phoneTF.mas_height);
        make.centerX.equalTo(weakSelf.phoneTF.mas_centerX);
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
    
    
  
    
}


@end
