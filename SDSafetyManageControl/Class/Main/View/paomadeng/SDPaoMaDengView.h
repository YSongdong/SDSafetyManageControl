//
//  SDPaoMaDengView.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/12.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPaoMaDengView : UIView

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame andHotArr:(NSArray*)hotArrs;

@property (nonatomic,strong) UIImageView *leftImageV;

//选中热点方法
@property (nonatomic,copy) void(^hotBlock)(NSString *hotUurl);


@end
