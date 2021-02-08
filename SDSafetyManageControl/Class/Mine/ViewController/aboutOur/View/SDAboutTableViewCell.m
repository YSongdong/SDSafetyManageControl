//
//  SDAboutTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/2.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAboutTableViewCell.h"

@interface SDAboutTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end



@implementation SDAboutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNameStr:(NSString *)nameStr{
    _nameStr = nameStr;
    self.nameLab.text = nameStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
