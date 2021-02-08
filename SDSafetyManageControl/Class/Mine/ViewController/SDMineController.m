//
//  SDMineController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/26.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDMineController.h"

#import "SDAboutOurController.h"

#import "SDUserInfoHeaderView.h"
#import "SDLoginController.h"
#import "SDUserInfoController.h"
#import "SDPhotoCollectController.h"

#import "SDMineTableViewCell.h"
#define SDMINETABLEVIEW_CELL  @"SDMineTableViewCell"

@interface SDMineController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SDUserInfoHeaderView *headerView;

@property (nonatomic,strong) UITableView *mineTableView;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation SDMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self createNavi];
    //设置数据源
    [self loadData];
    //设置headerView
    [self createUITableView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"0.0";
    //显示tabbar
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark ---设置导航栏---
-(void)createNavi{
    [self customNaviItemTitle:@"个人中心" titleColor:[UIColor colorTextWhiteColor]];
}
//设置数据源
-(void) loadData{
    self.dataArr = @[@[@[@"mine_tableView_exam",@"我的考试"],@[@"mine_tableView_result",@"我的成绩"]],@[@[@"mine_tableView_photo",@"照片采集"],@[@"mine_tableView_about",@"关于我们"]]];
}
#pragma mark ------创建TableView----
-(void) createUITableView{
    
    self.view.backgroundColor  = [UIColor colorTextWhiteColor];
    
    self.headerView  =[[SDUserInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KSNaviTopHeight+15+205)];
    [self.view addSubview:self.headerView];
    __weak typeof(self) weakSelf = self;
    //登录按钮
    self.headerView.loginBlock = ^{
        weakSelf.hidesBottomBarWhenPushed = YES;
        SDLoginController *loginVC = [[SDLoginController alloc]init];
        [weakSelf.navigationController pushViewController:loginVC animated:YES];
        __weak typeof(weakSelf) strongSelf = weakSelf;
        loginVC.loginDataBlock = ^(NSDictionary *dict) {
            
            [strongSelf.headerView loginInfo:dict];
        };
         weakSelf.hidesBottomBarWhenPushed = NO;
    };
    
    //进入用户信息
    self.headerView.userInfoBlock = ^{
         weakSelf.hidesBottomBarWhenPushed = YES;
        SDUserInfoController *userInfoVC = [[SDUserInfoController alloc]init];
        [weakSelf.navigationController pushViewController:userInfoVC animated:YES];
         weakSelf.hidesBottomBarWhenPushed = NO;
    };
    
    self.mineTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.headerView.frame), KScreenW, KScreenH) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.mineTableView];
    
    self.mineTableView.rowHeight = 60;
    
    self.mineTableView.delegate = self;
    self.mineTableView.dataSource = self;
    
    [self.mineTableView registerNib:[UINib nibWithNibName:SDMINETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDMINETABLEVIEW_CELL];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDMINETABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.dataArr[indexPath.section];
    cell.arr = arr[indexPath.row];
    cell.indexPath = indexPath;
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }else{
        return 22;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        //判断是否已经采集过照片
        [self requestLoadCollectData];
    
    }else if (indexPath.section == 1 && indexPath.row ==1){
//        //关于我们
//        self.hidesBottomBarWhenPushed = YES;
//        SDAboutOurController *aboutOurVC = [[SDAboutOurController alloc]init];
//        [self.navigationController pushViewController:aboutOurVC animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
//
    }
    
}

#pragma mark ----- 数据相关 ----
//是否已经采集图片
-(void) requestLoadCollectData{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = [SDUserInfo obtainWithUserID];
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_COLLECT_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            //采集照片
            weakSelf.hidesBottomBarWhenPushed =  YES;
            SDPhotoCollectController *photoVC = [[SDPhotoCollectController alloc]init];
            photoVC.photoDict = showdata;
            [weakSelf.navigationController pushViewController:photoVC animated:YES];
             weakSelf.hidesBottomBarWhenPushed =  NO;

        }else{
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
    }];
}



@end
