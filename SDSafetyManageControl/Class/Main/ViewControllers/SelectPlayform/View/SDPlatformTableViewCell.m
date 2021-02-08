//
//  SDPlatformTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//



#import "SDPlatformTableViewCell.h"


@interface SDPlatformTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *platformView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation SDPlatformTableViewCell




- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    self.platformView.layer.cornerRadius = CGRectGetWidth(self.platformView.frame)/2;
    self.platformView.layer.masksToBounds = YES;
    
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.titleLab.text = dict[@"name"];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
