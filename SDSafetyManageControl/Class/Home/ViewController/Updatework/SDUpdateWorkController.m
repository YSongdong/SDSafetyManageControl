//
//  SDUpdateWorkController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUpdateWorkController.h"

#import "SDWorkManagerController.h"

#import "SDTodaySignCollectionViewCell.h"
#define SDTODAYSIGNCOLLECtONA_CELL  @"SDTodaySignCollectionViewCell"

@interface SDUpdateWorkController ()
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic,strong) UICollectionView *todayCollect;

@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDUpdateWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
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
    if (indexPath.row != self.dataArr.count-1) {
        cell.delBtn.hidden = NO;
    }else{
        cell.delBtn.hidden = YES;
    }
    cell.selectIndexPath = indexPath;
    cell.image = self.dataArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    cell.delBlock = ^{
        //删除cell
        [weakSelf.dataArr removeObjectAtIndex:indexPath.row];
        [weakSelf.todayCollect reloadData];
    };
    return cell;
}
#pragma mark  ------选择单元格------
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.dataArr.count-1) {
        if (self.dataArr.count < 7) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 判断是否支持相机
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                   // imagePickerController.allowsEditing = YES;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [self presentViewController:imagePickerController animated:YES completion:nil];
                }
            }]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:@"最多上传6张照片"];
            [SVProgressHUD dismissWithDelay:1];
        }
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
    
    return CGSizeMake(KScreenW, 0.01);
}
#pragma mark -----拍照照片处理----
// 选择了图片或者拍照了
- (void)imagePickerController:(UIImagePickerController *)aPicker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [aPicker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.dataArr insertObject:image atIndex:0];
    //刷新
    [self.todayCollect reloadData];
    return;
}
#pragma mark -----设置导航栏----
-(void)createNavi{
    [self customNaviItemTitle:@"上传工作票" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
    
    UIButton *updateBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [updateBtn setTitle:@"上传" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor colorTextWhiteColor] forState:UIControlStateNormal];
    [updateBtn addTarget:self action:@selector(selectUpdataBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rieghtItem = [[UIBarButtonItem alloc]initWithCustomView:updateBtn];
    self.navigationItem.rightBarButtonItem = rieghtItem;
}
-(void) addLeftBtn:(UIButton *)sender{
    
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"你确定要退出今日签到吗?" preferredStyle:UIAlertControllerStyleAlert];
//
//    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
        [self.navigationController popViewControllerAnimated:YES];
//
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }]];
//
//    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)selectUpdataBtn:(UIButton *) sender{
    
    if (self.dataArr.count < 2) {
        [SVProgressHUD  showErrorWithStatus:@"请上传照片"];
        [SVProgressHUD  dismissWithDelay:1];
        return;
    }
    
    //移除最后一个元素
    [self.dataArr removeObject:[self.dataArr lastObject]];
    
    //上传工作票
    [self requsetTestCodeImageData];
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
#pragma mark -----数据相关----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}
//上传工作票
-(void)requsetTestCodeImageData{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"addAppProjectTicket";
    param[@"ProjectCompanyId"] = [SDUserInfo obtainWithWorkCompanyID];
    param[@"projectId"] = [SDUserInfo obtainWithProjectID];
    param[@"uploadUserId"] = [SDUserInfo obtainWithProjectUserID];
    [[KRMainNetTool sharedKRMainNetTool]upLoadData:HTTP_UPDATEWORK_URL params:param.copy andData:self.dataArr waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            [SVProgressHUD  showSuccessWithStatus:@"上传成功"];
            [SVProgressHUD  dismissWithDelay:1];
            
            SDWorkManagerController *workVC = [[SDWorkManagerController alloc]init];
            [self.navigationController pushViewController:workVC animated:YES];

        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
        
    }];
    
}


@end
