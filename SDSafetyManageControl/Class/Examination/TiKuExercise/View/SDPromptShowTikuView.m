//
//  SDPromptShowTikuView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/8.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDPromptShowTikuView.h"

@implementation SDPromptShowTikuView

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
    bgView.alpha = 0.35;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTap)];
    [bgView addGestureRecognizer:tap];
    
    
    UIView *samilView = [[UIView alloc]init];
    [self addSubview:samilView];
    samilView.backgroundColor = [UIColor colorTextWhiteColor];
    [samilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@160);
        make.left.equalTo(weakSelf).offset(65);
        make.right.equalTo(weakSelf).offset(-65);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    samilView.layer.cornerRadius = 15;
    samilView.layer.masksToBounds = YES;
    
    
    UILabel *promptLab = [[UILabel alloc]init];
    [samilView addSubview:promptLab];
    promptLab.text = @"提示弹框";
    promptLab.font = [UIFont systemFontOfSize:17];
    promptLab.textColor = [UIColor colorText28282BlackColor];
    [promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(samilView).offset(13);
        make.centerX.equalTo(samilView.mas_centerX);
    }];
    
    UIView *pLineView = [[UIView alloc]init];
    [samilView addSubview:pLineView];
    pLineView.backgroundColor = [UIColor colorLineF2f2fBlackColor];
    [pLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(samilView);
        make.height.equalTo(@1);
        make.centerX.equalTo(samilView.mas_centerX);
    }];
    
     //按钮上面的线
    UIView *bLineView = [[UIView alloc]init];
    [samilView addSubview:bLineView];
    bLineView.backgroundColor = [UIColor colorLineF2f2fBlackColor];
    [bLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(pLineView);
        make.bottom.equalTo(samilView.mas_bottom).offset(-45);
        make.centerX.equalTo(samilView.mas_centerX);
    }];
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [samilView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bLineView.mas_bottom);
        make.left.bottom.equalTo(samilView);
    }];
    [cancelBtn addTarget:self action:@selector(selectCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //确认按钮
    UIButton *trueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [samilView addSubview:trueBtn];
    [trueBtn setTitle:@"确认" forState:UIControlStateNormal];
    [trueBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    trueBtn.backgroundColor = [UIColor colorTextWhiteColor];
    [trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancelBtn.mas_right);
        make.right.equalTo(samilView);
        make.width.height.equalTo(cancelBtn);
        make.centerY.equalTo(cancelBtn.mas_centerY);
    }];
    
    //提示内容
    UILabel *contentLab = [[UILabel alloc]init];
    [samilView addSubview:contentLab];
    contentLab.font = [UIFont systemFontOfSize:14];
    contentLab.numberOfLines = 0;
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pLineView.mas_bottom).offset(12);
        make.left.equalTo(samilView).offset(20);
        make.right.equalTo(samilView).offset(-20);
        make.bottom.equalTo(bLineView.mas_top).offset(-5);
    }];
    //调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距

    NSMutableAttributedString * attribut = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您已完整学习该题库,正确%d题，错误%d题，您是否需要清空做题记录再次练习",87,13]];
    
    //设置字体不同的颜色
    [attribut addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#00c35o"] range:NSMakeRange(12, 2)];
    [attribut addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff3030"] range:NSMakeRange(18, 2)];
    //设置字体大小
    [attribut addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(12, 2)];
    [attribut addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(18, 2)];
    
    contentLab.attributedText =attribut;
}

-(void)selectTap{
    [self removeFromSuperview];
}

-(void)selectCancelBtn:(UIButton *) sender{
    
    [self selectTap];
}


@end
