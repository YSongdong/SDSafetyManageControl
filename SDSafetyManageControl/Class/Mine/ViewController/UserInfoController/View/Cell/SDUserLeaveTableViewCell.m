//
//  SDUserLeaveTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserLeaveTableViewCell.h"

@interface SDUserLeaveTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;

- (IBAction)leaveBtnAction:(UIButton *)sender;

@end


@implementation SDUserLeaveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    self.leaveBtn.backgroundColor  =[UIColor colorWithHexString:@"#f6675e"];
    self.leaveBtn.layer.cornerRadius = 6;
    self.leaveBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)leaveBtnAction:(UIButton *)sender {
    //退出按钮
    self.leaveBtnBlock();
}
@end
