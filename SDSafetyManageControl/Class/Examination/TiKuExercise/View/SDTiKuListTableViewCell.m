//
//  SDTiKuListTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTiKuListTableViewCell.h"

@interface SDTiKuListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//题数
@property (weak, nonatomic) IBOutlet UILabel *numberTiLab;
//时间
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
//进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
//显示进度条lab
@property (weak, nonatomic) IBOutlet UILabel *showProgressLab;

@end


@implementation SDTiKuListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    self.continueBtn.layer.cornerRadius = CGRectGetHeight(self.continueBtn.frame)/2;
    self.continueBtn.layer.masksToBounds = YES;
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//继续学习按钮
- (IBAction)continueBtnAction:(UIButton *)sender {
}
//我的收藏
- (IBAction)collectBtnAction:(UIButton *)sender {
}
//错题练习
- (IBAction)unExerciseAction:(UIButton *)sender {
}
//专项训练
- (IBAction)trainBtnAction:(UIButton *)sender {
}


@end
