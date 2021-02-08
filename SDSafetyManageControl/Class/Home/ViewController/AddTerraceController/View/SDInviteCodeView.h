//
//  SDInviteCodeView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDInviteCodeView : UIView

//输入框
@property (nonatomic,strong) UITextField *inviteTF;

//确定按钮
@property (nonatomic,copy) void(^tureBtnBlock)(NSString *code);


@end
