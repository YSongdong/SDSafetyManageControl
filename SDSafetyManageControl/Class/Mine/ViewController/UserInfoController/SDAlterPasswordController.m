//
//  SDAlterPasswordController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/3.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAlterPasswordController.h"

@interface SDAlterPasswordController ()

//原密码
@property (nonatomic,strong) UITextField *oldPsdTF;
//新密码
@property (nonatomic,strong) UITextField *newsPsdTF;
//新密码
@property (nonatomic,strong) UITextField *truePsdTF;


@end

@implementation SDAlterPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    //创建view
    [self createView];
    
}
#pragma mark ---- 设置导航栏----
-(void) createNavi{
    [self customNaviItemTitle:@"修改密码" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(backBtn:) isLeft:YES];
}
-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----创建view-------
-(void) createView{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    __weak typeof(self) weakSelf = self;
    
    NSArray *arr = @[@"原密码",@"新密码",@"确认密码"];
    
    
    for (int i=0; i<3; i++) {
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
        lab.text =arr[i];
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
        textField.secureTextEntry = YES;
        textField.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
        textField.font = [UIFont systemFontOfSize:16];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lab.mas_right).offset(17);
            make.right.equalTo(numberView);
            make.centerY.equalTo(lab.mas_centerY);
        }];
        
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
    UIView *lastView = [self.view viewWithTag:202];
    
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

//确定按钮
-(void)trueBtn:(UIButton *) sender{
    UITextField *oldTF = [self.view viewWithTag:100];
    UITextField *newTF = [self.view viewWithTag:101];
    UITextField *trueTF = [self.view viewWithTag:102];
    
    if (oldTF.text.length == 0) {
        [SVProgressHUD  showSuccessWithStatus:@"原密码"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    if (newTF.text.length == 0) {
        [SVProgressHUD  showSuccessWithStatus:@"新密码"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    if (trueTF.text.length == 0) {
        [SVProgressHUD  showSuccessWithStatus:@"确认密码"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    
    [self requestEditPassword];
}
#pragma mark -----  数据相关----
//修改手机号码
-(void) requestEditPassword{
    
    UITextField *oldTF = [self.view viewWithTag:100];
    UITextField *newTF = [self.view viewWithTag:101];
    UITextField *trueTF = [self.view viewWithTag:102];
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"gdl_userid"] =[SDUserInfo obtainWithGdlUserID];
    param[@"oldpassword"] = oldTF.text;
    param[@"password"] = newTF.text;
    param[@"repassword"] = trueTF.text;
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_EDITPASSWORD_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            [SVProgressHUD  showSuccessWithStatus:@"修改成功"];
            [SVProgressHUD  dismissWithDelay:1.5];
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];
    
}



@end
