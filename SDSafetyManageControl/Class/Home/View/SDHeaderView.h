//
//  SDHeaderView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/24.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDHeaderView : UIView

//选中热点方法
@property (nonatomic,copy) void(^hotBlock)(NSString *hotUurl);

//点击登录按钮
@property (nonatomic,copy) void(^loginBtnBlock)(void);

//取消
-(void)hiddenLogin;

//显示登录按钮
-(void) showLogin;

@end
