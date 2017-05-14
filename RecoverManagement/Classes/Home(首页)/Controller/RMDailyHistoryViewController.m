//
//  RMDailyHistoryViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMDailyHistoryViewController.h"
#import "RMDailyHistoryTableViewCell.h"
#import "RMDatePicker.h"

@interface RMDailyHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mainTableView;
    
    NSArray *timeArr;
    NSArray *dataArr;
}

@end

@implementation RMDailyHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日报历史";
   
    
    timeArr = @[@"2016-10-17",@"2016-10-16",@"2016-10-15",@"2016-10-15"];
    dataArr = @[@[@"回收哥App-4h",@"空闲-4h"],@[@"回收哥App-4h",@"空闲-4h"],@[@"回收哥App-8h"],@[@"回收哥App-4h"]];
    
    [self setHeaderView];
    [self setMainView];
}

- (void)leftBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
    headerView.backgroundColor  = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    UIImageView *timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 20, 20)];
    timeImageView.image = [UIImage imageNamed:@"shijian"];
    [headerView addSubview:timeImageView];
    
    for (int i = 0; i < 2; i++) {
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.textColor = LMColor(233, 90, 0);
        timeLabel.font = [UIFont systemFontOfSize:15];
        if (i==0) {
            timeLabel.frame = CGRectMake(KScreenWidth/2-132, 12, 90, 20);
            timeLabel.text = @"2016-10-01";
            timeLabel.textAlignment = NSTextAlignmentRight;
        }else if (i==1){
            timeLabel.frame = CGRectMake(KScreenWidth/2+31, 12, 90, 20);
            timeLabel.text = @"2106-10-18";
            timeLabel.textAlignment = NSTextAlignmentLeft;
            [timeLabel sizeToFit];
        }
        
        [headerView addSubview:timeLabel];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame)+5,  18, 12, 8)];
        imageView.image=[UIImage imageNamed:@"xialajiantou"];
        [headerView addSubview:imageView];
        
        UILabel *zhiLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2, 12, 16, 20)];
        zhiLabel.text = @"至";
        zhiLabel.textColor = LMColor(120, 120, 120);
        zhiLabel.textAlignment = NSTextAlignmentCenter;
        zhiLabel.font = [UIFont systemFontOfSize:15];
        [headerView addSubview:zhiLabel];
    
        UIButton *timeBtn = [[UIButton alloc]initWithFrame:CGRectMake(timeLabel.frame.origin.x, timeLabel.frame.origin.y, 110, 20)];
        [timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        timeBtn.tag = 310+i;
        [headerView addSubview:timeBtn];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, 1)];
    line.backgroundColor =RMColor(240, 240, 240);
    [headerView  addSubview:line];
    
}

- (void)timeBtnClick:(UIButton *)sender{
    RMDatePicker * datePicker = [RMDatePicker pickerWithOwnNib];
    WS(weakSelf)
    datePicker.doneBlock =  ^(NSString * str){
        
        [mainTableView  reloadData];
        return YES;
    };
    [datePicker show];

}


- (void)setMainView{
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, KScreenWidth, KScreenHeight-64-45) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = RMColor(249, 249, 249);
    mainTableView.separatorColor =RMColor(240, 240, 240);
    [self.view addSubview:mainTableView];
}

#pragma mark -- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return timeArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 35)];
    head.backgroundColor = [UIColor whiteColor];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 35)];
    timeLabel.text = timeArr[section];
    timeLabel.textColor = LMColor(102, 139, 237);
    timeLabel.font = [UIFont systemFontOfSize:14];
    [head addSubview:timeLabel];
    
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identi = @"cell";
    RMDailyHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identi];
    if (!cell) {
        cell = [[RMDailyHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell initWithTitle:dataArr[indexPath.section][indexPath.row] andContent:@""];
    
    return cell;

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
