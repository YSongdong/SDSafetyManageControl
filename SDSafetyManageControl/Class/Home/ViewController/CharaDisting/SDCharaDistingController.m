//
//  SDCharaDistingController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/6/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDCharaDistingController.h"
#import "SDDistingDetailController.h"
#import "LWImageBrowser.h"

#import "SDTodaySignCollectionViewCell.h"
#define SDTODAYSIGNCOLLECtONA_CELL  @"SDTodaySignCollectionViewCell"
@interface SDCharaDistingController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
AMapLocationManagerDelegate
>
@property (nonatomic,strong) UICollectionView *todayCollect;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong)  AMapLocationManager*locationManager;

@property (nonatomic,strong) UILabel *addressLab;

@property (nonatomic,strong) NSMutableDictionary *latiteDict;

@end

@implementation SDCharaDistingController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化1个数据
    UIImage *image = [UIImage imageNamed:@"sc_ico_add"];
    [self.dataArr addObject:image];
    //设置导航栏
    [self createNavi];
    //创建ColletionView
    [self createCollectionView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
    //开启地位
    [self mobilePhonePositioning];
}
//创建ColletionView
-(void) createCollectionView{
    
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
    
    self.todayCollect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight) collectionViewLayout:layout];
    [self.view addSubview:self.todayCollect];
    
    self.todayCollect.delegate = self;
    self.todayCollect.dataSource = self;
    self.todayCollect.backgroundColor = [UIColor colorTextWhiteColor];
    
    [self.todayCollect registerNib:[UINib nibWithNibName:SDTODAYSIGNCOLLECtONA_CELL bundle:nil] forCellWithReuseIdentifier:SDTODAYSIGNCOLLECtONA_CELL];
    
    [self.todayCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER"];
    [self.todayCollect registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER"];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SDTodaySignCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SDTODAYSIGNCOLLECtONA_CELL forIndexPath:indexPath];
    //    if (indexPath.row != self.dataArr.count-1) {
    //        cell.delBtn.hidden = NO;
    //    }else{
    cell.delBtn.hidden = YES;
    //    }
    cell.selectIndexPath = indexPath;
    cell.image = self.dataArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.delBlock = ^{
        //删除cell
       // [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
        UIImage *image = [UIImage imageNamed:@"sc_ico_add"];
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:image];
        [weakSelf.todayCollect reloadData];
    };
    return cell;
}
#pragma mark  ------选择单元格------
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.dataArr.count-1) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = NO;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        
        //移除最后一个元素
        [self.dataArr removeObject:[self.dataArr lastObject]];
        
        // 1.创建photoBroseView对象
        PYPhotoBrowseView * photoBroseView = [[PYPhotoBrowseView alloc ] init ];
        // 2.1设置图片源（UIImageView）数组
        photoBroseView.images = self.dataArr;
        // 2.2设置初始化图片下标（即当前点击第几张图片）
        photoBroseView.currentIndex = indexPath.row ;
        // 3.显示（浏览）
        [photoBroseView show ];
        
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KScreenW-36)/3, 113);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, 60);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(KScreenW, 100);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FOOTER" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor colorTextWhiteColor];
        
        UIView *bgView = [[UIView alloc]init];
        [footer addSubview:bgView];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footer).offset(12);
            make.right.equalTo(footer).offset(-12);
            make.bottom.equalTo(footer);
            make.height.equalTo(@30);
            make.centerX.equalTo(footer.mas_centerX);
        }];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        [bgView addSubview:imageV];
        imageV.image = [UIImage imageNamed:@"qdlb_ico"];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView).offset(12);
            make.centerY.equalTo(bgView.mas_centerY);
        }];
        
        self.addressLab = [[UILabel alloc]init];
        [bgView addSubview:self.addressLab];
        self.addressLab.text = @"";
        self.addressLab.textColor = [UIColor colorText28282BlackColor];
        self.addressLab.font = [UIFont systemFontOfSize:13];
        [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageV.mas_right).offset(5);
            make.centerY.equalTo(imageV.mas_centerY);
        }];
        return footer;
    } else {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
        header.backgroundColor = [UIColor colorTextWhiteColor];
        return header;
    }
}
#pragma mark -----拍照照片处理----
// 选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.dataArr replaceObjectAtIndex:0 withObject:image];

    //刷新
    [self.todayCollect reloadData];
    return;
}
#pragma mark -----设置导航栏----
-(void)createNavi{
    [self customNaviItemTitle:@"识别" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
    
    UIButton *updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [updateBtn setTitle:@"上传" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(selectUpdataBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rieghtItem = [[UIBarButtonItem alloc]initWithCustomView:updateBtn];
    self.navigationItem.rightBarButtonItem = rieghtItem;
}
-(void) addLeftBtn:(UIButton *)sender{
    //
    //    if (self.dataArr.count > 1) {
    //
    //        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你确定要退出今日签到吗?" preferredStyle:UIAlertControllerStyleAlert];
    //
    //        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //            [self dismissViewControllerAnimated:YES completion:nil];
    //        }]];
    //        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //            [self dismissViewControllerAnimated:YES completion:nil];
    //        }]];
    //
    //        [self presentViewController:alertVC animated:YES completion:nil];
    //    }else{
    //
    //       [self.navigationController popViewControllerAnimated:YES];
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}
//上传
-(void)selectUpdataBtn:(UIButton *) sender{
    
    //获取定位信息
    if (self.addressLab.text.length == 0) {
        [SVProgressHUD  showErrorWithStatus:@"正在获取GPS定位信息"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    
    if (self.dataArr.count < 1) {
        [SVProgressHUD  showErrorWithStatus:@"请上传照片"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    
    //移除最后一个元素
 //   [self.dataArr removeObject:[self.dataArr lastObject]];
    
    //上传工作票
    [self requsetTestCodeImage];
}
///压缩图片
- (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}

#pragma mark --------定位相关---------
// 手机定位你当前的位置，并获得你位置的信息
- (void)mobilePhonePositioning{
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    [AMapServices sharedServices].apiKey =@"9926e9a0cfc6018b5e70b944b080a154";
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    _locationManager.locationTimeout =5;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    _locationManager.reGeocodeTimeout = 5;
    
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {//判断该软件是否开启定位
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"打开定位开关" message:@"系统设置”->“隐私”->“定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        //        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //            [self dismissViewControllerAnimated:YES completion:nil];
        //        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
        [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (regeocode)
            {
                self.addressLab.text = regeocode.formattedAddress;
            }
            
            if (location) {
                //维度
                self.latiteDict[@"latitude"]=[NSString stringWithFormat:@"%f",location.coordinate.latitude];
                self.latiteDict[@"longitude"]=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
            }
        }];
    }
}
///压缩图片
+ (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}
#pragma mark -----数据相关----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}
-(NSMutableDictionary *)latiteDict{
    if (!_latiteDict) {
        _latiteDict = [NSMutableDictionary dictionary];
    }
    return _latiteDict;
}
//上传签到
-(void)requsetTestCodeImage{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"ProjectId"] = [SDUserInfo obtainWithProjectID];
    param[@"GpsLocal"] = self.addressLab.text;
    param[@"GpsXY"] = [NSString stringWithFormat:@"%@,%@",self.latiteDict[@"latitude"],self.latiteDict[@"longitude"]];
    param[@"AttendanceUserId"] = [SDUserInfo obtainWithProjectUserID];
    param[@"type"] = @"addAppProjectAttendance";
    [[KRMainNetTool sharedKRMainNetTool]upLoadData:HTTP_UPDATEWORK_URL params:param.copy andData:self.dataArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            if ([showdata isKindOfClass:[NSDictionary class]]) {
                
                [SVProgressHUD  showSuccessWithStatus:@"上传成功"];
                [SVProgressHUD  dismissWithDelay:0.15];
                
                //自动延迟3秒执行
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    SDDistingDetailController *distDetaVC = [[SDDistingDetailController alloc]init];
                    distDetaVC.attendanceIdStr = showdata[@"attendanceId"];
                    [weakSelf.navigationController pushViewController:distDetaVC animated:YES];
                });
            }
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];
    
}

@end
