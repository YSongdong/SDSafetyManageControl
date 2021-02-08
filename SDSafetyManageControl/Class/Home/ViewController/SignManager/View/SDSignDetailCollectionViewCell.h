//
//  SDSignDetailCollectionViewCell.h
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDSignDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;
@property (nonatomic,strong) NSString *imageUrl;

@end
