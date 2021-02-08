//
//  HWScanViewController.h
//  HWScanTest
//
//  Created by sxmaps_w on 2017/2/18.
//  Copyright © 2017年 hero_wqb. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDBaseViewController.h"
@interface HWScanViewController : SDBaseViewController

//确定按钮
@property (nonatomic,copy) void(^tureBtnBlock)(NSString *code);

@end
