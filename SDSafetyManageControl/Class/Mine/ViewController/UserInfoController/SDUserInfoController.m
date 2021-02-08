//
//  SDUserInfoController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/27.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDUserInfoController.h"

#import "SDLoginController.h"
#import "SDAlterVipNumberController.h"
#import "SDAlterPasswordController.h"
#import "SDAlterPhoneNumberController.h"

#import "SDLeaveBtnShowView.h"

#import "SDUserLeaveTableViewCell.h"
#import "SDUserInfoTableViewCell.h"

#define SDUSERINFOTABLEVIEW_CELL  @"SDUserInfoTableViewCell"
#define SDUERINFOLEAVE_CELL  @"SDUserLeaveTableViewCell"

@interface SDUserInfoController ()
<UITableViewDelegate,
UITableViewDataSource,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>

@property (nonatomic,strong) UITableView *userTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;
//退出按钮提示框
@property (nonatomic,strong) SDLeaveBtnShowView *leaveShowView;
//是否显示平台数据  YES 显示  NO 不显示
@property (nonatomic,assign) BOOL isShowPlatform;
//记录删除平台的indexPath
@property (nonatomic,strong) NSIndexPath *delIndexPath;

@end

@implementation SDUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    
    self.isShowPlatform = NO;
    
    //设置导航栏
    [self createNavi];
    //加载数据源
    [self loadData];
    //创建tableView
    [self createTableView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
    
    //获取平台列表
    [self requestPlatformData];
}

//设置导航栏
-(void) createNavi{
    [self customNaviItemTitle:@"个人资料" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(selectLeftBtn:) isLeft:YES];
}
-(void) selectLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  ------ 创建TableVIew------
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//加载数据源
-(void) loadData{
    //头像
    NSArray *headerArr = @[@{@"image":@"porfile_ico_head",@"name":@"用户头像",@"desc":[SDUserInfo obtainWithphoto]}];
    NSArray *infoArr = @[@{@"image":@"porfile_ico_name",@"name":@"真实姓名",@"desc":[SDUserInfo obtainWithtrueName]},
          @{@"image":@"porfile_ico_id",@"name":@"身份证号码",@"desc":[SDUserInfo obtainWithidcard]},
          @{@"image":@"porfile_ico_phone",@"name":@"手机号码",@"desc":[SDUserInfo obtainWithPhone]},
//          @{@"image":@"porfile_ico_vip",@"name":@"会员账号",@"desc":[SDUserInfo obtainWithUserName]},
           @{@"image":@"porfile_ico_password",@"name":@"修改密码",@"desc":@""}];
    
    [self.dataArr addObject:headerArr];
    [self.dataArr addObject:infoArr];
    [self.dataArr addObject:@[@{}]];
}
//创建tableView
-(void) createTableView{
    
    self.userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight) style:UITableViewStyleGrouped];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.userTableView.rowHeight = 60;
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;
    
    [self.view addSubview:self.userTableView];
    
    [self.userTableView registerNib:[UINib nibWithNibName:SDUSERINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDUSERINFOTABLEVIEW_CELL];
    [self.userTableView registerNib:[UINib nibWithNibName:SDUERINFOLEAVE_CELL bundle:nil] forCellReuseIdentifier:SDUERINFOLEAVE_CELL];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    __weak typeof(self) weakSelf = self;
    if (indexPath.section == self.dataArr.count-1) {
        SDUserLeaveTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:SDUERINFOLEAVE_CELL forIndexPath:indexPath];
        //退出按钮
        cell.leaveBtnBlock = ^{
            //删除用户信息
            [SDUserInfo delUserInfo];
            //跳转登录页面
            weakSelf.hidesBottomBarWhenPushed = YES;
            SDLoginController *loginVC =  [[SDLoginController alloc]init];
            loginVC.isBackHome = YES;
            [weakSelf.navigationController pushViewController:loginVC animated:YES];
            
        };
        return cell;
    }else{

        SDUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDUSERINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = self.dataArr[indexPath.section];
        
        cell.isShowPlatform = self.isShowPlatform;
        cell.indexPath =  indexPath;
        cell.dict = arr[indexPath.row];
       
        //退出平台
        cell.leaveBtnBlock = ^(NSIndexPath *indexPath) {
            //记录删除的IndexPath；
            weakSelf.delIndexPath = indexPath;
            NSLog(@"-------indexPath-%@---%ld-----",indexPath,(long)indexPath.row);
            [weakSelf showLeavePlatformView];
            
        };
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }else if (section == 1){
        return 25;
    }else {
        return 30;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0 && indexPath.row == 0) {
        //用户头像
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = weakSelf;
                    imagePickerController.allowsEditing = YES;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
                    [weakSelf presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = weakSelf;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [weakSelf presentViewController:imagePickerController animated:YES completion:nil];
            }
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }else if (indexPath.section == 1 && indexPath.row == 3){
        //修改会员账号
        self.hidesBottomBarWhenPushed = YES;
        SDAlterVipNumberController *vipVC = [[SDAlterVipNumberController alloc]init];
        [self.navigationController pushViewController:vipVC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 4){
        //修改密码
        self.hidesBottomBarWhenPushed = YES;
        SDAlterPasswordController *alterPsdVC = [[SDAlterPasswordController alloc]init];
        [self.navigationController pushViewController:alterPsdVC animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2){
        //修改电话号码
        self.hidesBottomBarWhenPushed = YES;
        SDAlterPhoneNumberController *phoneVC = [[SDAlterPhoneNumberController alloc]init];
        [self.navigationController pushViewController:phoneVC animated:YES];
    }
}


#pragma mark ----- 退出平台提示框------
-(void) showLeavePlatformView{
    //要退出的数据
    NSArray *arr = self.dataArr[self.delIndexPath.section];
    NSDictionary *dict = arr[self.delIndexPath.row];
    
    self.leaveShowView = [[SDLeaveBtnShowView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.leaveShowView.titleLab.text = [NSString stringWithFormat:@"您是否确认退出“%@”平台?",dict[@"name"]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.leaveShowView];

    __weak typeof(self) weakSelf = self;
    self.leaveShowView.trueBtnBlock = ^{
        [weakSelf requestLeavePlatForm:dict];
    };
}
#pragma mark  -----  数据相关----------
 //获取平台列表
-(void) requestPlatformData{

    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"level"] = @"1";
    param[@"userid"] = [SDUserInfo obtainWithUserID];
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_PLAFORM_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            //判断之前是否有平台， 如果有， 就删除
            if (weakSelf.dataArr.count > 3) {
                [weakSelf.dataArr removeObjectAtIndex:2];
            }
            
            NSArray *arr = showdata;
            
            weakSelf.isShowPlatform = YES;
            
            [weakSelf.dataArr insertObject:arr atIndex:2];
            [weakSelf.userTableView reloadData];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
    }];
}

//退出平台
-(void) requestLeavePlatForm:(NSDictionary *)dict{
    
    //移除离开平台提示框
    [self.leaveShowView closeShowView];
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"plaform_id"] = dict[@"id"];
    param[@"identity_id"] = dict[@"identity_id"];
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_EXITPLAFFORM_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            //删除数据源
            NSArray *platformArr =weakSelf.dataArr[weakSelf.delIndexPath.section];
            NSMutableArray *arr =[NSMutableArray arrayWithArray:platformArr];
            
            if (arr.count <= 1) {
                
                [weakSelf.dataArr removeObjectAtIndex:2];
                
            }else{
                
                [arr removeObjectAtIndex:weakSelf.delIndexPath.row];
                [weakSelf.dataArr removeObjectAtIndex:2];
                [weakSelf.dataArr insertObject:arr atIndex:2];
            }
            
            //刷新UI
            [weakSelf.userTableView reloadData];
            
            NSLog(@"--------%@----",showdata);
        }else{
            
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
    }];

}





@end
