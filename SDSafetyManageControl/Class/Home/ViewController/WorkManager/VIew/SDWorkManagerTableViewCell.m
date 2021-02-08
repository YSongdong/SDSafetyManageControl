//
//  SDWorkManagerTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDWorkManagerTableViewCell.h"


@interface  SDWorkManagerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *mouthLab;

@property (weak, nonatomic) IBOutlet UILabel *dayLab;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;

@end


@implementation SDWorkManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    self.timeLab.text  = dict[@"Time"];
    
    self.mouthLab.text = [NSString stringWithFormat:@"%@月",dict[@"Mouth"]];
    
     self.dayLab.text = dict[@"Day"];
    
    [SDTool sd_setImageView:self.coverImageV WithURL:dict[@"Cover"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
