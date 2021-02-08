//
//  AppDelegate.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "AppDelegate.h"

#import "SDLoginController.h"
#import "SDNavigationController.h"
#import "SDRootTabBarcontrolller.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //人脸识别
  //   [[FVAppSdk sharedManager] initWithAppID:@"43645806" appKey:@"d39eba36386e3034ae4cc68d0fae3c303459e85b"];
    
    //高地地图定位
    [AMapServices sharedServices].apiKey = @"9926e9a0cfc6018b5e70b944b080a154";
    
     [self setupRootView];
    
    return YES;
}
//进入程序
-(void) setupRootView{

    if ([SDUserInfo passLoginData]) {
        //否则直接进入应用
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SDRootTabBarcontrolller *custTabVC = [sb instantiateViewControllerWithIdentifier:@"SDRootTabBarcontrolller"];
        _window.rootViewController = custTabVC;

    }else{
        //登录界面
        SDLoginController *loginVC =[[SDLoginController alloc]init];
        SDNavigationController *naviVC = [[SDNavigationController alloc]initWithRootViewController:loginVC];
        _window.rootViewController = naviVC;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
