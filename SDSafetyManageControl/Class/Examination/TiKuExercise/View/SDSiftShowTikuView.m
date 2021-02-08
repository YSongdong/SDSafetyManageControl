//
//  SDSiftShowTikuView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/8.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSiftShowTikuView.h"

#import "SDSiftTikuCollectionViewCell.h"
#define SDSIFTTIKUCOLLECTIONVIEW_CELL  @"SDSiftTikuCollectionViewCell"
@interface SDSiftShowTikuView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) UICollectionView *siftCollectionView;

@end

@implementation SDSiftShowTikuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}
-(void) createView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(110, 33);
    layout.sectionInset = UIEdgeInsetsMake(10, 12, 10, 12);
    
    self.siftCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight) collectionViewLayout:layout];
    [self addSubview:self.siftCollectionView];
    
    self.siftCollectionView.delegate = self;
    self.siftCollectionView.dataSource = self;
    self.siftCollectionView.backgroundColor = [UIColor colorTextWhiteColor];
    
    [self.siftCollectionView registerNib:[UINib nibWithNibName:SDSIFTTIKUCOLLECTIONVIEW_CELL bundle:nil] forCellWithReuseIdentifier:SDSIFTTIKUCOLLECTIONVIEW_CELL];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SDSiftTikuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDSIFTTIKUCOLLECTIONVIEW_CELL forIndexPath:indexPath];
    return cell;
}








@end
