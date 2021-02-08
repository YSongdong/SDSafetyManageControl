//
//  SDNaviTitleView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/23.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDNaviTitleView.h"

@interface SDNaviTitleView ()

@property (nonatomic,strong) UIButton *btn;
@end

@implementation SDNaviTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initTitleView];
    }
    return self;
}
//创建view
-(void) initTitleView{
    
    __weak typeof(self) weakSelf = self;
    self.btn = [[UIButton alloc]init];
    [self addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.btn addTarget:self action:@selector(selectdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    UIImageView *imageV = [[UIImageView alloc]init];
    [self addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"home_nav_xl"];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.btn.mas_right);
        make.centerY.equalTo(weakSelf.btn.mas_centerY);
    }];
    imageV.tag = 300;
    
    self.nameLab  = [[UILabel alloc]init];
    [self addSubview:_nameLab];
    _nameLab.textColor = [UIColor whiteColor];
    _nameLab.text = @"请先添加平台";
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.btn.mas_left);
        make.centerY.equalTo(weakSelf.btn.mas_centerY);
        make.right.equalTo(imageV.mas_left).offset(-8);
    }];
    
    
    
}
-(void)selectdBtnAction:(UIButton *) sender{
    sender.selected = !sender.selected;
    
    UIImageView *imageV = [self viewWithTag:300];
    
    if (sender.selected) {
        imageV.image = [UIImage imageNamed:@"home_nav_sq"];
    }else{
        imageV.image = [UIImage imageNamed:@"home_nav_xl"];
    }
    self.cutBlock(sender);
    
}

-(void)closePlatformView{
    [self selectdBtnAction:self.btn];
}


@end
