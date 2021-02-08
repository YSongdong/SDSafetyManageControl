//
//  SDPhotoCollectController.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDBaseViewController.h"
@interface SDPhotoCollectController : SDBaseViewController

 //留底状态 0未审核 1审核失败 2审核通过 3审核中4没有留底'
@property (nonatomic,strong) NSDictionary  *photoDict;


@end
