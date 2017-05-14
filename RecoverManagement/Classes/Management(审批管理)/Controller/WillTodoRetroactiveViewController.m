//
//  WillTodoRetroactiveViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "WillTodoRetroactiveViewController.h"
#import "RMWillTodoLeaveTableViewCell.h"
#import "RMWillTodoRetroApprovalViewController.h"
#import "RMApprovalViewController.h"
#import "RMVetoViewController.h"

@interface WillTodoRetroactiveViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *headerV;
    UITableView *mainTableView;
    NSInteger *willOrDoneTag;//未审批 0   已审批 1
    
    UIView *bottomView;
    UIButton *selectAllBtn;//全选
    
     NSMutableArray *dataArr;
}


@end

@implementation WillTodoRetroactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"我的待办-补签审批";
    [self addLeftView:@""];

    self.view.backgroundColor = [UIColor whiteColor];
    willOrDoneTag = 0;
    [self setHederView];
    [self setMainView];
    
    dataArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<2; i++) {
        RMSelectModel *model = [[RMSelectModel alloc]init];
        [dataArr addObject:model];
        
    }

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
        yuanView.tag = 180+i;
        [headerV addSubview:yuanView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yuanView.frame)+8, 15, 65, 15)];
        label.text = title[i];
        //        label.textColor = RMColor(77, 77, 77);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.tag = 190+i;
        [headerV addSubview:label];
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(yuanView.frame.origin.x, 15, CGRectGetMaxX(label.frame), 15)];
        titleBtn.tag = 170+i;
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
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, KScreenWidth, KScreenHeight-64-45-50) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorColor = RMColor(230, 230, 230);
    mainTableView.backgroundColor = RMColor(249, 249, 249);
    
    [self.view addSubview:mainTableView];
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    
    selectAllBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    [selectAllBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [selectAllBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    
    [bottomView addSubview:selectAllBtn];
    
    UILabel *selectAllLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectAllBtn.frame)+15, 15, 35, 20)];
    selectAllLabel.text = @"全选";
    selectAllLabel.textAlignment = NSTextAlignmentLeft;
    selectAllLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:selectAllLabel];
    
    UIButton *selectAllButton = [[UIButton alloc]initWithFrame:CGRectMake(selectAllBtn.frame.origin.x, selectAllBtn.frame.origin.y, CGRectGetMaxX(selectAllLabel.frame), 20)];
    [selectAllButton addTarget:self action:@selector(selectAllButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:selectAllButton];
    
    NSArray *buttonArr = @[@"否决",@"通过"];
    for (int i = 0; i<buttonArr.count; i++) {
        UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-83*(2-i), 0, 85, 50)];
        [bottomBtn setTitle:buttonArr[i] forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (i==0) {
            bottomBtn.backgroundColor =LMColor(231, 65, 47);
            
        }else if (i==1) {
            bottomBtn.backgroundColor = LMColor(26, 164, 83);
        }
        bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        bottomBtn.tag = 320+i;
        [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bottomBtn];
    }
    
}

- (void)selectAllButtonClick:(UIButton *)sender{
    selectAllBtn.selected = !selectAllBtn.selected;
    
    for(int i=0;i<dataArr.count;i++){
        RMSelectModel *model = dataArr[i];
        model.isSelect = selectAllBtn.selected;
        
        
    }
    
    [mainTableView reloadData];
}

- (void)bottomBtnClick:(UIButton *)sender{
    if (sender.tag == 320) {
        RMVetoViewController *vc = [[RMVetoViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.state = @"补签";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 321){
        RMApprovalViewController *vc = [[RMApprovalViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.state = @"补签";
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (willOrDoneTag ==0) {
        return 2;
    }else{
        return 4;
    }
    ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identi = @"cell";
    RMWillTodoLeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[RMWillTodoLeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    NSArray *nameArr;
    NSArray *timeArr;
    NSArray *shenpiArr;
    RMSelectModel *model;
    if (willOrDoneTag ==0) {
        nameArr = @[@"三石补签",@"兮兮补签"];
        timeArr = @[@"2015-08-23  09：30",@"2015-08-23  09：30"];
        model = dataArr[indexPath.row];
    }else{
        nameArr = @[@"佳佳加班",@"Monica加班",@"佳佳加班",@"Monica加班"];
        timeArr = @[@"2015-08-23  09：30",@"2015-08-23  09：30",@"2015-08-19  09：30",@"2015-08-19  09：30"];
        shenpiArr = @[@"1",@"0",@"1",@"1"];
    }
    
    [cell initWithName:nameArr[indexPath.row] andTime:timeArr[indexPath.row] andShenPi:shenpiArr[indexPath.row] andWillOrDo:[NSString stringWithFormat:@"%d",willOrDoneTag]andChooseState:model.isSelect];
    if (willOrDoneTag == 0) {
        cell.chooseBtn.tag = 200+indexPath.row;
        cell.cellSelectButton.tag = 300+indexPath.row;
        [cell.cellSelectButton addTarget:self action:@selector(cellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    return cell;
}

#pragma mark -- cell selected
- (void)cellSelectButtonClick:(UIButton *)sender{
    
    UIButton *btn = sender;
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:sender.tag-100];
    
    btn.selected = !btn.selected;
    btn2.selected = !btn2.selected;
    
    
    if (btn.tag == sender.tag) {
        RMSelectModel *model =  dataArr[sender.tag-300];
        model.isSelect = btn2.selected;
        
        for (RMSelectModel *model3 in dataArr) {
            if (model3.isSelect == YES) {
                selectAllBtn.selected = YES;
            }
        }
        
        for (RMSelectModel *model3 in dataArr) {
            if (model3.isSelect == NO) {
              selectAllBtn.selected = NO;
               
            }
        }
        
        [mainTableView reloadData];
    }

}

- (void)titleBtnClick:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:190+i];
        UIView *view = (UIView *)[self.view viewWithTag:180+i];
        
        if (label.tag-190 == sender.tag-170) {
            label.textColor = RMColor(32, 102, 233);
            view.hidden = NO;
        }else{
            
            label.textColor = RMColor(77, 77, 77);
            view.hidden = YES;
        }
    }
    
    willOrDoneTag = sender.tag-170;
    
    if (willOrDoneTag==0) {
        
        mainTableView.frame  = CGRectMake(0, 64+45, KScreenWidth, KScreenHeight-109-50);
        
        bottomView.hidden = NO;
    }else{
        mainTableView.frame  = CGRectMake(0, 64+45, KScreenWidth, KScreenHeight-109);
        bottomView.hidden = YES;
        
    }
    [mainTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMWillTodoRetroApprovalViewController *vc = [[RMWillTodoRetroApprovalViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.state = @"补签";
    [self.navigationController pushViewController:vc animated:YES];
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
