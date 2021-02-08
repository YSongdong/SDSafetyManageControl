//
//  SDSignDetailController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSignDetailController.h"

#import "SDSignDetailHeaderView.h"
#import "SDTodaySignController.h"


#import "SDSignDetailCollectionViewCell.h"
#define SDSIGNDETAILCOLLECTIONVIEW_CELL  @"SDSignDetailCollectionViewCell"

#import "SDNowSignDetailCollectionCell.h"
#define SDNOWSIGNDETAILCOLLECTION_CELL  @"SDNowSignDetailCollectionCell"


@interface SDSignDetailController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
//headerView
@property (nonatomic,strong) SDSignDetailHeaderView *headerView;

@property (nonatomic,strong) UICollectionView *detaCollect;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDSignDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self createNavi];
    //创建headerVIew
    [self createHeaderView];
    //创建CollectionView
    [self createCollectionView];
    
    [self requsetSignDetaData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
}
//创建HeaderView
-(void) createHeaderView{
    self.headerView = [[SDSignDetailHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, 205)];
    [self.view addSubview:self.headerView];
    
}
//创建CollectionView
-(void) createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    
    self.detaCollect  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+CGRectGetHeight(self.headerView.frame), KScreenW, KScreenH-KSNaviTopHeight-CGRectGetHeight(self.headerView.frame)) collectionViewLayout:layout];
    [self.view addSubview:self.detaCollect];
    
    self.detaCollect.backgroundColor = [UIColor colorTextWhiteColor];
    self.detaCollect.delegate = self;
    self.detaCollect.dataSource = self;
    
    
    [self.detaCollect registerNib:[UINib nibWithNibName:SDSIGNDETAILCOLLECTIONVIEW_CELL bundle:nil] forCellWithReuseIdentifier:SDSIGNDETAILCOLLECTIONVIEW_CELL];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDSignDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDSIGNDETAILCOLLECTIONVIEW_CELL forIndexPath:indexPath];
    cell.imageUrl = self.dataArr[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KScreenW-36)/3, 113);
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1.创建photoBroseView对象
    PYPhotoBrowseView * photoBroseView = [[PYPhotoBrowseView alloc ] init ];

    // 2.1设置图片源（UIImageView）数组
    photoBroseView.imagesURL = self.dataArr;
    // 2.2设置初始化图片下标（即当前点击第几张图片）
    photoBroseView.currentIndex = indexPath.row ;

    // 3.显示（浏览）
    [photoBroseView show ];
    
}
//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"签到详情" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
    
    UIButton *updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [updateBtn setTitle:@"签到" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(selectSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rieghtItem = [[UIBarButtonItem alloc]initWithCustomView:updateBtn];
    self.navigationItem.rightBarButtonItem = rieghtItem;
}
-(void) addLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectSignBtn:(UIButton *) sender{
    
    SDTodaySignController *todayVC = [[SDTodaySignController alloc]init];
    [self.navigationController pushViewController:todayVC animated:YES];
}

#pragma mark ------数据相关-----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
}
//
-(void)requsetSignDetaData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"signInId"] = self.dict[@"SignInId"];
    param[@"ProjectId"] = self.dict[@"ProjectId"];
    param[@"type"] = @"appSignInDetail";
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_UPDATEWORK_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
      //  NSLog(@"------%@----",showdata);
       
        if (!error) {
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                [weakSelf.dataArr addObjectsFromArray:showdata[@"Photo"]];
            }
            weakSelf.headerView.timeLab.text = showdata[@"DateTime"];
            weakSelf.headerView.addressLab.text = showdata[@"PlaceName"];
            [weakSelf.detaCollect reloadData];
            
            [weakSelf.detaCollect.mj_footer endRefreshing];
            [weakSelf.detaCollect.mj_header endRefreshing];
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
        
    }];
    
    
}




@end
