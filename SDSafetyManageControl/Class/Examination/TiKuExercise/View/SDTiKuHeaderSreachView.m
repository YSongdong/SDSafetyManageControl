//
//  SDTiKuHeaderSreachView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/8.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTiKuHeaderSreachView.h"

@interface SDTiKuHeaderSreachView () <UITextFieldDelegate>


@end

@implementation SDTiKuHeaderSreachView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createView ];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf =  self;
    
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:bgBtn];
    bgBtn.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf).offset(12);
        make.right.equalTo(weakSelf).offset(-12);
        make.bottom.equalTo(weakSelf).offset(-5);
       // make.height.equalTo(@35);
    }];
    bgBtn.layer.cornerRadius = 7;
    bgBtn.layer.masksToBounds = YES;
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [self addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"tklx_icon_search"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgBtn).offset(10);
        make.width.equalTo(@20);
        make.centerY.equalTo(bgBtn.mas_centerY);
    }];
    
    self.sreachTF = [[UITextField alloc]init];
    [self addSubview:self.sreachTF];
    self.sreachTF.placeholder = @"请输入关键词搜索题库";
    self.sreachTF.delegate = self;
    self.sreachTF.textColor = [UIColor colorWithHexString:@"#282828"];
    self.sreachTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.sreachTF.font  = [UIFont systemFontOfSize:13];
    [self.sreachTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right).offset(10);
        make.height.equalTo(bgBtn);
        make.right.equalTo(bgBtn.mas_right);
        make.centerY.equalTo(bgBtn.mas_centerY);
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
