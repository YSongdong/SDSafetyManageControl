//
//  SDBaseViewController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDBaseViewController.h"

#import "SDExaminationController.h"


@interface SDBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
   // [self reightBtn];
   // [self leftBtn];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.childViewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}

-(void) leftBtn{
    
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(selectLeftBtn:) isLeft:YES];
    
}
-(void) selectLeftBtn:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) reightBtn{
    
    UIImage *image=[UIImage imageNamed:@"btn_back_white"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(msgBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 21, 21);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
-(void)msgBtnAction:(UIButton *) sender{
    
    SDExaminationController *examVC = [[SDExaminationController alloc]init];
    [self.navigationController pushViewController:examVC animated:YES];
    
}
- (void)customNaviItemTitle:(NSString *)title titleColor:(UIColor *)color
{
    // 定制UINavigationItem的titleView
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor =color;
    // 设置文字
    titleLabel.text = title;
    
    // 设置导航项的标题视图
    self.navigationItem.titleView = titleLabel;
}

- (void)customTabBarButtonimage:(NSString *)imageName target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft
{
    UIImage *image=[UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    UIImageView *imageView =[[UIImageView alloc]initWithImage:image];
    //    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:image forState:UIControlStateNormal];
    // [button setBackgroundImage:imageView.image forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    // 判断是否为左侧按钮
    UIBarButtonItem * buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = buttonItem;
    }
}


@end
