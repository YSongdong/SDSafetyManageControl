//
//  SDTool.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTool.h"

@implementation SDTool

//加载网络图片
+(void)sd_setImageView:(UIImageView *)imageView WithURL:(NSString*)str{
    NSURL *url =  [NSURL URLWithString:str];
    
    [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"qdxq_ico_04"]options:SDWebImageRetryFailed];
    
}


@end
