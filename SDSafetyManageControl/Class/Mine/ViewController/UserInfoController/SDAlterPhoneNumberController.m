//
//  SDAlterPhoneNumberController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/3.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAlterPhoneNumberController.h"

#import "HWWeakTimer.h"

@interface SDAlterPhoneNumberController () <UITextFieldDelegate>{
    NSTimer *_timer;
}
//发送验证码
@property (nonatomic,strong) UIButton *sendBtn;
//显示时间
@property (nonatomic,assign) NSInteger timerPage;

//记录GdlUserID
@property (nonatomic,strong) NSString *gdlUserID;

@end

@implementation SDAlterPhoneNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    //创建view
    [self createView];
}
#pragma mark ---- 设置导航栏----
-(void) createNavi{
    [self customNaviItemTitle:@"修改手机号码" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(backBtn:) isLeft:YES];
}
-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----创建view-------
-(void) createView{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    __weak typeof(self) weakSelf = self;
    
    NSArray *labArr = @[@"手机号",@"验证密码"];
    
    NSArray *arr = @[@"请输入登录手机号码",@"请输入验证码"];
    
    
    for (int i=0; i<2; i++) {
        UIView * numberView = [[UIView alloc]init];
        [self.view addSubview:numberView];
        numberView.tag =  200 +i;
        numberView.backgroundColor = [UIColor colorTextWhiteColor];
        [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+15+i*60);
            make.left.right.equalTo(weakSelf.view);
            make.height.equalTo(@60);
            make.centerX.equalTo(weakSelf.view.mas_centerX);
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        [numberView addSubview:lab];
        lab.font = [UIFont systemFontOfSize:16];
        lab.text =labArr[i];
        lab.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numberView).offset(21);
            make.width.equalTo(@70);
            make.centerY.equalTo(numberView.mas_centerY);
        }];
        
        
        UITextField *textField = [[UITextField alloc]init];
        [numberView addSubview:textField];
        textField.placeholder = arr[i];
        textField.tag = 100+i;
        textField.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
        textField.font = [UIFont systemFontOfSize:16];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lab.mas_right).offset(17);
            make.right.equalTo(numberView);
            make.centerY.equalTo(lab.mas_centerY);
        }];
        
        if (i == 1) {
            //发送验证码
            self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.view addSubview:self.sendBtn];
            [self.sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            [self.sendBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
            self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@69);
                make.height.equalTo(@27);
                make.right.equalTo(weakSelf.view).offset(-20);
                make.centerY.equalTo(textField.mas_centerY);
            }];
            self.sendBtn.layer.borderWidth = 0.5;
            self.sendBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
            self.sendBtn.layer.cornerRadius = 27/2;
            self.sendBtn.layer.masksToBounds = YES;
            [self.sendBtn addTarget:self action:@selector(selectSendBtn:) forControlEvents:UIControlEventTouchUpInside];
            
        }
       
        UIView *lineView = [[UIView alloc]init];
        [numberView addSubview:lineView];
        lineView.backgroundColor = [UIColor TableViewBackGrounpColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.top.equalTo(numberView.mas_bottom).offset(-1);
            make.left.equalTo(numberView).offset(5);
            make.right.equalTo(numberView).offset(-5);
            make.centerX.equalTo(numberView.mas_centerX);
        }];
        
    }
    
    //找到最后一个view
    UIView *lastView = [self.view viewWithTag:201];
    
    //确定按钮
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:trueBtn];
    [trueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    trueBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    trueBtn.backgroundColor = [UIColor colorTextBlueColor];
    [trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(85);
        make.width.equalTo(@280);
        make.height.equalTo(@44);
        make.centerX.equalTo(lastView.mas_centerX);
    }];
    trueBtn.layer.cornerRadius = 5;
    trueBtn.layer.masksToBounds = YES;
    [trueBtn addTarget:self action:@selector(trueBtn:) forControlEvents:UIControlEventTouchUpInside];
}
//发送验证码
-(void)selectSendBtn:(UIButton *) sender{
    UITextField *textfield = [self.view viewWithTag:100];
    
    if (textfield.text.length > 0) {
        [self requsetTestCode];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [SVProgressHUD dismissWithDelay:1.5];
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
//确定按钮
-(void)trueBtn:(UIButton *) sender{
    UITextField *phoneTF = [self.view viewWithTag:100];
    UITextField *codeTF = [self.view viewWithTag:101];
    if (phoneTF.text.length == 0) {
        [SVProgressHUD  showSuccessWithStatus:@"请输入登录手机号码"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    if (codeTF.text.length == 0) {
        [SVProgressHUD  showSuccessWithStatus:@"请输入验证码"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    
    [self requestEditPhone];
    
}
#pragma mark -----  数据相关----
//修改手机号码
-(void) requestEditPhone{
    
    UITextField *phoneTF = [self.view viewWithTag:100];
    UITextField *codeTF = [self.view viewWithTag:101];
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] =phoneTF.text;
    param[@"code"] = codeTF.text;
    param[@"gdl_userid"] = self.gdlUserID;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_EDITPHONE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            //保持用户修改手机号码
            [SDUserInfo alterNumberPhone:phoneTF.text];
            
            [SVProgressHUD  showSuccessWithStatus:@"发送成功"];
            [SVProgressHUD  dismissWithDelay:1.5];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];

}
//发送验证码
-(void)requsetTestCode{
    //手机号
     UITextField *textfield = [self.view viewWithTag:100];
    
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] =textfield.text;
    param[@"code"] = @"editphone";
    param[@"gdl_userid"] = [SDUserInfo obtainWithGdlUserID];
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_TEXTCODE_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            NSLog(@"------code==%@------",showdata);
            weakSelf.gdlUserID = showdata[@"userid"];
            
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
