//
//  SDSelectPlatformController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSelectPlatformController.h"

#import "SDAddTerraceController.h"

#import "SDShowSpaceView.h"

#import "SDPlatformTableViewCell.h"
#define SDPLATFORMTABLEVIEW_CELL  @"SDPlatformTableViewCell"

@interface SDSelectPlatformController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *platformTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
//空白页
@property (nonatomic,strong) SDShowSpaceView *spaceView;

//页码
@property (nonatomic,assign) NSInteger page;

@end

@implementation SDSelectPlatformController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //设置navi
    [self createNavi];
    //创建TableView
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
    //显示导航栏
    self.navigationController.navigationBar.hidden = NO;
    //平台列表
    [self requestLoadData];
}

#pragma mark -----设置Navi----
-(void) createNavi{
    [self customNaviItemTitle:@"选择平台" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(selectLeftBtn:) isLeft:YES];
    [self customTabBarButtonimage:@"nav_icon_add" target:self action:@selector(selectReihtBtn:) isLeft:NO];
}
-(void) selectLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//添加平台
-(void) selectReihtBtn:(UIButton *)sender{
    SDAddTerraceController *addVC = [[SDAddTerraceController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark ------创建TableView-----
-(void) createTableView{
   
    self.platformTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
    [self.view addSubview:self.platformTableView];
    
    self.platformTableView.rowHeight = 66;
    self.platformTableView.delegate = self;
    self.platformTableView.dataSource = self;
    self.platformTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.platformTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.platformTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"xzpt_bg_02"]]];
    
    [self.platformTableView registerNib:[UINib nibWithNibName:SDPLATFORMTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDPLATFORMTABLEVIEW_CELL];
    
    self.spaceView = [[SDShowSpaceView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KSNaviTopHeight)];
    [self.platformTableView addSubview:self.spaceView];
    
    __weak typeof(self) weakSelf = self;
    self.spaceView.btnBlcok = ^(NSInteger index) {
        if (index == 0) {
            //回到首页
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else if (index == 1){
            //立即添加
            [weakSelf selectReihtBtn:nil];
        }
    };
    self.spaceView.hidden = YES;
    
    //刷新
    self.platformTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestLoadData];
    }];
    
    self.platformTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestLoadData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDPlatformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDPLATFORMTABLEVIEW_CELL forIndexPath:indexPath];
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}

//选中平台
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArr[indexPath.row];
    
    //选择平台
    [self requestSelectdPlatformDict:dict];
    
}

#pragma mark ----数据相关----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr  = [NSMutableArray array];
    }
    return _dataArr;
}
-(void) requestLoadData{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"level"] = @"1";
    param[@"userid"] = [SDUserInfo obtainWithUserID];
    param[@"offset"] = [NSNumber numberWithInteger:self.page];
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_PLAFORM_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        [weakSelf.platformTableView.mj_header endRefreshing];
        [weakSelf.platformTableView.mj_footer endRefreshing];
        if (!error) {
            
            if (weakSelf.page == 1) {
                [weakSelf.dataArr removeAllObjects];
            }
            
            [weakSelf.dataArr addObjectsFromArray:showdata];
            
            if (weakSelf.dataArr.count == 0) {
                weakSelf.spaceView.hidden = NO;
            }else{
                weakSelf.spaceView.hidden = YES;
            }
            [weakSelf.platformTableView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    }];
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
            
            //选择平台
            NSUserDefaults *userD  = [NSUserDefaults standardUserDefaults];
            [userD setObject:dict forKey:@"Platform"];
            //3.强制让数据立刻保存
            [userD synchronize];
            
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"platform" object:self userInfo:@{@"dict":dict}];
            
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    }];
    
}




@end
