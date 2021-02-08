//
//  SDAlterVipNumberController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/3.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAlterVipNumberController.h"

@interface SDAlterVipNumberController ()

@property (nonatomic,strong) UITextField *numberTF;

@end

@implementation SDAlterVipNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [ UIColor TableViewBackGrounpColor];
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
    
    __weak typeof(self) weakSelf = self;
    UIView * numberView = [[UIView alloc]init];
    [self.view addSubview:numberView];
    numberView.backgroundColor = [UIColor colorTextWhiteColor];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(KSNaviTopHeight+15);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@60);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [numberView addSubview:lab];
    lab.font = [UIFont systemFontOfSize:16];
    lab.text = @"会员账号";
    lab.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberView).offset(21);
        make.width.equalTo(@70);
        make.centerY.equalTo(numberView.mas_centerY);
    }];
    
   
    self.numberTF = [[UITextField alloc]init];
    [numberView addSubview:self.numberTF];
    self.numberTF.placeholder = [SDUserInfo obtainWithUserName];
    self.numberTF.textColor = [UIColor colorWithHexString:@"#4a4a4a"];
    self.numberTF.font = [UIFont systemFontOfSize:16];
    [self.numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:trueBtn];
    [trueBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    trueBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    trueBtn.backgroundColor = [UIColor colorTextBlueColor];
    [trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberView.mas_bottom).offset(63);
        make.width.equalTo(@280);
        make.height.equalTo(@44);
        make.centerX.equalTo(numberView.mas_centerX);
    }];
    trueBtn.layer.cornerRadius = 5;
    trueBtn.layer.masksToBounds = YES;
    [trueBtn addTarget:self action:@selector(trueBtn:) forControlEvents:UIControlEventTouchUpInside];
}

//确定按钮
-(void)trueBtn:(UIButton *) sender{
    if (self.numberTF.text.length == 0) {
        [SVProgressHUD  showErrorWithStatus:@"请输入账号名"];
        [SVProgressHUD  dismissWithDelay:1.5];
        return ;
    }
    [self requestEditPassword];
}
#pragma mark -----  数据相关----
//修改手机号码
-(void) requestEditPassword{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"gdl_userid"] =[SDUserInfo obtainWithGdlUserID];
    param[@"username"] = self.numberTF.text;
    param[@"identity_id"] = [SDUserInfo obtainWithIDentityID];
    param[@"plaform_id"] = [SDUserInfo obtainWithPlaformID];
    param[@"userid"] = [SDUserInfo obtainWithUserID];
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_EDITUSER_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            //保持用户修改userNmae
            [SDUserInfo alterUserName:weakSelf.numberTF.text];
            
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
