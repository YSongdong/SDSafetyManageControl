//
//  SDUserInfoTableViewCell.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserInfoTableViewCell.h"

@interface SDUserInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
//副标题
@property (weak, nonatomic) IBOutlet UILabel *subheadLab;
//右边Image'
@property (weak, nonatomic) IBOutlet UIImageView *reihtImageV;

@property (weak, nonatomic) IBOutlet UIImageView *tableViewReihtImageV;


//退出
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;
- (IBAction)leaveBtlAction:(UIButton *)sender;

@end


@implementation SDUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.reihtImageV.layer.cornerRadius = CGRectGetWidth(self.reihtImageV.frame)/2;
    self.reihtImageV.layer.masksToBounds = YES;
    
    self.leaveBtn.layer.borderWidth = 1;
    self.leaveBtn.layer.borderColor = [UIColor colorTextBlueColor].CGColor;
    self.leaveBtn.layer.cornerRadius = CGRectGetHeight(self.leaveBtn.frame)/2;
    self.leaveBtn.layer.masksToBounds = YES;
}

-(void)setDict:(NSDictionary *)dict{
    _dict =  dict;
    
    if (self.isShowPlatform) {
        if (self.indexPath.section == 2) {
            
             self.tittleLab.text = dict[@"name"];
            
            if ([dict[@"id"] isEqualToString:[SDUserInfo obtainWithPlaformID]] ) {
                self.leaveBtn.hidden= YES;
            }else{
                self.leaveBtn.hidden= NO;
            }
            
        }else{
            self.leftImageV.image = [UIImage imageNamed:dict[@"image"]];
            
            self.tittleLab.text = dict[@"name"];
            
            self.subheadLab.text = dict[@"desc"];
            
            [SDTool sd_setImageView:self.reihtImageV WithURL:dict[@"desc"]];
        }
        
    }else{
        self.leftImageV.image = [UIImage imageNamed:dict[@"image"]];

        self.tittleLab.text = dict[@"name"];

        self.subheadLab.text = dict[@"desc"];
    
        [SDTool sd_setImageView:self.reihtImageV WithURL:dict[@"desc"]];
        
    }

}

-(void)setIsShowPlatform:(BOOL)isShowPlatform{
    _isShowPlatform = isShowPlatform;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
     if (self.isShowPlatform) {
        //头像
        if (indexPath.section == 0 && indexPath.row == 0) {
            self.reihtImageV.hidden =  NO;
            self.leaveBtn.hidden = YES;
            self.subheadLab.hidden = YES;
        }else{
            self.reihtImageV.hidden =  YES;
            self.leaveBtn.hidden = YES;
        }
        
        if (indexPath.section == 1) {
            self.reihtImageV.hidden =  YES;
            self.leaveBtn.hidden = YES;
            if (indexPath.row == 0 || indexPath.row ==1) {
                self.tableViewReihtImageV.hidden = YES;
            }
           
        }
         //平台
         if (self.indexPath.section == 2) {
             self.reihtImageV.hidden = YES;
             self.tableViewReihtImageV.hidden = YES;
             self.leaveBtn.hidden = NO;
             self.leftImageV.hidden = YES;
             self.subheadLab.hidden = YES;
         }
     }else{
         //头像
         if (indexPath.section == 0 && indexPath.row == 0) {
             self.reihtImageV.hidden =  NO;
             self.leaveBtn.hidden = YES;
             self.subheadLab.hidden = YES;
         }else{
             self.reihtImageV.hidden =  YES;
             self.leaveBtn.hidden = YES;
         }
         
         if (indexPath.section == 1) {
             self.reihtImageV.hidden =  YES;
             self.leaveBtn.hidden = YES;
             if (indexPath.row == 0 || indexPath.row ==1) {
                 self.tableViewReihtImageV.hidden = YES;
             }
             
         }
     }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)leaveBtlAction:(UIButton *)sender {
    
    self.leaveBtnBlock(self.indexPath);
    
}
@end
