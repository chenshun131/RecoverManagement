//
//  RMApplyAllViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApplyAllViewController.h"
#import "RMApplyAllTableViewCell.h"

@interface RMApplyAllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *headerView;
    UITableView *mainTableView;
    NSInteger *willOrDoTag;//未审批 0   已审批 1
}


@end

@implementation RMApplyAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"我的申请-全部";
    [self addLeftView:@""];
    
    self.view.backgroundColor = [UIColor whiteColor];
    willOrDoTag = 0;
    [self setHederView];
    [self setMainView];
}

- (void)leftBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 未审批 已审批
- (void)setHederView{
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 45)];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    NSArray *title = @[@"审批中",@"已审批"];
    for (int i = 0; i < 2; i++) {
        UIView *yuanView = [[UIView alloc]initWithFrame:CGRectMake(40, 19, 7, 7)];
        if (i==1) {
            yuanView.frame = CGRectMake(KScreenWidth-120, 19, 7, 7);
        }
        yuanView.backgroundColor = RMColor(32, 102, 233);
        yuanView.layer.cornerRadius = 3.5;
        yuanView.layer.masksToBounds = YES;
        yuanView.tag = 240+i;
        [headerView addSubview:yuanView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yuanView.frame)+8, 15, 65, 15)];
        label.text = title[i];
        //        label.textColor = RMColor(77, 77, 77);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.tag = 250+i;
        [headerView addSubview:label];
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(yuanView.frame.origin.x, 15, CGRectGetMaxX(label.frame), 15)];
        titleBtn.tag = 230+i;
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:titleBtn];
        
        if (i==0) {
            label.textColor = RMColor(32, 102, 233);
        }else if (i==1){
            yuanView.hidden = YES;
        }
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, 1)];
    line.backgroundColor =RMColor(230, 230, 230);
    [headerView addSubview:line];
}

#pragma mark --  tableView
- (void)setMainView{
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, KScreenWidth, KScreenHeight-64-45) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorColor = RMColor(230, 230, 230);
    mainTableView.backgroundColor = RMColor(249, 249, 249);
    [self.view addSubview:mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    head.backgroundColor=[UIColor whiteColor];
    NSArray *arr = @[@"补签审批",@"加班审批"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KScreenWidth-20, 40)];
    label.text = arr[section];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = RMColor(32, 102, 233);
    label.font = [UIFont systemFontOfSize:15];
    [head addSubview:label];
    
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identi = @"cell";
    RMApplyAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[RMApplyAllTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr;
    
    NSArray *timeArr;
    NSArray *shenpiArr;
    if (willOrDoTag==0) {
        titleArr = @[@[@"HR审批",@"上级领导审批"],@[@"上级领导审批",@"HR审批"]];
        timeArr = @[@[@"2015-10-15  09：00",@"2016-10-19  09：00  18：00"],@[@"金融港会议室1  09：30-10：30",@"金融港会议室1  09：30-10：30"]];
    }else{
        titleArr = @[@[@"驳回",@"通过"],@[@"通过",@"通过"]];
        timeArr = @[@[@"2015-10-15  09：00",@"2016-10-19  09：00  18：00"],@[@"2016-09-18  18:00 至 2016-09-18  22:00",@"2016-09-18  18:00 至 2016-09-18  22:00"]];
        shenpiArr = @[@[@"0",@"1"],@[@"1",@"1"]];
    }
    
   
    [cell initWithTitle:titleArr[indexPath.section][indexPath.row] andTime:timeArr[indexPath.section][indexPath.row] andShenPi:shenpiArr[indexPath.section][indexPath.row] andWillOrDo:[NSString stringWithFormat:@"%d",willOrDoTag]];
    
    return cell;
}

- (void)titleBtnClick:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:250+i];
        UIView *view = (UIView *)[self.view viewWithTag:240+i];
        
        if (label.tag-250 == sender.tag-230) {
            label.textColor = RMColor(32, 102, 233);
            view.hidden = NO;
        }else{
            label.textColor = RMColor(77, 77, 77);
            view.hidden = YES;
        }
    }
    
    willOrDoTag = sender.tag-230;
    [mainTableView reloadData];
}



#pragma mark -  tableview分割线与tableview等宽
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(void)viewDidLayoutSubviews{
    
    if ([mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}

@end
