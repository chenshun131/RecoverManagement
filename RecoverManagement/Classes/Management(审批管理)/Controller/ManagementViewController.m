//
//  ManagementViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "ManagementViewController.h"
#import "WillTodoLeaveViewController.h"
#import "ApplyLeaveViewController.h"
#import "WillTodoRetroactiveViewController.h"
#import "ApplyRetroactiveViewController.h"
#import "RMWillTodoAllViewController.h"
#import "RMApplyAllViewController.h"
#import "RMWillToDoWorkOvertimeViewController.h"
#import "RMApplyWorkOvertimeViewController.h"

@interface ManagementViewController ()
{
    UIView *headerV;
    NSMutableArray *numLabelArr;
    
    NSInteger *todoOrApplyTag;//我的待办 0   我的申请 1
}

@end

@implementation ManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.titleLB.text = @"审批管理";
    todoOrApplyTag = 0;
    numLabelArr = [NSMutableArray arrayWithCapacity:0];
    [self setHederView];
    [self setMainView];

}

- (void)setHederView{
    headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 35)];
    headerV.userInteractionEnabled = YES;
    [self.view addSubview:headerV];
    
    NSArray *title = @[@"我的待办",@"我的申请"];
    for (int i = 0; i < 2; i++) {
        UIView *yuanView = [[UIView alloc]initWithFrame:CGRectMake(40, 14, 7, 7)];
        if (i==1) {
            yuanView.frame = CGRectMake(KScreenWidth-120, 14, 7, 7);
        }
        yuanView.backgroundColor = RMColor(32, 102, 233);
        yuanView.layer.cornerRadius = 3.5;
        yuanView.layer.masksToBounds = YES;
        yuanView.tag = 110+i;
        [headerV addSubview:yuanView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yuanView.frame)+8, 10, 65, 15)];
        label.text = title[i];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.tag = 120+i;
        [headerV addSubview:label];
        
        UIButton *titleBtn = [[UIButton alloc]initWithFrame:CGRectMake(yuanView.frame.origin.x, 10, CGRectGetMaxX(label.frame), 15)];
        titleBtn.tag = 100+i;
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:titleBtn];
        
        if (i==0) {
            label.textColor = RMColor(32, 102, 233);
        }else if (i==1){
            yuanView.hidden = YES;
        }
        
    }
}

- (void)setMainView{
    CGFloat width = (KScreenWidth-40)/3;
    NSArray *imageArr = @[@"qingjia",@"buqian",@"jiaban",@"quanbuicon"];
    NSArray *titleArr = @[@"请假",@"补签",@"加班",@"全部"];
    NSArray *numArr = @[@"4",@"2",@"2",@"8"];
    for (int i = 0; i< 4; i++) {
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(15+(width+5)*i, CGRectGetMaxY(headerV.frame)+10, width, width/3*4)];
        if (i==3) {
            bg.frame = CGRectMake(15, CGRectGetMaxY(headerV.frame)+15 + width/3*4, width, width/3*4);
        }
        if (i < 2) {
            bg.backgroundColor = RMColor(0, 148, 214);
            
        }else{
            bg.backgroundColor = RMColor(32, 102, 233);
        }
        bg.userInteractionEnabled = YES;
        [self.view addSubview:bg];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(bg.frame.size.width/2-20, width/3, 40, 40)];
        if (i==0 || i==3) {
            imageV.frame = CGRectMake(bg.frame.size.width/2-20, width/3+2, 40, 35);
        }
        imageV.image = [UIImage imageNamed:imageArr[i]];
        [bg addSubview:imageV];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(7, bg.frame.size.height-20, 30, 15)];
        titleLabel.text = titleArr[i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [bg addSubview:titleLabel];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(bg.frame.size.width-70, bg.frame.size.height-20, 63, 15)];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentRight;
        numLabel.font = [UIFont boldSystemFontOfSize:17];
        numLabel.text = numArr[i];
        [numLabelArr addObject:numLabel];
        [bg addSubview:numLabel];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,bg.frame.size.width , bg.frame.size.height)];
        [btn addTarget:self action:@selector(managementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 130+i;
        [bg addSubview:btn];
        
      
    }
}

- (void)titleBtnClick:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UILabel *label = (UILabel *)[self.view viewWithTag:120+i];
        UIView *view = (UIView *)[self.view viewWithTag:110+i];
        
        if (label.tag-120 == sender.tag-100) {
            label.textColor = RMColor(32, 102, 233);
            view.hidden = NO;
        }else{
            label.textColor = [UIColor whiteColor];
            view.hidden = YES;
        }
    }
    todoOrApplyTag = sender.tag-100;
    NSArray *num;
    if (sender.tag-100 ==0) {
        num = @[@"4",@"2",@"2",@"8"];
    }else{
        num = @[@"3",@"2",@"1",@"6"];
    }
    
    for (UILabel *label in numLabelArr) {
        NSInteger index = [numLabelArr indexOfObject:label];
        label.text = num[index];
    }
}

- (void)managementBtnClick:(UIButton *)sender{
    if (todoOrApplyTag==0) {
        if (sender.tag-130==0) {
            WillTodoLeaveViewController *vc =[[WillTodoLeaveViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (sender.tag-130==1) {
            WillTodoRetroactiveViewController *vc =[[WillTodoRetroactiveViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (sender.tag-130==2) {
            RMWillToDoWorkOvertimeViewController *vc =[[RMWillToDoWorkOvertimeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (sender.tag-130==3) {
            RMWillTodoAllViewController *vc =[[RMWillTodoAllViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
    
        if (sender.tag-130==0) {
            ApplyLeaveViewController *vc =[[ApplyLeaveViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (sender.tag-130==1) {
            ApplyRetroactiveViewController *vc =[[ApplyRetroactiveViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (sender.tag-130==2) {
            RMApplyWorkOvertimeViewController *vc =[[RMApplyWorkOvertimeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (sender.tag-130==3) {
            RMApplyAllViewController *vc =[[RMApplyAllViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
}
@end
