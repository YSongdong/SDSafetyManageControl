//
//  SDTitleHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTitleHeaderView.h"

@interface SDTitleHeaderView ()

//重要通知
@property (nonatomic,strong) UIButton *importantNotify;
//平台通知
@property (nonatomic,strong) UIButton *platformNotify;

//线条view
@property (nonatomic,strong) UIView *lineView;

@end

@implementation SDTitleHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self  = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    self.importantNotify = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.importantNotify];
    
    self.platformNotify  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.platformNotify];

    self.lineView = [[UIView alloc]init];
    [self addSubview:self.lineView];
    
    self.importantNotify.backgroundColor = [UIColor colorTextWhiteColor];
    [self.importantNotify setTitle:@"重要通知" forState:UIControlStateNormal];
    [self.importantNotify setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    self.importantNotify.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.importantNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(weakSelf);
    }];
    [self.importantNotify addTarget:self action:@selector(selectdImportBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.platformNotify.backgroundColor  =[UIColor colorTextWhiteColor];
    [self.platformNotify setTitle:@"平台通知" forState:UIControlStateNormal];
    [self.platformNotify setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    self.platformNotify.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.platformNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.importantNotify.mas_right);
        make.right.equalTo(weakSelf);
        make.width.height.equalTo(weakSelf.importantNotify);
        make.centerX.equalTo(weakSelf.importantNotify.mas_centerX);
    }];
    [self.platformNotify addTarget:self action:@selector(selectdPlayformBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //线条view
    self.lineView.backgroundColor = [UIColor colorTextBlueColor];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@160);
        make.height.equalTo(@2);
        make.bottom.equalTo(weakSelf.importantNotify.mas_bottom).offset(-2);
        make.centerX.equalTo(weakSelf.importantNotify.mas_centerX);
    }];
    
}

-(void)selectdImportBtn:(UIButton *) sender{
    __weak typeof(self) weakSelf = self;
    [self.platformNotify setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@160);
        make.height.equalTo(@2);
        make.bottom.equalTo(weakSelf.importantNotify.mas_bottom).offset(-2);
        make.centerX.equalTo(weakSelf.importantNotify.mas_centerX);
    }];
}

-(void)selectdPlayformBtn:(UIButton *) sender{
    
    __weak typeof(self) weakSelf = self;
    [self.importantNotify setTitleColor:[UIColor colorWithHexString:@"#888888"] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@160);
        make.height.equalTo(@2);
        make.bottom.equalTo(weakSelf.platformNotify.mas_bottom).offset(-2);
        make.centerX.equalTo(weakSelf.platformNotify.mas_centerX);
    }];
}




@end
