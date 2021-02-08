//
//  SDRegisterController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/26.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDRegisterController.h"

#import "HWWeakTimer.h"


@interface SDRegisterController ()<UITextFieldDelegate>{
    NSTimer *_timer;
}


@property (nonatomic,strong) UIView *registerView;

//同意用户协议按钮
@property (nonatomic,strong) UIButton *agreeBtn;

@property (nonatomic,strong) UIButton *registerBtn;

//立即登录
@property (nonatomic,strong) UIButton *loginBtn;
//发送验证码
@property (nonatomic,strong)UIButton  *sendBtn;
//显示时间
@property (nonatomic,assign) NSInteger timerPage;
@end

@implementation SDRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
   //设置导航栏
    [self createNavi];
    [self createRegisterView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1";
}
#pragma mark ----设置导航栏----
-(void) createNavi{
    [self customNaviItemTitle:@"注册" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(backBtnAction:) isLeft:YES];
}
-(void)backBtnAction:(UIButton *) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createRegisterView{
    
    __weak typeof(self) weakSelf = self;
    
    self.registerView = [[UIView alloc]init];
    [self.view addSubview:self.registerView];
    self.registerView.frame = CGRectMake(0, 16+KSNaviTopHeight, KScreenW, 6*60);
    
    NSArray *nameArr = @[@"请输入你的真实姓名",@"你的身份证号码",@"输入登录密码",@"确定登录密码",@"请输入绑定手机号码",@"请输入验证码"];
    
    NSArray *imageArr = @[@"ico_zc-user",@"ico_zc_num",@"ico_zc_password",@"ico_zc_password",@"icon-phone",@"ico_zc_code"];
    for (int i=0; i< 6; i++) {
        //密码
        UITextField *textField= [[UITextField alloc]initWithFrame:CGRectMake(38, i*60, KScreenW-76, 60)];
        [self.registerView addSubview:textField];
        textField.delegate = self;
        
        UIImageView *psdLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArr[i]]];
        UIView *psdLeftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        psdLeftImage.center = psdLeftView.center;
        [psdLeftView addSubview:psdLeftImage];
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.leftView =psdLeftView;
        textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
        textField.placeholder = nameArr[i];
        textField.font = [UIFont systemFontOfSize:15];
        
        textField.tag = 200+i;
        if (i == 2 || i == 3) {
            textField.secureTextEntry = YES;
        }
        
        if (i == 5) {
            //发送验证码
            self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.registerView addSubview:_sendBtn];
            [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [self.sendBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
            self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            
            [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@69);
                make.height.equalTo(@27);
                make.right.equalTo(weakSelf.registerView).offset(-42);
                make.centerY.equalTo(textField.mas_centerY);
            }];
            self.sendBtn.layer.borderWidth = 0.5;
            self.sendBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
            self.sendBtn.layer.cornerRadius = 27/2;
            self.sendBtn.layer.masksToBounds = YES;
            [self.sendBtn addTarget:self action:@selector(selectSendBtn:) forControlEvents:UIControlEventTouchUpInside];
        }

        UIView *phoneLIneView = [[UIView alloc]init];
        [self.registerView addSubview:phoneLIneView];
        [phoneLIneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(textField.mas_bottom);
            make.left.width.equalTo(textField);
            make.height.equalTo(@1);
            make.centerX.equalTo(textField.mas_centerX);
        }];
        phoneLIneView.backgroundColor =  [UIColor colorWithHexString:@"#b9c1d6"];
    }
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.registerView.mas_bottom).offset(76);
        make.left.equalTo(weakSelf.view).offset(38);
        make.right.equalTo(weakSelf.view).offset(-38);
        make.height.equalTo(@44);
        make.centerX.equalTo(weakSelf.registerView.mas_centerX);
    }];
    self.registerBtn.backgroundColor  =[UIColor colorTextBlueColor];
    [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.registerBtn.titleLabel.font  =[UIFont systemFontOfSize:15];
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    [self.registerBtn addTarget:self action:@selector(sellecRegistBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.agreeBtn];
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.registerBtn).offset(10);
        make.top.equalTo(weakSelf.registerBtn.mas_bottom).offset(25);
    }];
    [self.agreeBtn setImage:[UIImage imageNamed:@"pic_zc_shape"] forState:UIControlStateNormal];
    [self.agreeBtn setImage:[UIImage imageNamed:@"pic_zc"] forState:UIControlStateSelected];
    [self.agreeBtn addTarget:self action:@selector(selectAgreeBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeBtn.selected = YES;
    
    YYLabel *lab = [[YYLabel alloc]init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.agreeBtn.mas_right).offset(4);
        make.centerY.equalTo(weakSelf.agreeBtn.mas_centerY);
    }];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"我已阅读并同意用户平台协议"];
    text.lineSpacing = 5;
    text.font = [UIFont systemFontOfSize:11];
    text.color = [UIColor colorWithHexString:@"#808080"];
    [text setTextHighlightRange:NSMakeRange(7, 6) color:[UIColor colorTextBlueColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        //点击注册
        
    }];
    // 下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [text addAttributes:attribtDic range:NSMakeRange(7, 6)];
    
    lab.numberOfLines = 0;
    lab.attributedText = text;
    
    
    //立即登录
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setTitle:@"立即登录>" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.registerBtn.mas_right).offset(-10);
        make.centerY.equalTo(lab.mas_centerY);
    }];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginBtn addTarget:self action:@selector(selectdLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark ----UITextFeildDelegate-----
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    UITextField *phoneTF = [self.view viewWithTag:204];
    if (range.length == 1 && string.length == 0) {
        return YES;
    }
    else if ([textField isEqual:phoneTF]) {
        //密码
        return textField.text.length < 11;
    
    }
   
    return YES;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark ----按钮点击事件----
//发送验证码
-(void)selectSendBtn:(UIButton *)sender{

    UITextField *textField = [self.view viewWithTag:200+4];
    if (textField.text.length > 0) {
        [self requsetRegistTextCode];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入绑定手机号"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    
}
//点击同意协议
-(void)selectAgreeBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
}
//点击立即登录
-(void)selectdLoginBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//注册
-(void)sellecRegistBtn:(UIButton *)sender{
    
    [self requestRegisterData];
    
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
-(void) requestRegisterData{
    
    __weak typeof(self) weakSelf = self;
    
    UITextField *nameTextField = [self.view viewWithTag:200];
    UITextField *idCardTextField = [self.view viewWithTag:201];
    UITextField *passdTextField = [self.view viewWithTag:202];
    UITextField *repassdTextField = [self.view viewWithTag:203];
    UITextField *mobileTextField = [self.view viewWithTag:204];
    UITextField *codeTextField = [self.view viewWithTag:205];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"truename"] =nameTextField.text;
    param[@"password"] = passdTextField.text;
    param[@"repassword"] = repassdTextField.text;
    param[@"mobile"] = mobileTextField.text;
    param[@"code"] = codeTextField.text;
    param[@"idcard"] = idCardTextField.text;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_REGISTER_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {

        if (!error) {
            NSLog(@"----%@---",showdata);
    
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
-(void)requsetRegistTextCode{
    __weak typeof(self) weakSelf = self;
    UITextField *textField = [self.view viewWithTag:200+4];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] =textField.text;
    param[@"code"] = @"reg";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_TEXTCODE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            [SVProgressHUD  showSuccessWithStatus:@"发送成功"];
            [SVProgressHUD  dismissWithDelay:1.5];

            weakSelf.timerPage = 60;

            _timer = [HWWeakTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeat)userInfo:nil repeats:YES];

        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];
}

@end
