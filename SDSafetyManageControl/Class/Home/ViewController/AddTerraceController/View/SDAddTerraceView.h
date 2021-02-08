//
//  SDAddTerraceView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAddTerraceView : UIView

//0 二维码方式    1邀请码方式
@property (nonatomic,copy) void(^selectBtnBlock)(NSInteger index);


@end
