//
//  SDShowTiKuSpaceView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/8.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDShowTiKuSpaceView.h"

@implementation SDShowTiKuSpaceView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    
    UIImageView *imageV = [[UIImageView alloc]init];
    [self addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"tklx_sl_icon"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(104);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.text = @"暂未找到相关习题，换个词试试~";
    lab.textColor = [UIColor colorWithHexString:@"#989898"];
    lab.font = [UIFont systemFontOfSize:14];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(23);
        make.centerX.equalTo(imageV.mas_centerX);
    }];
    
}


@end
