//
//  SDSignManagerController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDSignManagerController.h"

#import "SDSignDetailController.h"

#import "SDSignManagerTableViewCell.h"
#define SDSIGNMANAGERTABLEVIEW_CELL  @"SDSignManagerTableViewCell"
@interface SDSignManagerController ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *managerTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

//分页
@property (nonatomic,assign) NSInteger page;

@end

@implementation SDSignManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //设置导航栏
    [self createNavi];
    //创建TableView
    [self createTableView];
    //
    [self requsetSignManager];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";

}
//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"签到列表" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
}
-(void) addLeftBtn:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) createTableView{
    
    self.view.backgroundColor = [UIColor colorLineF2f2fBlackColor];
    
    self.managerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+10, KScreenW, KScreenH-KSNaviTopHeight-10)];
    [self.view addSubview:self.managerTableView];
    
    self.managerTableView.delegate = self;
    self.managerTableView.dataSource= self;
    self.managerTableView.rowHeight =82;
    self.managerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.managerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.managerTableView registerNib:[UINib nibWithNibName:SDSIGNMANAGERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDSIGNMANAGERTABLEVIEW_CELL];
    
    __weak typeof(self) weakSelf = self;
    self.managerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requsetSignManager];
    }];
    
    self.managerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requsetSignManager];
    }];
    self.managerTableView.mj_footer.hidden = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDSignManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDSIGNMANAGERTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict =  self.dataArr[indexPath.row];
    SDSignDetailController *detaVC = [[SDSignDetailController alloc]init];
    detaVC.dict = dict;
    [self.navigationController pushViewController:detaVC animated:YES];
    
}

#pragma mark ---- 数据相关----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}

//工作票列表
-(void)requsetSignManager{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"limit"] = @"10";
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"ProjectId"] = [SDUserInfo obtainWithProjectID];
    param[@"type"] = @"appSignInList";
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_UPDATEWORK_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        [weakSelf.managerTableView.mj_footer endRefreshing];
        [weakSelf.managerTableView.mj_header endRefreshing];
        if (!error) {
            if (weakSelf.page == 1) {
                
                [weakSelf.dataArr removeAllObjects];
            }
            if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                
                [weakSelf.dataArr addObjectsFromArray:showdata];
            }
            
            if (self.dataArr.count > 9) {
                self.managerTableView.mj_footer.hidden = NO;
            }else{
                self.managerTableView.mj_footer.hidden = YES;
            }
            
            [weakSelf.managerTableView reloadData];
            
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }
    }];
    
    
}




@end
