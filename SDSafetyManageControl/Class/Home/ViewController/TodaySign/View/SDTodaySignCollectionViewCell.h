//
//  SDTodaySignCollectionViewCell.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDTodaySignCollectionViewCell : UICollectionViewCell
//封面
@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;
//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *delBtn;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) NSIndexPath *selectIndexPath;

@property (nonatomic,copy) void(^delBlock)(void);

@end
