//
//  SDPhotoView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDPhotoView.h"

@interface SDPhotoView ()
@property (nonatomic,strong) UILabel *nameLab;
//跳过按钮
@property (nonatomic,strong) UIButton *passBtn;
//图片
@property (nonatomic,strong) UIImageView *domeImageV;
//标签
@property (nonatomic,strong) UIImageView *checkImageV;
//失败原因
@property (nonatomic,strong) UILabel *errorLab;

//说明文字
@property (nonatomic,strong) UILabel *promptLab;
@property (nonatomic,strong) UILabel *markLab;
//采集按钮
@property (nonatomic,strong) UIButton *collectBtn;
//上传按钮
@property (nonatomic,strong) UIButton *updataBtn;

@end


@implementation SDPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initPhotoUI];
    }
    return self;
    
}
//创建UI
-(void) initPhotoUI{
    
    __weak typeof(self) weakSelf = self;
    
    UIView *photoView = [[UIView alloc]init];
    [self addSubview:photoView];
    photoView.backgroundColor =[UIColor colorWithHexString:@"#f3f6f8"];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@297);
    }];
    
    self.passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoView addSubview:self.passBtn];
    
    self.domeImageV = [[UIImageView alloc]init];
    [photoView addSubview:self.domeImageV];
    
    self.checkImageV = [[UIImageView alloc]init];
    [photoView addSubview:self.checkImageV];
    
    self.nameLab = [[UILabel alloc]init];
    [photoView addSubview:self.nameLab];
    
    self.errorLab = [[UILabel alloc]init];
    [photoView addSubview:self.errorLab];
    
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoView.mas_bottom);
        make.left.with.equalTo(photoView);
        make.bottom.equalTo(weakSelf);
        make.centerX.equalTo(photoView.mas_centerX);
    }];
    
    self.promptLab = [[UILabel alloc]init];
    [bgView addSubview:self.promptLab];
    
    self.markLab = [[UILabel alloc]init];
    [bgView addSubview:self.markLab];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.self.collectBtn];
    
    self.updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:self.updataBtn];

    //文字说明
    self.nameLab.font = [UIFont systemFontOfSize:16];
    self.nameLab.textColor = [UIColor blackColor];
    self.nameLab.text = @"用户照片采集";
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(29);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    self.nameLab.hidden = YES;
    
    //跳过按钮
    [self.passBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [self.passBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.right.equalTo(weakSelf).offset(-10);
        make.centerY.equalTo(weakSelf.nameLab.mas_centerY);
    }];
    self.passBtn.layer.cornerRadius = 3;
    self.passBtn.layer.masksToBounds = YES;
    self.passBtn.layer.borderWidth = 1;
    self.passBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.passBtn addTarget:self action:@selector(selectdPassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.passBtn.hidden = YES;
    
    //示例图片
    self.domeImageV.image = [UIImage imageNamed:@"mine_photo_default"];
    [self.domeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passBtn.mas_bottom).offset(30);
        make.width.height.equalTo(@183);
        make.centerX.equalTo(photoView.mas_centerX);
    }];
    
    self.checkImageV.image = [UIImage imageNamed:@"mine_photo_audit"];
    [self.checkImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakSelf.domeImageV);
    }];
    
    //失败提示
    self.errorLab.textColor = [UIColor colorWithHexString:@"#6f6f6f"];
    self.errorLab.font = [UIFont systemFontOfSize:12];
    [self.errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.domeImageV.mas_bottom).offset(13);
        make.centerX.equalTo(weakSelf.domeImageV.mas_centerX);
    }];
    self.errorLab.text = @"失败原因：用户照片上传不清晰";
    self.errorLab.hidden = YES;
    
    //文字说明
    self.promptLab.font = [UIFont systemFontOfSize:14];
    self.promptLab.textColor = [UIColor  colorWithHexString:@"#353535"];
    self.promptLab.text = @"图片说明";
    [self.promptLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgView).offset(20);
    }];
    
    self.markLab.font = [UIFont systemFontOfSize:12];
    self.markLab.textColor = [UIColor colorWithHexString:@"#6f6f6f"];
    self.markLab.numberOfLines = 0;
    self.markLab.text = @"1.请按示例图片要求上传您的留底照片。\n2.该照片将应用于系统考试、考勤签到等重要场景进行身份验证不可随意修改。\n3.请确保照片清晰有效，谨慎上传。";
    [self.markLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptLab.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.promptLab);
        make.right.equalTo(bgView).offset(-20);
        make.centerX.equalTo(bgView.mas_centerX);
    }];

    //采集按钮
    [self.collectBtn setTitle:@"开始采集" forState:UIControlStateNormal];
    [self.collectBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    self.collectBtn.backgroundColor = [UIColor colorTextBlueColor];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.markLab.mas_bottom).offset(42);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.centerX.equalTo(weakSelf.markLab.mas_centerX);
    }];
    self.collectBtn.layer.cornerRadius = 5;
    self.collectBtn.layer.masksToBounds = YES;
    [self.collectBtn addTarget:self action:@selector(selectCollectBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    //上传
    [self.updataBtn setTitle:@"立即上传" forState:UIControlStateNormal];
    [self.updataBtn setTitleColor:[UIColor colorTextBlueColor] forState:UIControlStateNormal];
    [self.updataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collectBtn.mas_bottom).offset(27);
        make.width.height.equalTo(weakSelf.collectBtn);
        make.left.equalTo(weakSelf.collectBtn);
        make.centerX.equalTo(weakSelf.collectBtn.mas_centerX);
    }];
    self.updataBtn.layer.cornerRadius = 5;
    self.updataBtn.layer.masksToBounds = YES;
    self.updataBtn.layer.borderWidth = 1;
    self.updataBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
    [self.updataBtn addTarget:self action:@selector(selectUpdateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setPhotoDict:(NSDictionary *)photoDict{
    _photoDict = photoDict;
    
    //判断状态
    NSString *vfaceSrt = photoDict[@"vface"];
    
    if ([vfaceSrt integerValue] == 0 || [vfaceSrt integerValue] == 4) {
        // 未审核
        //隐藏审核状态
        self.checkImageV.hidden = YES;
        self.collectBtn.hidden =NO;
        self.updataBtn.hidden = NO;
        self.nameLab.hidden = YES;
        
    }else if ([vfaceSrt integerValue] == 1){
        // 审核失败
        self.checkImageV.hidden = NO;
        self.checkImageV.image = [UIImage imageNamed:@"mine_photo_not"];
        self.collectBtn.hidden =NO;
        self.updataBtn.hidden = NO;
        self.nameLab.hidden = NO;
        
        
    }else if ([vfaceSrt integerValue] == 2){
        
        // 审核通过
        self.checkImageV.hidden = NO;
        self.checkImageV.image = [UIImage imageNamed:@"mine_photo_pass"];
        self.collectBtn.hidden =YES;
        self.updataBtn.hidden = YES;
        self.nameLab.hidden = NO;
        
    }else{
       // 3审核中
        self.checkImageV.hidden = NO;
        self.checkImageV.image = [UIImage imageNamed:@"mine_photo_audit"];
        self.collectBtn.hidden =YES;
        self.updataBtn.hidden = YES;
        self.nameLab.hidden = NO;
        
    }

}
#pragma mark --- 按钮点击方法 ----
//跳过按钮
-(void)selectdPassBtnAction:(UIButton *) sender{
    self.passBlock();
}
//开始采集
-(void)selectCollectBtnAction:(UIButton *) sender{
    self.collectBlock(sender);
}
-(void)selectUpdateBtnAction:(UIButton *) sender{
    self.updateBlock(sender);
}


@end
