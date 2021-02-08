//
//  SDShowPromptView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDShowPromptView.h"

@implementation SDShowPromptView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =  [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.alpha = 0.75;
    bgView.backgroundColor = [UIColor blackColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@175);
        make.height.equalTo(@85);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    
    
    UILabel *lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = @"平台绑定成功";
    lab.textColor = [UIColor colorTextWhiteColor];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.centerY.equalTo(bgView.mas_centerY);
    }];
    
}



@end
