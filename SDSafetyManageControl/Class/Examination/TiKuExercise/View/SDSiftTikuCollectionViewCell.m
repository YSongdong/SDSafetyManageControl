//
//  SDSiftTikuCollectionViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/8.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSiftTikuCollectionViewCell.h"

@implementation SDSiftTikuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnAction.layer.cornerRadius = 4;
    self.btnAction.layer.masksToBounds = YES;
}

@end
