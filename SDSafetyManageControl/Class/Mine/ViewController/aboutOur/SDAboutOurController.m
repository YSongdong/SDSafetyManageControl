//
//  SDAboutOurController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/2.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDAboutOurController.h"

#import "SDShowVersionView.h"



#import "SDAboutOurHeaderView.h"
#import "SDAboutTableViewCell.h"
#define SDABOUTTBLEVIEW_CELL  @"SDAboutTableViewCell"
@interface SDAboutOurController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *aboutTableView;
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation SDAboutOurController

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置导航栏
    [self craeteNavi];
    //加载数据源
    [self loadData];
    //创建TableView
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
}
#pragma mark  --- 创建TableView---
-(void) loadData{
    self.dataArr = @[@"检查更新",@"版本说明",@"清除缓存"];
}
-(void) createTableView{
    
    SDAboutOurHeaderView *headerView = [[SDAboutOurHeaderView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, 200)];
    
    self.aboutTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight) ];
    [self.view addSubview:self.aboutTableView];
    
    self.aboutTableView.rowHeight = 60;
    self.aboutTableView.delegate = self;
    self.aboutTableView.dataSource = self;
    self.aboutTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.aboutTableView.tableHeaderView = headerView;
    
    self.aboutTableView.backgroundColor = [UIColor TableViewBackGrounpColor];
    
    [self.aboutTableView registerNib:[UINib nibWithNibName:SDABOUTTBLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDABOUTTBLEVIEW_CELL];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDABOUTTBLEVIEW_CELL forIndexPath:indexPath];
    cell.nameStr = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

}
#pragma mark  --- 设置导航栏---
-(void)craeteNavi{
    [self customNaviItemTitle:@"关于我们" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(backBtn:) isLeft:YES];
}
-(void)backBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

@end
