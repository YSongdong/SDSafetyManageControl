//
//  SDNowSignDetailCollectionCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/6/26.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDNowSignDetailCollectionCell.h"

@interface SDNowSignDetailCollectionCell ()
//封面
@property (nonatomic,strong) UIImageView *coverImageV;

@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,strong) UILabel *idCardLab;

@property (nonatomic,strong) UILabel *workLab;

@property (nonatomic,strong) UILabel *projectLab;

@property (nonatomic,strong) UILabel *workTypeLab;

@end

@implementation SDNowSignDetailCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       [self createCellView];
    }
    return self;
}

-(void)createCellView{
    __weak typeof(self) weakSelf = self;
    self.coverImageV =[[ UIImageView alloc]init];
    [self addSubview:self.coverImageV];
    self.coverImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.coverImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@111);
        make.top.equalTo(weakSelf).offset(0);
        make.left.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-20);
    }];
    
    UILabel *showNameLab = [[UILabel alloc]init];
    [self addSubview:showNameLab];
    showNameLab.text = @"姓名";
    showNameLab.tag = 200;
    showNameLab.font =[UIFont systemFontOfSize:12];
    showNameLab.textColor =[UIColor colorText28282BlackColor];
    [showNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageV.mas_top).offset(3);
        make.left.equalTo(weakSelf.coverImageV.mas_right).offset(10);
    }];
    
    self.nameLab = [[UILabel alloc]init];
    [self addSubview:self.nameLab];
    self.nameLab.font = [UIFont systemFontOfSize:12];
    self.nameLab.text = @"";
    self.nameLab.textColor = [UIColor colorWithHexString:@"#656565"];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-12);
        make.centerY.equalTo(showNameLab.mas_centerY);
    }];
  
    UILabel *showIdCardLab = [[UILabel alloc]init];
    [self addSubview:showIdCardLab];
    showIdCardLab.font =[UIFont systemFontOfSize:12];
    showIdCardLab.textColor =[UIColor colorText28282BlackColor];
    showIdCardLab.text = @"身份证";
    showIdCardLab.tag = 201;
    [showIdCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showNameLab.mas_bottom).offset(11);
        make.left.equalTo(showNameLab.mas_left);
    }];
    
    self.idCardLab = [[UILabel alloc]init];
    [self addSubview:self.idCardLab];
    self.idCardLab.text = @"";
    self.idCardLab.font = [UIFont systemFontOfSize:12];
    self.idCardLab.textColor = [UIColor colorWithHexString:@"#656565"];
    [self.idCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.nameLab.mas_right);
        make.centerY.equalTo(showIdCardLab.mas_centerY);
    }];
    
    UILabel *showWorkLab =[[UILabel alloc]init];
    [self addSubview:showWorkLab];
    showWorkLab.font =[UIFont systemFontOfSize:12];
    showWorkLab.textColor =[UIColor colorText28282BlackColor];
    showWorkLab.text = @"工作单位";
    showWorkLab.tag = 202;
    [showWorkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showIdCardLab.mas_bottom).offset(11);
        make.left.equalTo(showIdCardLab.mas_left);
    }];
    
    self.workLab = [[UILabel alloc]init];
    [self addSubview:self.workLab];
    self.workLab.text = @"";
    self.workLab.font = [UIFont systemFontOfSize:12];
    self.workLab.textColor = [UIColor colorWithHexString:@"#656565"];
    [self.workLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.idCardLab.mas_right);
        make.centerY.equalTo(showWorkLab.mas_centerY);
    }];
    
    UILabel *showProLab = [[UILabel alloc]init];
    [self addSubview:showProLab];
    showProLab.font =[UIFont systemFontOfSize:12];
    showProLab.textColor =[UIColor colorText28282BlackColor];
    showProLab.text = @"所属项目";
    showProLab.tag = 203;
    [showProLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showWorkLab.mas_bottom).offset(11);
        make.left.equalTo(showWorkLab.mas_left);
    }];
    
    self.projectLab  = [[ UILabel alloc]init];
    [self addSubview:self.projectLab];
    self.projectLab.text = @"";
    self.projectLab.font = [UIFont systemFontOfSize:12];
    self.projectLab.textColor = [UIColor colorWithHexString:@"#656565"];
    [self.projectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.workLab.mas_right);
        make.centerY.equalTo(showProLab.mas_centerY);
    }];
    
    UILabel *showWorkTypeLab  = [[ UILabel alloc]init];
    [self addSubview:showWorkTypeLab];
    showWorkTypeLab.font =[UIFont systemFontOfSize:12];
    showWorkTypeLab.textColor =[UIColor colorText28282BlackColor];
    showWorkTypeLab.text = @"工作岗位";
    showWorkTypeLab.tag = 204;
    [showWorkTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showProLab.mas_bottom).offset(11);
        make.left.equalTo(showProLab.mas_left);
    }];
    
    self.workTypeLab = [[UILabel alloc]init];
    [self addSubview:self.workTypeLab];
    self.workTypeLab.text = @"";
    self.workTypeLab.font = [UIFont systemFontOfSize:12];
    self.workTypeLab.textColor = [UIColor colorWithHexString:@"#656565"];
    [self.workTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.projectLab.mas_right);
        make.centerY.equalTo(showWorkTypeLab.mas_centerY);
    }];
    
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    //有辨别
    NSString *indexStr =  [NSString stringWithFormat:@"%@",dict[@"is_p"]];
    if ([indexStr isEqualToString:@"1"]) {
        NSString *urlStr = dict[@"Photo"];
        NSURL *url =  [NSURL URLWithString:urlStr];
        [self.coverImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"xq_bg"]options:SDWebImageRetryFailed];
       //姓名
        self.nameLab.text = dict[@"FullName"];
        
        self.idCardLab.text = dict[@"IdCard"];
        
        self.workLab.text = dict[@"CompanyName"];
        
        self.projectLab.text = dict[@"ProjectName"];
        
        self.workTypeLab.text = dict[@"PositionName"];
        
    }else{
        NSString *urlStr = dict[@"Photo"];
        NSURL *url =  [NSURL URLWithString:urlStr];
        [self.coverImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"xq_bg"]options:SDWebImageRetryFailed];
        
        for (int i=0; i<5; i++) {
            if (i==0) {
                UILabel *lab = [self viewWithTag:(200+i)];
                lab.text = @"人员未知";
            }else{
                UILabel *lab = [self viewWithTag:(200+i)];
                lab.hidden = YES;
            }
        }
        self.nameLab.hidden = YES;
        self.idCardLab.hidden = YES;
        self.workLab.hidden = YES;
        self.projectLab.hidden = YES;
        self.workTypeLab.hidden = YES;
        
        
    }

}





@end
