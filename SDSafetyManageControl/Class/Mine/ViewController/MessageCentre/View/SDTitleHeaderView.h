//
//  SDTitleHeaderView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDTitleHeaderView : UIView

//判断是选择平台通知还是重要通知  YES  平台通知  NO 重要通知
@property (nonatomic,copy) void(^selectdNotifBlock)(BOOL isPlatform);


@end
