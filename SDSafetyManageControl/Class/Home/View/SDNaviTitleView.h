//
//  SDNaviTitleView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/23.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDNaviTitleView : UIView

//名称
@property (nonatomic,strong) UILabel *nameLab;

@property (nonatomic,copy) void(^cutBlock)(UIButton *btn);

//关闭平台view
-(void) closePlatformView;

@end
