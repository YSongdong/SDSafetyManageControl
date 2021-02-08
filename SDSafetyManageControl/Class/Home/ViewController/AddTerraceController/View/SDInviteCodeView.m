//
//  SDInviteCodeView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDInviteCodeView.h"

@interface  SDInviteCodeView ()<UITextFieldDelegate>



@end


@implementation SDInviteCodeView

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
    lab.text = @"邀请码激活";
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImageView.mas_bottom).offset(39);
        make.centerX.equalTo(bgImageView.mas_centerX);
    }];
    
    //输入框
    self.inviteTF = [[UITextField alloc]init];
    [self addSubview:self.inviteTF];
    self.inviteTF.delegate = self;
    self.inviteTF.placeholder = @"请输入邀请码";
    self.inviteTF.textAlignment = NSTextAlignmentCenter;
    self.inviteTF.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    self.inviteTF.font = [UIFont systemFontOfSize:19];
    [ self.inviteTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(40);
        make.left.equalTo(weakSelf).offset(60);
        make.right.equalTo(weakSelf).offset(-60);
        make.height.equalTo(@44);
        make.centerX.equalTo(lab.mas_centerX);
    }];
     self.inviteTF.layer.cornerRadius = 5;
     self.inviteTF.layer.masksToBounds = YES;
   
    
    //邀请码激活
    UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:tureBtn];
    [tureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [tureBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    tureBtn.backgroundColor = [UIColor colorWithHexString:@"1390fd"];
    tureBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.inviteTF.mas_bottom).offset(32);
        make.width.height.equalTo(weakSelf.inviteTF);
        make.left.equalTo(weakSelf.inviteTF);
        make.centerX.equalTo(weakSelf.inviteTF.mas_centerX);
    }];
    tureBtn.layer.cornerRadius = 5;
    tureBtn.layer.masksToBounds = YES;
    [tureBtn addTarget:self action:@selector(tureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark ------UITextFieldDelegate---
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.inviteTF) {
        CGRect viewFrame =self.frame;
        viewFrame.origin.y -= 80;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = viewFrame;
        }];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.inviteTF) {
        CGRect viewFrame =self.frame;
        viewFrame.origin.y += 80;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = viewFrame;
        }];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

//确定按钮
-(void)tureAction:(UIButton *) sender{
    
    self.tureBtnBlock(self.inviteTF.text);
}


@end
