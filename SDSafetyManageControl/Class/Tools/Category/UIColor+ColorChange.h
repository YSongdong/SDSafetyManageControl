//
//  UIColor+ColorChange.h
//  PlayDemo
//
//  Created by tiao on 2018/1/12.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)


//文字白色
+ (UIColor *) colorTextWhiteColor;

//文字蓝色
+ (UIColor *) colorTextBlueColor;

//文字3333黑色
+ (UIColor *) colorText33333BlackColor;
//线条颜色
+ (UIColor*) lineBackGrounpColor;
//table背景色
+ (UIColor *)TableViewBackGrounpColor;
//文字黑色2828
+ (UIColor *) colorText28282BlackColor;
//线条黑色f2f2
+ (UIColor *) colorLineF2f2fBlackColor;


+ (UIColor *) colorWithfdd000Color;

//导航栏背景色
+ (UIColor *) naviBackGroupColor;

//tabbar背景色
+ (UIColor*) tabBarItemTextColor;

//textfFeild背景色
+ (UIColor *)logintextFeildBackGrounpColor;

//登录按钮背景
+ (UIColor *)loginBtnBackGrounpColor;







+ (UIColor *) colorWithHexString: (NSString *)color;
@end
