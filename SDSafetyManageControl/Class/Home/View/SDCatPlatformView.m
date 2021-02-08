//
//  SDCatPlatformView.m
//  SDSafetyManageControl
//
//  Created by tiao on 2018/4/28.
//  Copyright © 2018年 tiao. All rights reserved.
//

#import "SDCatPlatformView.h"

#import "SDSelectPlatformTableViewCell.h"
#define SDPLATFORMTABLEVIEW_CELL  @"SDSelectPlatformTableViewCell"

@interface SDCatPlatformView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *platformTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

//记录上次的indexPath
@property (nonatomic,strong) NSIndexPath *selectIndexPath;

@end

@implementation SDCatPlatformView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createTableView];
        [self requestLoadData];
    }
    return self;
}
-(void) createTableView{
    
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.75;
    
    self.platformTableView  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, self.frame.size.height)];
    [self addSubview:self.platformTableView];
    self.platformTableView.rowHeight = 44;
    self.platformTableView.delegate = self;
    self.platformTableView.dataSource = self;
    self.platformTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.platformTableView registerNib:[UINib nibWithNibName:SDPLATFORMTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDPLATFORMTABLEVIEW_CELL];
    
}

#pragma mark -----UITableViewDataSoucre---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SDSelectPlatformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDPLATFORMTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectIndexPath.row != indexPath.row) {
        
        SDSelectPlatformTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        
        SDSelectPlatformTableViewCell *oldcell = [tableView cellForRowAtIndexPath:self.selectIndexPath];
        oldcell.backgroundColor = [UIColor colorTextWhiteColor];
    }
    //记录选中的indexPath
    self.selectIndexPath = indexPath;
    NSDictionary *dict = self.dataArr[indexPath.row];
    self.selectCellBlock(dict);
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
    [[KRMainNetTool sharedKRMainNetTool]getRequstWith:HTTP_PLAFORM_URL params:param.copy withModel:nil waitView:self complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            NSLog(@"-------showdata--%@------",showdata);
            [weakSelf.dataArr addObjectsFromArray:showdata];
            [weakSelf.platformTableView reloadData];

        }else{
            
            [SVProgressHUD showErrorWithStatus:error];
            [SVProgressHUD dismissWithDelay:1];
        }
    
    }];
}





@end
