//
//  SDPhotoCollectController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDPhotoCollectController.h"
#import "SDPhotoView.h"


@interface SDPhotoCollectController ()

@property (nonatomic,strong) SDPhotoView *photoView;

@end

@implementation SDPhotoCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    //设置Navi
    [self createNavi];
    //设置ui
    [self createPhotoView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
    
}

//设置Navi
-(void) createNavi{
    
    [self customNaviItemTitle:@"照片采集" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(photoLeftBtn:) isLeft:YES];
}
-(void)photoLeftBtn:(UIButton *) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setPhotoDict:(NSDictionary *)photoDict{
    _photoDict = photoDict;
}

#pragma mark ----  创建UI
//创建UI
-(void)createPhotoView{
    self.photoView = [[SDPhotoView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH - KSNaviTopHeight)];
    [self.view addSubview:self.photoView];
    
    self.photoView.photoDict = self.photoDict;
    
    //跳过按钮
    self.photoView.passBlock = ^{
        
    };
    //采集按钮
    self.photoView.collectBlock = ^(UIButton *btn) {
        
    };
    //上传按钮
    self.photoView.updateBlock = ^(UIButton *btn) {
        
    };
}


@end
