//
//  SDBaseViewController.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDBaseViewController : UIViewController

- (void)customNaviItemTitle:(NSString *)title titleColor:(UIColor *)color;


- (void)customTabBarButtonimage:(NSString *)imageName target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft;
@end
