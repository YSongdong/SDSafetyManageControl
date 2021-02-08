//
//  SDUserInfoHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/26.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserInfoHeaderView.h"

@interface SDUserInfoHeaderView ()

@property (nonatomic,strong) UIImageView *headerImageV;

//登录按钮
@property (nonatomic,strong) UIButton *loginBtn;
//名字
@property (nonatomic,strong) UILabel *turenameLab;

@property (nonatomic,strong) UILabel *usernameLab;
//电话
@property (nonatomic,strong) UILabel *telLab;
//身份证
@property (nonatomic,strong) UILabel *idCardLab;
@end

@implementation SDUserInfoHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createHeaderView];
    }
    return self;
}
-(void)createHeaderView{
    __weak typeof(self) weakSelf = self;
    self.backgroundColor  =[UIColor colorWithHexString:@"#f9f9f9"];
    
    UIImageView *backIamgeV = [[UIImageView alloc]init];
    [self addSubview:backIamgeV];
    [backIamgeV mas_makeConstraints:^(MASConstraintMaker *make) {
     //   make.top.equalTo(weakSelf).offset(-KSNaviTopHeight);
        make.left.top.right.equalTo(weakSelf);
        make.height.equalTo(@(self.frame.size.height-15));
    }];
    backIamgeV.image = [UIImage imageNamed:@"mine_header_bg"];
    
    
    self.headerImageV = [[UIImageView alloc]init];
    [self addSubview:self.headerImageV];
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backIamgeV).offset(10+KSNaviTopHeight);
        make.width.height.equalTo(@98);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    self.headerImageV.layer.cornerRadius = 98/2;
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.image = [UIImage imageNamed:@"mine_header_default"];
    self.headerImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [self.headerImageV addGestureRecognizer:tap];
    
    
    self.turenameLab = [[UILabel alloc]init];
    [self addSubview:self.turenameLab];
    [self.turenameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerImageV.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.headerImageV.mas_centerX);
    }];
    self.turenameLab.font = [UIFont systemFontOfSize:12];
    self.turenameLab.textColor = [UIColor colorTextWhiteColor];
    self.turenameLab.text = @"你好，欢迎使用";
    
    self.loginBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@103);
        make.height.equalTo(@30);
        make.top.equalTo(weakSelf.turenameLab.mas_bottom).offset(14);
        make.centerX.equalTo(weakSelf.turenameLab.mas_centerX);
    }];
    self.loginBtn.layer.cornerRadius = 30/2;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.titleLabel.font =  [UIFont systemFontOfSize:14];
    self.loginBtn.backgroundColor  = [UIColor colorWithHexString:@"#61b9fb"];
    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(selectdLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usernameLab = [[UILabel alloc]init];
    [self addSubview:self.usernameLab];
    [self.usernameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.turenameLab.mas_bottom).offset(7);
        make.centerX.equalTo(weakSelf.turenameLab.mas_centerX);
    }];
    self.usernameLab.font= [UIFont systemFontOfSize:12];
    self.usernameLab.textColor  = [UIColor colorTextWhiteColor];
    self.usernameLab.hidden = YES;
    
    self.telLab = [[UILabel alloc]init];
    [self addSubview:self.telLab];
    [self.telLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.usernameLab.mas_bottom).offset(13);
        make.centerX.equalTo(weakSelf.usernameLab.mas_centerX).offset(-40);
    }];
    self.telLab.textColor = [UIColor colorTextWhiteColor];
    self.telLab.font = [UIFont systemFontOfSize:12 ];
    self.telLab.hidden = YES;
    
    UIImageView *telImageV = [[UIImageView alloc]init];
    [self addSubview:telImageV];
    [telImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.telLab.mas_left).offset(-3);
        make.centerY.equalTo(weakSelf.telLab.mas_centerY);
    }];
    telImageV.image = [UIImage imageNamed:@"personal_ico_phone"];
    telImageV.tag = 300;
    telImageV.hidden = YES;
    
    
    UIImageView *idCardImageV = [[UIImageView alloc]init];
    [self addSubview:idCardImageV];
    [idCardImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.usernameLab.mas_bottom).offset(13);
        make.centerX.equalTo(weakSelf.usernameLab.mas_centerX).offset(40);
    }];
    idCardImageV.image = [UIImage imageNamed:@"personal_ico_id"];
    idCardImageV.tag = 301;
    idCardImageV.hidden = YES;
    
    self.idCardLab = [[UILabel alloc]init];
    [self addSubview:self.idCardLab];
    [self.idCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(idCardImageV.mas_right).offset(3);
        make.centerY.equalTo(idCardImageV.mas_centerY);
    }];
    self.idCardLab.textColor = [UIColor colorTextWhiteColor];
    self.idCardLab.font = [UIFont systemFontOfSize:12 ];
    self.idCardLab.hidden = YES;
    
    //判断是否登录
   // [self passLogin];
}

//判断是否登录
-(void) passLogin{
    if ([SDUserInfo passLoginData]) {
        //隐藏
        self.loginBtn.hidden = YES;
        
        //设置头像
        [SDTool sd_setImageView:self.headerImageV WithURL:[SDUserInfo obtainWithphoto]];
        
        self.turenameLab.text = [SDUserInfo obtainWithtrueName];
        self.turenameLab.font = [UIFont systemFontOfSize:18];
        
 //       self.usernameLab.text = [SDUserInfo obtainWithUserName];
        self.usernameLab.hidden = NO;
        
        self.telLab.text = [[SDUserInfo obtainWithPhone] stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
        self.telLab.hidden = NO;
        
        NSString *idCardStr =[SDUserInfo obtainWithidcard];
        NSString *idCardToStr = [idCardStr substringToIndex:4];
        NSString *idCardFrmoStr = [idCardStr substringFromIndex:14];
        self.idCardLab.text = [NSString stringWithFormat:@"%@*****%@",idCardToStr,idCardFrmoStr];
        self.idCardLab.hidden = NO;
        
        for (int i= 0; i< 2; i++) {
            UIImageView *imageView = [self viewWithTag:300+i];
            imageView.hidden = NO;
        }
    }
    
}

#pragma mark ----按钮点击事件---
//登录
-(void)selectdLoginBtn:(UIButton *)sender{
    
    self.loginBlock();
    
}

-(void)selectTap{
    
    self.userInfoBlock();
    
}

-(void)loginInfo:(NSDictionary *)dict{
    
    //隐藏
    self.loginBtn.hidden = YES;
    
    //设置头像
    [SDTool sd_setImageView:self.headerImageV WithURL:dict[@"photo"]];
    
    self.turenameLab.text = dict[@"truename"];
    self.turenameLab.font = [UIFont systemFontOfSize:18];
    
    self.usernameLab.text = dict[@"username"];
    self.usernameLab.hidden = NO;
    
    self.telLab.text = [dict[@"phone"]  stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
    self.telLab.hidden = NO;
    
  
    NSString *idCardStr =dict[@"idcard"];
    NSString *idCardToStr = [idCardStr substringToIndex:4];
    NSString *idCardFrmoStr = [idCardStr substringFromIndex:14];
    self.idCardLab.text = [NSString stringWithFormat:@"%@*****%@",idCardToStr,idCardFrmoStr];
    self.idCardLab.hidden = NO;
    
    for (int i= 0; i< 2; i++) {
        UIImageView *imageView = [self viewWithTag:300+i];
        imageView.hidden = NO;
    }
    
}



@end
