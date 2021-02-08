//
//  SDMineTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDMineTableViewCell.h"

@interface SDMineTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *tittleLab;

@end



@implementation SDMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.samilRedView.layer.cornerRadius = CGRectGetWidth(self.samilRedView.frame)/2;
    self.samilRedView.layer.masksToBounds = YES;
    
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    
    self.leftImageV.image = [UIImage imageNamed:arr[0]];
    
    self.tittleLab.text = arr[1];
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        self.samilRedView.hidden = NO;
        self.cellCollectLab.hidden = NO;
    }else{
        self.samilRedView.hidden = YES;
        self.cellCollectLab.hidden = YES;
    }
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
