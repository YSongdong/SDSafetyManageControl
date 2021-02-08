//
//  SDShowSpaceView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDShowSpaceView : UIView

//按钮点击  0 回到首页  1立即添加
@property (nonatomic,copy) void(^btnBlcok)(NSInteger index);

@end
