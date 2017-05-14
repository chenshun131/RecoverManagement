//
//  ApplyRetroactiveViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "ApplyRetroactiveViewController.h"
#import "RMApplyRetroactiveTableViewCell.h"
#import "RMApplyRetroApprovalViewController.h"

@interface ApplyRetroactiveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *headerV;
    UITableView *mainTableView;
    NSInteger *willOrDoneTag;//未审批 0   已审批 1
}


@end

@implementation ApplyRetroactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLB.text = @"我申请-补签";
    [self addLeftView:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    willOrDoneTag = 0;
    [self setHederView];
    [self setMainView];

}

- (void)leftBtnClick:(UIButton *)sender{
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
        yuanView.tag = 210+i;
        [headerV addSubview:yuanView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yuanView.frame)+8, 15, 65, 15)];
        label.text = title[i];
        //        label.textColor = RMColor(77, 77, 77);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.tag = 220+i;
        [headerV addSubview:label];
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(yuanView.frame.origin.x, 15, CGRectGetMaxX(label.frame), 15)];
        titleBtn.tag = 200+i;
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
    return 2;
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
    RMApplyRetroactiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[RMApplyRetroactiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    NSArray *timeArr = @[@"2016-10-19",@"2016-10-18"];
    NSArray *addressArr = @[@"金融港办公一",@"金融港办公一"];
    NSArray *retroTimeArr = @[@"09: 00  18: 00",@"09: 00"];
    NSArray *setupTimeArr = @[@"2016-09-18",@"2016-09-18"];
    NSArray *shenpiArr = @[@"人事审批",@"上级审批"];
    NSArray *shenpiResultArr = @[@"0",@"1"];
    
    [cell initWithTime:timeArr[indexPath.row] andAddress:addressArr[indexPath.row] andRetroTime:retroTimeArr[indexPath.row] andSetupTime:setupTimeArr[indexPath.row] andShenPi:shenpiArr[indexPath.row] andShenpiResult:shenpiResultArr[indexPath.row] andWillOrDo:[NSString stringWithFormat:@"%d",willOrDoneTag]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMApplyRetroApprovalViewController *vc =[[RMApplyRetroApprovalViewController  alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)titleBtnClick:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:220+i];
        UIView *view = (UIView *)[self.view viewWithTag:210+i];
        
        if (label.tag-220 == sender.tag-200) {
            label.textColor = RMColor(32, 102, 233);
            view.hidden = NO;
        }else{
            label.textColor = RMColor(77, 77, 77);
            view.hidden = YES;
        }
    }
    
    willOrDoneTag = sender.tag-200;
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
