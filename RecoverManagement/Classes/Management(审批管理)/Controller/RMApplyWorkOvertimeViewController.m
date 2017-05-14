//
//  RMApplyWorkOvertimeViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/10.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApplyWorkOvertimeViewController.h"
#import "ApplyLeaveTableViewCell.h"

@interface RMApplyWorkOvertimeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *headerV;
    UITableView *mainTableView;
    NSInteger *willOrDoneTag;//未审批 0   已审批 1
}

@end

@implementation RMApplyWorkOvertimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"我申请-加班";
    [self addLeftView:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    willOrDoneTag = 0;
    [self setHederView];
    [self setMainView];

    
}

-(void)leftBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 未审批 已审批
- (void)setHederView{
    headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 45)];
    headerV.userInteractionEnabled = YES;
    [self.view addSubview:headerV];
    
    NSArray *title = @[@"审批中",@"已审批"];
    for (int i = 0; i < 2; i++) {
        UIView *yuanView = [[UIView alloc]initWithFrame:CGRectMake(40, 19, 7, 7)];
        if (i==1) {
            yuanView.frame = CGRectMake(KScreenWidth-120, 19, 7, 7);
        }
        yuanView.backgroundColor = RMColor(32, 102, 233);
        yuanView.layer.cornerRadius = 3.5;
        yuanView.layer.masksToBounds = YES;
        yuanView.tag = 150+i;
        [headerV addSubview:yuanView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yuanView.frame)+8, 15, 65, 15)];
        label.text = title[i];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.tag = 160+i;
        [headerV addSubview:label];
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(yuanView.frame.origin.x, 15, CGRectGetMaxX(label.frame), 15)];
        titleBtn.tag = 140+i;
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:titleBtn];
        
        if (i==0) {
            label.textColor = RMColor(32, 102, 233);
        }else if (i==1){
            yuanView.hidden = YES;
        }
        
    }
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identi = @"cell";
    ApplyLeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[ApplyLeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArr = @[@"加班",@"加班",@"加班"];
    NSArray *startTimeArr;
    NSArray *endTimeArr;
    NSArray *setupTimeArr;
    if (willOrDoneTag ==0) {
        startTimeArr = @[@"2016-10-18  18: 00",@"2016-09-17  18: 00",@"2016-09-17  18: 00"];
        endTimeArr = @[@"2016-10-18  21: 00",@"2016-09-18  01: 00",@"2016-09-17  22: 00"];
        setupTimeArr = @[@"2016-09-18",@"2016-09-17",@"2016-09-17"];

    }else{
        startTimeArr = @[@"2016-10-17  18: 00",@"2016-09-15  18: 00",@"2016-09-12  18: 00"];
        endTimeArr = @[@"2016-10-18  01: 00",@"2016-09-15  22: 00",@"2016-09-12  19: 00"];
        setupTimeArr = @[@"2016-09-17",@"2016-09-15",@"2016-09-12"];
    
    }
    
    NSArray *shenpiArr = @[@"人事审批",@"上级审批",@"上级审批"];
    NSArray *shenpiResultArr = @[@"0",@"1",@"1"];
    
    [cell initWithTitle:titleArr[indexPath.row] andStartTime:startTimeArr[indexPath.row] andEndTime:endTimeArr[indexPath.row] andSetupTime:setupTimeArr[indexPath.row] andShenPi:shenpiArr[indexPath.row] andShenPiResult:shenpiResultArr[indexPath.row] andWillOrDo:[NSString stringWithFormat:@"%d",willOrDoneTag]];
    
    return cell;
}

- (void)titleBtnClick:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:160+i];
        UIView *view = (UIView *)[self.view viewWithTag:150+i];
        
        if (label.tag-160 == sender.tag-140) {
            label.textColor = RMColor(32, 102, 233);
            view.hidden = NO;
        }else{
            label.textColor = RMColor(77, 77, 77);
            view.hidden = YES;
        }
    }
    
    willOrDoneTag = sender.tag-140;
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
