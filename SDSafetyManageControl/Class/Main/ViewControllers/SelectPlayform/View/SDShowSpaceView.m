//
//  SDShowSpaceView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDShowSpaceView.h"

@implementation SDShowSpaceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.75;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UIView *samilView = [[UIView alloc]init];
    [self addSubview:samilView];
    samilView.backgroundColor = [UIColor colorTextWhiteColor];
    [samilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@160);
        make.right.equalTo(weakSelf).offset(-75);
        make.left.equalTo(weakSelf).offset(75);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    samilView.layer.cornerRadius = 15;
    samilView.layer.masksToBounds = YES;
    
    
    UILabel *lab = [[UILabel alloc]init];
    [samilView addSubview:lab];
    lab.text = @"暂无可选平台，请先添加平台";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor colorWithHexString:@"#656565"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(samilView).offset(70);
        make.centerX.equalTo(samilView.mas_centerX);
    }];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [samilView addSubview:homeBtn];
    [homeBtn setTitle:@"回到首页" forState:UIControlStateNormal];
    [homeBtn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
    homeBtn.backgroundColor = [UIColor colorTextWhiteColor];
    homeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(samilView).offset(16);
        make.top.equalTo(lab.mas_bottom).offset(26);
        make.width.equalTo(@92);
        make.height.equalTo(@33);
    }];
    homeBtn.layer.borderWidth = 1;
    homeBtn.layer.borderColor =[UIColor colorWithHexString:@"#cecece"].CGColor;
    homeBtn.layer.cornerRadius = 4;
    homeBtn.layer.masksToBounds = YES;
    [homeBtn addTarget:self action:@selector(selectHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [samilView addSubview:addBtn];
    [addBtn setTitle:@"立即添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor colorWithHexString:@"#04a6e3"];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@92);
        make.height.equalTo(@33);
        make.left.equalTo(homeBtn.mas_right).offset(10);
        make.centerY.equalTo(homeBtn.mas_centerY);
    }];
    addBtn.layer.borderWidth = 1;
    addBtn.layer.borderColor =[UIColor colorWithHexString:@"#989898"].CGColor;
    addBtn.layer.cornerRadius = 4;
    addBtn.layer.masksToBounds = YES;
    [addBtn addTarget:self action:@selector(selectAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [self addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"xzpt_icon"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(samilView.mas_top).offset(45);
        make.right.left.equalTo(samilView);
        make.centerX.equalTo(samilView.mas_centerX);
    }];
    
}

-(void)selectHomeBtn:(UIButton *) sender{
    self.btnBlcok(0);
    
}

-(void)selectAddBtn:(UIButton *) sender{
    
    self.btnBlcok(1);
}


@end
