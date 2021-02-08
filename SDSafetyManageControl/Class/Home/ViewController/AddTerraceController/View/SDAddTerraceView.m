//
//  SDAddTerraceView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAddTerraceView.h"

@implementation SDAddTerraceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAddView];
    }
    return self;
}

-(void) createAddView{
    
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor colorTextWhiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    [self addSubview:bgImageView];
    bgImageView.image = [UIImage imageNamed:@"tjpt_pic_bg"];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf);
        make.height.equalTo(@320);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.font = [UIFont systemFontOfSize:24];
    lab.textColor = [UIColor colorWithHexString:@"#282828"];
    lab.text = @"请选择激活方式";
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_bottom).offset(39);
        make.centerX.equalTo(bgImageView.mas_centerX);
    }];
    
    //二维码按钮
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:codeBtn];
    [codeBtn setTitle:@"二维码激活" forState:UIControlStateNormal];
    [codeBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    codeBtn.backgroundColor = [UIColor colorWithHexString:@"1390fd"];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(40);
        make.left.equalTo(weakSelf).offset(60);
        make.right.equalTo(weakSelf).offset(-60);
        make.height.equalTo(@44);
        make.centerX.equalTo(lab.mas_centerX);
    }];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.layer.masksToBounds = YES;
    [codeBtn addTarget:self action:@selector(selectdCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //邀请码激活
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:inviteBtn];
    [inviteBtn setTitle:@"邀请码激活" forState:UIControlStateNormal];
    [inviteBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    inviteBtn.backgroundColor = [UIColor colorWithHexString:@"1390fd"];
    inviteBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeBtn.mas_bottom).offset(32);
        make.width.height.equalTo(codeBtn);
        make.left.equalTo(codeBtn);
        make.centerX.equalTo(codeBtn.mas_centerX);
    }];
    inviteBtn.layer.cornerRadius = 5;
    inviteBtn.layer.masksToBounds = YES;
    [inviteBtn addTarget:self action:@selector(selectdInviteAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)selectdCodeAction:(UIButton *)sender{
    //0 二维码方式    1邀请码方式
    self.selectBtnBlock(0);
    
}
-(void)selectdInviteAction:(UIButton *)sender{
    //0 二维码方式    1邀请码方式
    self.selectBtnBlock(1);
}




@end
