//
//  SDCatPlatformView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDCatPlatformView : UIView

//选中数据
@property (nonatomic,copy) void(^selectCellBlock)(NSDictionary *dict);


@end
