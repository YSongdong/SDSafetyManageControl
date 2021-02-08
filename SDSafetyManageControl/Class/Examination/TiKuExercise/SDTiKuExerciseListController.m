//
//  SDTiKuExerciseListController.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/5/7.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDTiKuExerciseListController.h"

#import "SDTiKuHeaderSreachView.h"
#import "SDShowTiKuSpaceView.h"
#import "SDPromptShowTikuView.h"
#import "SDSiftShowTikuView.h"

#import "SDTiKuListTableViewCell.h"
#define SDTIKULISTTABLEVIEW_CELL  @"SDTiKuListTableViewCell"

@interface SDTiKuExerciseListController ()
<UITableViewDelegate,
UITableViewDataSource
>

 //搜索view
@property (nonatomic,strong)SDTiKuHeaderSreachView *headerView;
//空白页
@property (nonatomic,strong) SDShowTiKuSpaceView *showSpaceView;
//筛选view
@property (nonatomic,strong) SDSiftShowTikuView *showSiftView;


@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation SDTiKuExerciseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Navi
    [self createNavi];
    //创建tableView
    [self createTableView];
    
    SDPromptShowTikuView *promptView = [[SDPromptShowTikuView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:promptView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"1.0";
}
#pragma mark   -----设置Navi-----
-(void) createNavi{
    [self customNaviItemTitle:@"题库练习" titleColor:[UIColor colorTextWhiteColor]];
    [self customTabBarButtonimage:@"btn_back_white" target:self action:@selector(leftBtn:) isLeft:YES];
    [self customTabBarButtonimage:@"tklx_nav_icon_sx" target:self action:@selector(reightBtn:) isLeft:NO];
}
-(void) leftBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) reightBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (!self.showSiftView) {
        self.showSiftView = [[SDSiftShowTikuView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, KScreenH-KSNaviTopHeight)];
        [self.view addSubview:self.showSiftView];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing: YES];
}

#pragma mark -----创建TableView----
-(void) createTableView{
    
    //搜索view
    self.headerView = [[SDTiKuHeaderSreachView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight, KScreenW, 60)];
    [self.view addSubview:self.headerView];
    
    self.view.backgroundColor = [UIColor colorTextWhiteColor];
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+60, KScreenW, KScreenH-KSNaviTopHeight-60)];
    [self.view addSubview:self.listTableView];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.rowHeight =210;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.listTableView registerNib:[UINib nibWithNibName:SDTIKULISTTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDTIKULISTTABLEVIEW_CELL];
    
    //添加空白页
    self.showSpaceView = [[SDShowTiKuSpaceView alloc]initWithFrame:CGRectMake(0, KSNaviTopHeight+60, KScreenW, KScreenH-KSNaviTopHeight-60)];
    [self.listTableView addSubview:self.showSpaceView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SDTiKuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDTIKULISTTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



@end
