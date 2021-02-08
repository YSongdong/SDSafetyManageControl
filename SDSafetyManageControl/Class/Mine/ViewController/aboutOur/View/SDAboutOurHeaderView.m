//
//  SDAboutOurHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/2.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAboutOurHeaderView.h"

@implementation SDAboutOurHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
    
}

-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    self.backgroundColor = [UIColor TableViewBackGrounpColor];
    
    UIImageView *logoImageV = [[UIImageView alloc]init];
    [self addSubview:logoImageV];
    logoImageV.image = [UIImage imageNamed:@"mine_about_logo"];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(50);
        make.width.height.equalTo(@62);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    [self addSubview:lab];
    lab.text = @"安管控云平台";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor colorWithHexString:@"#3e3e3e"];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageV.mas_bottom).offset(14);
        make.centerX.equalTo(logoImageV.mas_centerX);
    }];
}




@end
