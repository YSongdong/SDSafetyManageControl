//
//  SDSignDetailCollectionViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSignDetailCollectionViewCell.h"


@implementation SDSignDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
    [SDTool sd_setImageView:self.coverImageV WithURL:imageUrl];
}


@end
