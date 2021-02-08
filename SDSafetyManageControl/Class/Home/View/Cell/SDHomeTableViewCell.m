//
//  SDHomeTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/25.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDHomeTableViewCell.h"

@interface SDHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bottomLineView; //底部线条

@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end


@implementation SDHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    self.leftImageV.image = [UIImage imageNamed:arr[0]];
    
    self.nameLab.text = arr[1];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
