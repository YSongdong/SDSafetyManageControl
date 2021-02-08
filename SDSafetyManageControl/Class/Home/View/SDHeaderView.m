//
//  SDHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/24.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDHeaderView.h"

#import "SDPaoMaDengView.h"

@interface SDHeaderView  ()

@property (nonatomic,strong) UILabel *titleLab;

@property (nonatomic,strong) UIButton *loginBtn;

@end


@implementation SDHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{

    __weak typeof(self) weakSelf = self;
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 185)];
    [self addSubview:imageV];
    imageV.userInteractionEnabled = YES;
    imageV.image = [UIImage imageNamed:@"home_bg"];
    
    
//    self.titleLab = [[UILabel alloc]init];
//    [self addSubview:self.titleLab];
//    self.titleLab.text = @"你好，欢迎使用安管控!";
//    self.titleLab.textColor = [UIColor colorTextWhiteColor];
//    self.titleLab.font = [UIFont systemFontOfSize:18];
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf).offset(60);
//        make.centerX.equalTo(weakSelf.mas_centerX);
//    }];
//    
//    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:self.loginBtn];
//    [self.loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
//    [self.loginBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
//    self.loginBtn.titleLabel.font  = [UIFont systemFontOfSize:13];
//    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@85);
//        make.height.equalTo(@28);
//        make.top.equalTo(weakSelf.titleLab.mas_bottom).offset(11);
//        make.centerX.equalTo(weakSelf.titleLab.mas_centerX);
//    }];
//    self.loginBtn.layer.borderWidth = 1;
//    self.loginBtn.layer.borderColor = [UIColor colorTextWhiteColor].CGColor;
//    self.loginBtn.layer.cornerRadius =14;
//    self.loginBtn.layer.masksToBounds = YES;
//    [self.loginBtn addTarget:self action:@selector(selectLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *scrollTexts = @[@"2018年04月08日将进行工程培训考试"];

    SDPaoMaDengView *pmdView = [[SDPaoMaDengView alloc]initWithFrame:CGRectMake(42, 200, KScreenW-84, 40) andHotArr:scrollTexts];
    pmdView.leftImageV.contentMode = UIViewContentModeScaleAspectFit;
    pmdView.leftImageV.image = [UIImage imageNamed:@"home_gg"];
    [self addSubview:pmdView];
    
  
    pmdView.hotBlock = ^(NSString *hotUurl) {
        weakSelf.hotBlock(hotUurl);
    };
    
    //判断是否登录
    if ([SDUserInfo passLoginData]) {
        self.titleLab.hidden = YES;
        self.loginBtn.hidden = YES;
    }
}

-(void)selectLoginBtn:(UIButton *) sender{
    
    self.loginBtnBlock();
    
}
//取消
-(void)hiddenLogin{
    
    self.titleLab.hidden = YES;
    self.loginBtn.hidden = YES;
}

//显示登录按钮
-(void) showLogin{
    self.titleLab.hidden = NO;
    self.loginBtn.hidden = NO;
}



@end
