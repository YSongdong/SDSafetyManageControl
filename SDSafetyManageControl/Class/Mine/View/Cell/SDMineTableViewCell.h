//
//  SDMineTableViewCell.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDMineTableViewCell : UITableViewCell


//小红点view
@property (weak, nonatomic) IBOutlet UIView *samilRedView;

//去采集lab
@property (weak, nonatomic) IBOutlet UILabel *cellCollectLab;

@property (nonatomic,strong) NSArray *arr;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end
