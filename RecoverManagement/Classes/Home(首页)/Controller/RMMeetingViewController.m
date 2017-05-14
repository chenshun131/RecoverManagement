//
//  RMMeetingViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/15.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMMeetingViewController.h"
#import "RMApplyAllTableViewCell.h"
@interface RMMeetingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *mainTableView;

}


@end

@implementation RMMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self setMainView];
}
- (void)setMainView{
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-45) style:UITableViewStyleGrouped];
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
    NSArray *arr = @[@"待参加会议",@"会议邀请"];
    
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
    if (indexPath.row==0) {
        titleArr = @[@[@"HR审批",@"上级领导审批"],@[@"上级领导审批",@"HR审批"]];
        timeArr = @[@[@"2015-10-15  09：00",@"2016-10-19  09：00  18：00"],@[@"金融港会议室1  09：30-10：30",@"金融港会议室1  09：30-10：30"]];
    }else{
        titleArr = @[@[@"驳回",@"通过"],@[@"通过",@"通过"]];
        timeArr = @[@[@"2015-10-15  09：00",@"2016-10-19  09：00  18：00"],@[@"2016-09-18  18:00 至 2016-09-18  22:00",@"2016-09-18  18:00 至 2016-09-18  22:00"]];
    }
    
    
    [cell initWithTitle:titleArr[indexPath.section][indexPath.row] andTime:timeArr[indexPath.section][indexPath.row] andShenPi:@"" andWillOrDo:nil];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
