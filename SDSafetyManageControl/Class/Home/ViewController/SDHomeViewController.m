//
//  SDHomeViewController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/11.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDHomeViewController.h"

#import "SDCharaDistingController.h"
#import "SDDistingManagerController.h"
#import "SDSignManagerController.h"
#import "SDSignDetailController.h"
#import "SDWorkManagerController.h"
#import "SDTodaySignController.h"
#import "SDUpdateWorkController.h"
#import "AppDelegate.h"
#import "SDNavigationController.h"

#import "SDLoginController.h"
#import "SDAddTerraceController.h"
#import "SDSelectPlatformController.h"
#import "SDTiKuExerciseListController.h"

#import "SDCatPlatformView.h"

#import "SDNaviTitleView.h"
#import "SDHeaderView.h"

#import "SDHomeTableViewCell.h"
#define SDHOMETABLEVIEW_CELL  @"SDHomeTableViewCell"

#define HEAHERVIEWHEIGHT  250


@interface SDHomeViewController () <UITableViewDelegate,UITableViewDataSource>

// 头部视图
@property (nonatomic,strong)  SDHeaderView *headerView;
//切换平台view
@property (nonatomic,strong) SDCatPlatformView *catPlatView;
//导航栏中间view
@property (nonatomic,strong)   SDNaviTitleView *titleView ;

//数据源数组
@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,strong) UITextField *myTextField;

@property (nonatomic,strong) UITextField *nameTF;

@property (nonatomic,strong) UITextField *passdTF;


@end

@implementation SDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    //设置导航栏
    [self createNavi];
    //设置headerView
    [self craeteHeaderView];
    //加载数据源
    [self loadData];
    //创建TableView
    [self createTableView];
    //注册通知
    [self addNotitf];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"0.0";
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark ------通知------
-(void) addNotitf{
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectPlatform:) name:@"platform" object:nil];
}
-(void)selectPlatform:(NSNotification *)titf{
    NSDictionary *dict = [titf.userInfo objectForKey:@"dict"];
    self.titleView.nameLab.text = dict[@"name"];
    //隐藏登录按钮
    [self.headerView  hiddenLogin];
}
#pragma mark ---- 设置导航栏-------
//设置导航栏
-(void) createNavi{
    [self customNaviItemTitle:@"电力作业管控" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"safe_main_backout" target:self action:@selector(addReightBtn:) isLeft:NO];
}
//退出
-(void)addReightBtn:(UIButton *) sender{
    [self requsetAcouuont];
}
-(void) closeViewDict:(NSDictionary *)dict{
    [self.titleView closePlatformView];
    [self requestSelectdPlatformDict:dict];
}

#pragma mark ------设置headerView----
-(void) loadData{
    self.dataArr = @[@[@"sy_list_ico_rwbb",@"身份识别"],@[@"sy_ico_02",@"识别管理"],@[@"sy_ico_01",@"今日签到"],@[@"sy_ico_02",@"签到管理"],@[@"sy_ico_03",@"上传工作票"],@[@"sy_ico_04",@"工作票管理"]];
    
}
-(void) craeteHeaderView{
    __weak typeof(self) weakSelf = self;
    self.headerView = [[SDHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, HEAHERVIEWHEIGHT)];
    self.headerView.loginBtnBlock = ^{
        //登录
        SDLoginController *loginVC = [[SDLoginController alloc]init];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
    };
    [self.view addSubview:_headerView];
}
#pragma mark  -----创建UITableView
-(void)createTableView{
    
    UITableView *homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, HEAHERVIEWHEIGHT, KScreenW, KScreenH)];
    [self.view addSubview:homeTableView];
    
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    [homeTableView registerNib:[UINib nibWithNibName:SDHOMETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDHOMETABLEVIEW_CELL];
    
    homeTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDHOMETABLEVIEW_CELL forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.arr = self.dataArr[indexPath.row];
    return  cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SDCharaDistingController *charaVC = [[SDCharaDistingController alloc]init];
        [self.navigationController pushViewController:charaVC animated:YES];
    }else if(indexPath.row == 1){
        SDDistingManagerController *distManagerVC = [[SDDistingManagerController alloc]init];
        [self.navigationController pushViewController:distManagerVC animated:YES];
    }else if (indexPath.row == 2) {
        SDTodaySignController *todatVC = [[SDTodaySignController alloc]init];
        [self.navigationController pushViewController:todatVC animated:YES];
    }else if (indexPath.row == 3) {
        SDSignManagerController *signVC = [[SDSignManagerController alloc]init];
        [self.navigationController pushViewController:signVC animated:YES];
    }else if (indexPath.row == 4){
        SDUpdateWorkController *updateVC = [[SDUpdateWorkController alloc]init];
        [self.navigationController pushViewController:updateVC animated:YES];
    }else{
        SDWorkManagerController *workVC = [[SDWorkManagerController alloc]init];
        [self.navigationController pushViewController:workVC animated:YES];
    }
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
#pragma mark ------ 数据相关--------
//选择平台
-(void) requestSelectdPlatformDict:(NSDictionary *) dict{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"plaform_id"] =dict[@"id"];
    param[@"userid"] = [SDUserInfo obtainWithUserID];
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_SELECTPLATPORM_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            //保持修改的用户信息
            [SDUserInfo selectPlatformAlterMsg:showdata];
            
             weakSelf.titleView.nameLab.text = dict[@"name"];
            
            //隐藏登录按钮
            [weakSelf.headerView  hiddenLogin];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    }];
}
//退出
-(void)requsetAcouuont{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"epid"]=[SDUserInfo obtainWitEpid];
    param[@"username"]= [SDUserInfo obtainWithidcard];
    param[@"type"] = @"applogout";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_ACCOUT_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            
            NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
            [userD removeObjectForKey:@"Login"];
            
            //登录界面
            SDLoginController *loginVC =[[SDLoginController alloc]init];
            SDNavigationController *naviVC = [[SDNavigationController alloc]initWithRootViewController:loginVC];
            AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appdel.window.rootViewController = naviVC;
            
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
        
    }];
    
    
}



@end
