//
//  SDDistingDetailController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/6/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDDistingDetailController.h"

#import "SDDistingDetaHeaderView.h"
#import "SDCharaDistingController.h"

#import "SDNowSignDetailCollectionCell.h"
#define SDNOWSIGNDETAILCOLLECTION_CELL  @"SDNowSignDetailCollectionCell"
@interface SDDistingDetailController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
//headerView
@property (nonatomic,strong) SDDistingDetaHeaderView *headerView;

@property (nonatomic,strong) UICollectionView *detaCollect;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDDistingDetailController

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
    self.headerView = [[SDDistingDetaHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, 205)];
    [self.view addSubview:self.headerView];
}
//创建CollectionView
-(void) createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 0;
   
    
    self.detaCollect  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+CGRectGetHeight(self.headerView.frame), KScreenW, KScreenH-KSNaviTopHeight-CGRectGetHeight(self.headerView.frame)) collectionViewLayout:layout];
    [self.view addSubview:self.detaCollect];
    
    self.detaCollect.backgroundColor = [UIColor colorTextWhiteColor];
    self.detaCollect.delegate = self;
    self.detaCollect.dataSource = self;
    
    [self.detaCollect registerClass:[SDNowSignDetailCollectionCell class] forCellWithReuseIdentifier:SDNOWSIGNDETAILCOLLECTION_CELL];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDNowSignDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDNOWSIGNDETAILCOLLECTION_CELL forIndexPath:indexPath];
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KScreenW, 120);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"识别详情" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
    
    UIButton *updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [updateBtn setTitle:@"识别" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(selectSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rieghtItem = [[UIBarButtonItem alloc]initWithCustomView:updateBtn];
    self.navigationItem.rightBarButtonItem = rieghtItem;
}
-(void) addLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectSignBtn:(UIButton *) sender{
    SDCharaDistingController *charaVC = [[SDCharaDistingController alloc]init];
    [self.navigationController pushViewController:charaVC animated:YES];
}

#pragma mark ------数据相关-----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)setAttendanceIdStr:(NSString *)attendanceIdStr{
    _attendanceIdStr = attendanceIdStr;
}
//
-(void)requsetSignDetaData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"attendanceId"] = self.attendanceIdStr;
    param[@"projectId"] = [SDUserInfo obtainWithProjectID];
    param[@"type"] = @"appAttendanceDetail";
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_UPDATEWORK_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        //  NSLog(@"------%@----",showdata);
        
        if (!error) {
            
            if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
                [weakSelf.dataArr addObjectsFromArray:showdata[@"userInfo"]];
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
