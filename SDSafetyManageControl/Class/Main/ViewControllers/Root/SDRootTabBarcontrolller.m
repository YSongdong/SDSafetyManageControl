//
//  SDRootTabBarcontrolller.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDRootTabBarcontrolller.h"

@interface SDRootTabBarcontrolller ()

@end

@implementation SDRootTabBarcontrolller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNaviBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义UINavigationBar
-(void) customNaviBar{
    //获取所有的导航控制器
    NSArray *naviControllers=self.viewControllers;
    for (UINavigationController *navi in naviControllers) {
        //获取UINavigationBar
        UINavigationBar *naviBar=navi.navigationBar;
        
     //   [naviBar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forBarMetrics:UIBarMetricsDefault];
        
       [naviBar setBarTintColor:[UIColor  naviBackGroupColor]];

    }
}

@end
