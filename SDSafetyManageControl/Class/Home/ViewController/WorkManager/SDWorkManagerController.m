//
//  SDWorkManagerController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/9.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDWorkManagerController.h"

#import "SDWorkDetailController.h"

#import "SDWorkManagerTableViewCell.h"
#define SDWORKMANAGERTABLEVIEW_CELL @"SDWorkManagerTableViewCell"

@interface SDWorkManagerController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic,strong) UITableView *workTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

//分页
@property (nonatomic,assign) NSInteger page;
@end

@implementation SDWorkManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    //设置导航栏
    [self createNavi];
    //创建Tableview
    [self createTbleView];
    //请求数据
    [self requsetWorkManager];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
   
}
//创建Tableview
-(void) createTbleView{
    
    self.view.backgroundColor = [UIColor colorLineF2f2fBlackColor];
    
    self.workTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+10, KScreenW, KScreenH-KSNaviTopHeight-10)];
    [self.view addSubview:self.workTableView];
    
    self.workTableView.dataSource = self;
    self.workTableView.delegate = self ;
    self.workTableView.rowHeight = 70;
    self.workTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.workTableView registerNib:[UINib nibWithNibName:SDWORKMANAGERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDWORKMANAGERTABLEVIEW_CELL];
    
    __weak typeof(self) weakSelf = self;
    self.workTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requsetWorkManager];
    }];
    
    self.workTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requsetWorkManager];
    }];
    self.workTableView.mj_footer.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDWorkManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDWORKMANAGERTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDWorkDetailController *detaVC = [[SDWorkDetailController alloc]init];
    detaVC.ticketIdStr = self.dataArr[indexPath.row][@"TicketId"];
    [self.navigationController pushViewController:detaVC animated:YES];
}
//设置导航栏
-(void)createNavi{
    [self customNaviItemTitle:@"工作票列表" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(addLeftBtn:) isLeft:YES];
}
-(void) addLeftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -----数据相关----
-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr =  [NSMutableArray array];
    }
    return _dataArr;
}
//工作票列表
-(void)requsetWorkManager{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"limit"] = @"10";
    param[@"page"] = [NSNumber numberWithInteger:self.page];
    param[@"projectId"] = [SDUserInfo obtainWithProjectID];
    param[@"type"] = @"getAppTicketList";
    
    [[KRMainNetTool sharedKRMainNetTool]postRequstWith:HTTP_UPDATEWORK_URL params:param.copy withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        [weakSelf.workTableView.mj_footer endRefreshing];
        [weakSelf.workTableView.mj_header endRefreshing];
        if (!error) {
            
            if (weakSelf.page == 1) {
                
                [weakSelf.dataArr removeAllObjects];
            }
            
            if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
                
                 [weakSelf.dataArr addObjectsFromArray:showdata];
            }
            
            if (self.dataArr.count > 9) {
                self.workTableView.mj_footer.hidden = NO;
            }else{
               self.workTableView.mj_footer.hidden = YES;
            }
            [weakSelf.workTableView reloadData];
        
        }else{
            [SVProgressHUD  showErrorWithStatus:error];
            [SVProgressHUD  dismissWithDelay:1];
        }

    }];
    
    
}




@end
