//
//  SDSignManagerTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSignManagerTableViewCell.h"

@interface  SDSignManagerTableViewCell ()
//日
@property (weak, nonatomic) IBOutlet UILabel *dLab;
//月
@property (weak, nonatomic) IBOutlet UILabel *yLab;
//封面
@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end


@implementation SDSignManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDict:(NSDictionary *)dict{
    _dict= dict;
    
    self.dLab.text = dict[@"Day"];
    
    self.yLab.text = [NSString stringWithFormat:@"%@月",dict[@"Mouth"]];
    
    self.titleLab.text =  dict[@"GpsLocal"];
    
    self.timeLab.text =  dict[@"Time"];
    
    [SDTool sd_setImageView:self.coverImageV WithURL:dict[@"Cover"]];
}



@end
