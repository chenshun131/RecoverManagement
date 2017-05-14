//
//  RMContactInformationViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/7.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMContactInformationViewController.h"
#import "RMPersonerTableViewCell.h"
#import "RMShapedImageView.h"

@interface RMContactInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *headerView;
    UITableView *mainTableView;
    
    UIImageView *touxiangImageV;
}


@end

@implementation RMContactInformationViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeaderView];
    [self setMainView];
}

- (void)leftBtnAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setHeaderView{
    headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    headerView.image = [UIImage imageNamed:@"bg2"];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, 30, 25)];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftBtn];
    
    
    UIImageView *touxiangKuangImageV = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-70)/2, 74, 70, 70)];
    touxiangKuangImageV.image = [UIImage imageNamed:@"yuan-bt"];
    
    [headerView addSubview:touxiangKuangImageV];
    
    touxiangImageV = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 66, 66)];
    touxiangImageV.image = [UIImage imageNamed:@"touxiang"];
    touxiangImageV.layer.cornerRadius = 32;
    touxiangImageV.layer.masksToBounds = YES;
    [touxiangKuangImageV addSubview:touxiangImageV];
    
    [touxiangKuangImageV addSubview:touxiangImageV];

    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(touxiangKuangImageV.frame)+10, KScreenWidth-30, 20)];
    nameLabel.text = @"陈曦";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    [headerView addSubview:nameLabel];
    
    UILabel *positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(nameLabel.frame)+5, KScreenWidth-30, 20)];
    positionLabel.text = @"研发部-Java开发程序员";
    positionLabel.textColor = [UIColor whiteColor];
    positionLabel.textAlignment = NSTextAlignmentCenter;
    positionLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:positionLabel];
    
}

- (void)setMainView{
    mainTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), KScreenWidth, KScreenHeight-50-headerView.frame.size.height) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = RMColor(249, 249, 249);
    mainTableView.separatorColor =RMColor(240, 240, 240);
    [self.view addSubview:mainTableView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-50, KScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];
    
    NSArray *imageArr = @[@"faxiaoxi",@"dadianhua"];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2*i, 0, KScreenWidth/2, 50)];
        [btn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag  = 350+i;
        [bottomView addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/4-13, 12, 26, 26)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [btn addSubview:imageView];
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth/2, 10, 1, 30)];
    line.backgroundColor = LMColor(220, 220, 220);
    [bottomView addSubview:line];
    
}

#pragma mark -- 发消息或者打电话
- (void)contactBtnClick:(UIButton *)sender{
      if (sender.tag==350) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://10000"]];
    }else if (sender.tag==351) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
    }
    
}

#pragma mark -- tableView
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
   
        return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        static NSString *cellName = @"idenifier";
        RMPersonerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if(cell == nil)
        {
            cell = [[RMPersonerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor  =[UIColor whiteColor];
        
    NSArray *titleArr = @[@"电话",@"邮箱"];
    
    NSArray *imageArr = @[@"dianhuaiconlan",@"youxiangiconlan"];
    NSArray *arr = @[@"18686868888",@"zhangs@hsg.com.cn"];
    
    [cell initWithIndex:indexPath.row andImageName:imageArr[indexPath.row] andData:arr[indexPath.row] andTitle:titleArr[indexPath.row] andCanEdit:NO];
    
        return cell;
        
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
