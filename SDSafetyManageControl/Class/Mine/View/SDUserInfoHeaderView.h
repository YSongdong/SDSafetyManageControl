//
//  SDUserInfoHeaderView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/26.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDUserInfoHeaderView : UIView

//登录
@property (nonatomic,copy) void(^loginBlock)(void);

//进入用户信息
@property (nonatomic,copy) void(^userInfoBlock)(void);

-(void) loginInfo:(NSDictionary *)dict;

@end
