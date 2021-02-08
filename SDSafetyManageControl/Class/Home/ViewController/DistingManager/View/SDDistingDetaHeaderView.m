//
//  SDDistingDetaHeaderView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/6/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDDistingDetaHeaderView.h"

@implementation SDDistingDetaHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void) createView{
    
    __weak typeof(self) weakSelf = self;
    
    self.backgroundColor = [UIColor colorLineF2f2fBlackColor];
    
    NSArray *imageArr= @[@"qdxq_ico_01",@"qdxq_ico_02",@"xq_ico_rwbb"];
    NSArray *nameArr = @[@"辨别时间",@"辨别地点",@"人物辨别"];
    
    for (int i=0; i< 3; i++) {
        UIView *timeView = [[UIView alloc]init];
        [self addSubview:timeView];
        timeView.backgroundColor =[UIColor colorTextWhiteColor];
        [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(((i+1)*10)+i*60);
            make.left.right.equalTo(weakSelf);
            make.height.equalTo(@60);
            make.centerX.equalTo(weakSelf.mas_centerX);
        }];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        [timeView addSubview:imageV];
        imageV.image = [UIImage imageNamed:imageArr[i]];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(timeView).offset(12);
            make.centerY.equalTo(timeView.mas_centerY);
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        [timeView addSubview:lab];
        lab.text = nameArr[i];
        lab.tag = 100+i;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:16];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).offset(10);
            make.centerY.equalTo(imageV.mas_centerY);
        }];
        
        if (i==0) {
            self.timeLab = [[UILabel alloc]init];
            [timeView addSubview:self.timeLab];
            self.timeLab.text = @"2018-05-08 19:39:00";
            self.timeLab.textColor = [UIColor colorWithHexString:@"#656565"];
            self.timeLab.font = [UIFont systemFontOfSize:15];
            [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(timeView).offset(-10);
                make.centerY.equalTo(timeView.mas_centerY);
            }];
        }else if (i ==1){
            self.addressLab = [[UILabel alloc]init];
            [timeView addSubview:self.addressLab];
            self.addressLab.text = @"科城一路";
            self.addressLab.numberOfLines = 2;
            self.addressLab.textColor = [UIColor colorWithHexString:@"#656565"];
            self.addressLab.font = [UIFont systemFontOfSize:15];
            
            UILabel *addreesLab =  [self viewWithTag:101];
            [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(timeView).offset(-10);
                make.left.equalTo(addreesLab.mas_right).offset(10);
                make.centerY.equalTo(timeView.mas_centerY);
            }];
            
        }
        
    }
    
}




@end
