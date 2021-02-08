//
//  SDSelectPlatformTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSelectPlatformTableViewCell.h"

@interface  SDSelectPlatformTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;

@end


@implementation SDSelectPlatformTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.titleNameLab.text = dict[@"name"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
