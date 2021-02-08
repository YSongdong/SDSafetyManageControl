//
//  SDTodaySignCollectionViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTodaySignCollectionViewCell.h"

@interface SDTodaySignCollectionViewCell ()



@end


@implementation SDTodaySignCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    self.coverImageV.image = image;
    
}
-(void)setSelectIndexPath:(NSIndexPath *)selectIndexPath{
    _selectIndexPath = selectIndexPath;
}
//删除按钮
- (IBAction)delBtnAction:(UIButton *)sender {
    self.delBlock();
    
}


@end
