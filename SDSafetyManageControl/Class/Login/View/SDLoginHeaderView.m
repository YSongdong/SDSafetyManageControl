//
//  SDLoginHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/25.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDLoginHeaderView.h"

@interface SDLoginHeaderView ()

//账号btn
@property (nonatomic,strong)UIButton *accountBtn;

@property (nonatomic,strong) UIImageView *accoutImageV;

//手机
@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) UIImageView *phoneImageV;


@end

@implementation SDLoginHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    //大背景
    UIImageView *bigImageV = [[UIImageView alloc]init];
    [self addSubview:bigImageV];
    bigImageV.image = [UIImage imageNamed:@"login_bigBg"];
    [bigImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    //小
    UIImageView *samilImageV = [[UIImageView alloc]init];
    [self addSubview:samilImageV];
    [samilImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigImageV.mas_top).offset(79);
        make.width.height.equalTo(@98);
        make.centerX.equalTo(bigImageV.mas_centerX);
    }];
    samilImageV.image = [UIImage imageNamed:@"login_samil"];
    
    UILabel *titleLab = [[UILabel alloc]init];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(samilImageV.mas_bottom).offset(14);
        make.centerX.equalTo(samilImageV.mas_centerX);
    }];
    titleLab.textColor  = [UIColor colorTextWhiteColor];
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.text =@"电力作业管控";
    
//    self.accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:self.accountBtn];
//    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLab.mas_bottom).offset(41);
//        make.left.equalTo(weakSelf);
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
//    }];
//    [self.accountBtn setTitle:@"账号密码登录" forState:UIControlStateNormal];
//    [self.accountBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
//    self.accountBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    
//    [self.accountBtn addTarget:self action:@selector(selectdAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //手机登录
//    self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:self.phoneBtn];
//    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakSelf.accountBtn.mas_right).offset(0);
//        make.right.equalTo(weakSelf);
//        make.width.height.equalTo(weakSelf.accountBtn);
//        make.centerY.equalTo(weakSelf.accountBtn.mas_centerY);
//    }];
//    [self.phoneBtn setTitle:@"手机验证登录" forState:UIControlStateNormal];
//    [self.phoneBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
//     self.phoneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [self.phoneBtn addTarget:self action:@selector(selectPhoneBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.phoneBtn.alpha = 0.7;
//    
//    
//    self.accoutImageV = [[UIImageView alloc]init];
//    [self addSubview:self.accoutImageV];
//    self.accoutImageV.image = [UIImage imageNamed:@"login_shape"];
//    [self.accoutImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf);
//        make.centerX.equalTo(weakSelf.accountBtn.mas_centerX);
//    }];
//    
//    self.phoneImageV = [[UIImageView alloc]init];
//    [self addSubview:self.phoneImageV];
//    self.phoneImageV.image = [UIImage imageNamed:@"login_shape"];
//    [self.phoneImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf);
//        make.centerX.equalTo(weakSelf.phoneBtn.mas_centerX);
//    }];
//    //隐藏
//    self.phoneImageV.hidden = YES;
    
}

-(void)selectdAccountBtn:(UIButton *) sender{
    
    self.phoneBtn.alpha = 0.7;
    //隐藏
    self.phoneImageV.hidden = YES;
    self.accountBtn.alpha = 1;
    //隐藏
    self.accoutImageV.hidden = NO;
    
     self.loginTypeBlock(@"account");
}
-(void)selectPhoneBtn:(UIButton *) sender{
    
    self.accountBtn.alpha = 0.7;
    //隐藏
    self.accoutImageV.hidden = YES;
    self.phoneBtn.alpha = 1;
    //隐藏
    self.phoneImageV.hidden = NO;
   
    self.loginTypeBlock(@"phone");
}




@end
