//
//  RMApplyRetroApprovalViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApplyRetroApprovalViewController.h"

@interface RMApplyRetroApprovalViewController ()<UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
    
    UIView *documentsBgView;//单据详情
    UIView *shenPiBgView;//审批进度
    
    UIView *headerView;
    NSInteger *willOrDoTag;//未审批 0   已审批 1


}


@end

@implementation RMApplyRetroApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"我的申请-补签审批";
    [self addLeftView:@""];
    
    self.view.backgroundColor = RMColor(249, 249, 249);
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
    
    NSArray *title = @[@"单据详情",@"审批进度"];
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
        label.font = [UIFont systemFontOfSize:15];
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
    mainScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+45, KScreenWidth, KScreenHeight-109)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = RMColor(249, 249, 249);
    mainScrollView.userInteractionEnabled = YES;
    mainScrollView.showsVerticalScrollIndicator = FALSE;
    [self.view addSubview:mainScrollView];
    
    [self setDocumentsView];
    [self setShenPiView];
    
}

- (void)setDocumentsView{
    documentsBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 500)];
    [mainScrollView addSubview:documentsBgView];
    
    NSArray *firstTitleArr = @[@"申请编号：",@"申请时间："];
    NSArray *firstResultsArr = @[@"BQ-2016-0001",@"2016-09-01  14:05"];
    NSArray *secondTitleArr = @[@"补签日期：",@"补签地点：",@"补签时间：",@"补签说明："];
    NSArray *secondResultsArr = @[@"2016-08-26  星期五",@"金融港办公点1",@"09:00  18:00",@"早上准时到公司，但是忘记了打卡了。"];
    NSArray *thirdTitleArr = @[@"当前步骤：",@"流程状态：",@"审批人    ："];
    NSArray *thirdResultsArr = @[@"领导审批",@"审批中",@"上级领导"];
    
    //一
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, KScreenWidth-30, 50)];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.layer.cornerRadius = 2;
    firstView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    firstView.layer.borderWidth = 1;
    [documentsBgView addSubview:firstView];
    
    UILabel *firstResultLabel;
    for (int i =0 ; i < firstTitleArr.count; i++) {
        UILabel *firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
        
        firstTitleLabel.text = firstTitleArr[i];
        firstTitleLabel.textAlignment = NSTextAlignmentLeft;
        firstTitleLabel.font = [UIFont systemFontOfSize:15];
        [firstView addSubview:firstTitleLabel];
        
        firstResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, firstTitleLabel.frame.origin.y, KScreenWidth-140, 15)];
        firstResultLabel.text = firstResultsArr[i];
        firstResultLabel.textColor = RMColor(80, 80, 80);
        firstResultLabel.textAlignment = NSTextAlignmentRight;
        firstResultLabel.font = [UIFont systemFontOfSize:15];
        
        [firstView addSubview:firstResultLabel];
        
    }
    
    firstView.frame = CGRectMake(15, 10, KScreenWidth-30, CGRectGetMaxY(firstResultLabel.frame)+15);
    
    //二
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(firstView.frame)+10, KScreenWidth-30, 50)];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.layer.cornerRadius = 2;
    secondView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    secondView.layer.borderWidth = 1;
    [documentsBgView addSubview:secondView];
    
    //计算补签说明与其数据总共所占的高度
    NSString *text  = [NSString stringWithFormat:@"%@ %@",secondTitleArr[3],secondResultsArr[3]];
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(KScreenWidth-50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    //如果补签说明的高度大于15，它的格式就与其他不同
    NSInteger num = 0;
    if(titleSize.height > 18){
        num = secondTitleArr.count-1;
    }else{
        num = secondTitleArr.count;
    }

    UILabel *secondResultLabel;
    for (int i =0 ; i < secondTitleArr.count; i++) {
        if (i<num) {
            UILabel *secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
            secondTitleLabel.text = secondTitleArr[i];
            secondTitleLabel.textAlignment = NSTextAlignmentLeft;
            secondTitleLabel.font = [UIFont systemFontOfSize:15];
            [secondView addSubview:secondTitleLabel];
            
            secondResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, secondTitleLabel.frame.origin.y, KScreenWidth-140, 15)];
            secondResultLabel.text = secondResultsArr[i];
            secondResultLabel.textColor = RMColor(80, 80, 80);
            secondResultLabel.textAlignment = NSTextAlignmentRight;
            secondResultLabel.font = [UIFont systemFontOfSize:15];
            [secondView addSubview:secondResultLabel];
        }else{
            secondResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, KScreenWidth-50, 100)];
            secondResultLabel.text = [NSString stringWithFormat:@"%@ %@",secondTitleArr[i],secondResultsArr[i]];
            secondResultLabel.textAlignment = NSTextAlignmentLeft;
            secondResultLabel.font = [UIFont systemFontOfSize:15];
            
            NSRange range1 = [secondResultLabel.text rangeOfString:secondResultsArr[i]];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:secondResultLabel.text];
            [attStr addAttribute:NSForegroundColorAttributeName value:RMColor(80, 80, 80) range:range1];
            secondResultLabel.attributedText = attStr;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];//行间距
            [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [secondResultLabel.text length])];
            secondResultLabel.attributedText = attStr;
            
            secondResultLabel.numberOfLines = 0;
            [secondResultLabel sizeToFit];
            [secondView addSubview:secondResultLabel];
        }
        
        
    }
    
    secondView.frame = CGRectMake(15, CGRectGetMaxY(firstView.frame)+10, KScreenWidth-30, CGRectGetMaxY(secondResultLabel.frame)+15);
    
    //三
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(secondView.frame)+ 10, KScreenWidth-30, 50)];
    thirdView.backgroundColor = [UIColor whiteColor];
    thirdView.layer.cornerRadius = 2;
    thirdView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    thirdView.layer.borderWidth = 1;
    [documentsBgView addSubview:thirdView];
    
    UILabel *thirdResultLabel;
    for (int i =0 ; i < thirdTitleArr.count; i++) {
        UILabel *thirdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
        thirdTitleLabel.text = thirdTitleArr[i];
        thirdTitleLabel.textAlignment = NSTextAlignmentLeft;
        thirdTitleLabel.font = [UIFont systemFontOfSize:15];
        [thirdView addSubview:thirdTitleLabel];
        
        thirdResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, thirdTitleLabel.frame.origin.y, KScreenWidth-140, 15)];
        thirdResultLabel.text = thirdResultsArr[i];
        if (i==1) {
            thirdResultLabel.textColor = RMColor(233, 87, 0);
        }else{
            thirdResultLabel.textColor = RMColor(80, 80, 80);
        }
        
        thirdResultLabel.textAlignment = NSTextAlignmentRight;
        thirdResultLabel.font = [UIFont systemFontOfSize:15];
        
        [thirdView addSubview:thirdResultLabel];
        
    }
    
    thirdView.frame = CGRectMake(15, CGRectGetMaxY(secondView.frame)+ 10, KScreenWidth-30, CGRectGetMaxY(thirdResultLabel.frame)+15);
    
    documentsBgView.frame = CGRectMake(0, 0, KScreenWidth, CGRectGetMaxY(thirdView.frame)+10);
    
    mainScrollView.contentSize = CGSizeMake(KScreenWidth,CGRectGetMaxY(documentsBgView.frame));
   
}

- (void)setShenPiView{
    shenPiBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 500)];
    shenPiBgView.hidden = YES;
    [mainScrollView addSubview:shenPiBgView];
    
    NSArray *titleArr = @[@"发起审批流程",@"人事审批",@"上级审批",@"审批结果"];
    NSArray *timeArr = @[@"2016-09-26  17:00",@"2016-09-26  18:15"];
    
    NSArray *firstTitleArr = @[@"申请编号："];
    NSArray *firstResultsArr = @[@"BQ-2016-0001"];
    NSArray *secondTitleArr = @[@"审批人：",@"审批意见：",@"审批用时：",@"审批说明："];
    NSArray *secondResultsArr = @[@"HR组",@"通过",@"01:15:00",@"无"];
    NSArray *thirdTitleArr = @[@"审批人    ：",@"审批意见："];
    NSArray *thirdResultsArr = @[@"上级领导",@"未审批"];
    NSArray *fourthTitleArr = @[@"审批结果："];
    NSArray *fourthResultsArr = @[@"待定"];
    
    
    //一
    UILabel *firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 150, 15)];
    firstTitleLabel.text = titleArr[0];
    firstTitleLabel.textColor = LMColor(32, 102, 233);
    firstTitleLabel.font = [UIFont systemFontOfSize:13];
    [shenPiBgView addSubview:firstTitleLabel];
    
    UILabel *firstTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(firstTitleLabel.frame)+3, 150, 12)];
    firstTimeLabel.text = timeArr[0];
    firstTimeLabel.textColor = LMColor(150, 150, 150);
    firstTimeLabel.font = [UIFont systemFontOfSize:11];
    [shenPiBgView addSubview:firstTimeLabel];

    
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(25, 40, KScreenWidth-40, 50)];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.layer.cornerRadius = 2;
    firstView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    firstView.layer.borderWidth = 1;
    [shenPiBgView addSubview:firstView];
    
    UILabel *firstResultLabel;
    for (int i =0 ; i < firstTitleArr.count; i++) {
        UILabel *firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
        
        firstTitleLabel.text = firstTitleArr[i];
        firstTitleLabel.textAlignment = NSTextAlignmentLeft;
        firstTitleLabel.font = [UIFont systemFontOfSize:15];
        [firstView addSubview:firstTitleLabel];
        
        firstResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, firstTitleLabel.frame.origin.y, KScreenWidth-150, 15)];
        firstResultLabel.text = firstResultsArr[i];
        firstResultLabel.textColor = RMColor(80, 80, 80);
        firstResultLabel.textAlignment = NSTextAlignmentRight;
        firstResultLabel.font = [UIFont systemFontOfSize:15];
        
        [firstView addSubview:firstResultLabel];
        
    }
    
    firstView.frame = CGRectMake(25, 40, KScreenWidth-40, CGRectGetMaxY(firstResultLabel.frame)+15);
    
    //二
    UILabel *secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(firstView.frame)+5, 150, 15)];
    secondTitleLabel.text = titleArr[1];
    secondTitleLabel.textColor = LMColor(32, 102, 233);
    secondTitleLabel.font = [UIFont systemFontOfSize:13];
    [shenPiBgView addSubview:secondTitleLabel];
    
    UILabel *secondTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(secondTitleLabel.frame)+3, 150, 12)];
    secondTimeLabel.text = timeArr[1];
    secondTimeLabel.textColor = LMColor(150, 150, 150);
    secondTimeLabel.font = [UIFont systemFontOfSize:11];
    [shenPiBgView addSubview:secondTimeLabel];

    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(firstView.frame)+40, KScreenWidth-40, 50)];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.layer.cornerRadius = 2;
    secondView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    secondView.layer.borderWidth = 1;
    [shenPiBgView addSubview:secondView];
    
    //计算审批说明与其数据总共所占的高度
    NSString *text  = [NSString stringWithFormat:@"%@ %@",secondTitleArr[3],secondResultsArr[3]];
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(KScreenWidth-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    //如果审批说明的高度大于15，它的格式就与其他不同
    NSInteger num = 0;
    if(titleSize.height > 18){
        num = secondTitleArr.count-1;
    }else{
        num = secondTitleArr.count;
    }
    
    UILabel *secondResultLabel;
    for (int i =0 ; i < secondTitleArr.count; i++) {
        if (i<num) {
            UILabel *secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
            secondTitleLabel.text = secondTitleArr[i];
            secondTitleLabel.textAlignment = NSTextAlignmentLeft;
            secondTitleLabel.font = [UIFont systemFontOfSize:15];
            [secondView addSubview:secondTitleLabel];
            
            secondResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, secondTitleLabel.frame.origin.y, KScreenWidth-150, 15)];
            secondResultLabel.text = secondResultsArr[i];
            if (i==1) {
                secondResultLabel.textColor = RMColor(233, 87, 0);
            }else{
                secondResultLabel.textColor = RMColor(80, 80, 80);
            }
            
            secondResultLabel.textAlignment = NSTextAlignmentRight;
            secondResultLabel.font = [UIFont systemFontOfSize:15];
            [secondView addSubview:secondResultLabel];
        }else{
            secondResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, KScreenWidth-60, 100)];
            secondResultLabel.text = [NSString stringWithFormat:@"%@ %@",secondTitleArr[i],secondResultsArr[i]];
            secondResultLabel.textAlignment = NSTextAlignmentLeft;
            secondResultLabel.font = [UIFont systemFontOfSize:15];
            
            NSRange range1 = [secondResultLabel.text rangeOfString:secondResultsArr[i]];
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:secondResultLabel.text];
            [attStr addAttribute:NSForegroundColorAttributeName value:RMColor(80, 80, 80) range:range1];
            secondResultLabel.attributedText = attStr;
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];//行间距
            [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [secondResultLabel.text length])];
            secondResultLabel.attributedText = attStr;
            
            secondResultLabel.numberOfLines = 0;
            [secondResultLabel sizeToFit];
            [secondView addSubview:secondResultLabel];
        }
        
        
    }
    
    secondView.frame = CGRectMake(25, CGRectGetMaxY(firstView.frame)+40, KScreenWidth-40, CGRectGetMaxY(secondResultLabel.frame)+15);
    
    //三
    UILabel *thirdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(secondView.frame)+8, 150, 15)];
    thirdTitleLabel.text = titleArr[2];
    thirdTitleLabel.textColor = LMColor(32, 102, 233);
    thirdTitleLabel.font = [UIFont systemFontOfSize:13];
    [shenPiBgView addSubview:thirdTitleLabel];
    
    UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(25,CGRectGetMaxY(secondView.frame)+ 30, KScreenWidth-40, 50)];
    thirdView.backgroundColor = [UIColor whiteColor];
    thirdView.layer.cornerRadius = 2;
    thirdView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    thirdView.layer.borderWidth = 1;
    [shenPiBgView addSubview:thirdView];
    
    UILabel *thirdResultLabel;
    for (int i =0 ; i < thirdTitleArr.count; i++) {
        UILabel *thirdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
        thirdTitleLabel.text = thirdTitleArr[i];
        thirdTitleLabel.textAlignment = NSTextAlignmentLeft;
        thirdTitleLabel.font = [UIFont systemFontOfSize:15];
        [thirdView addSubview:thirdTitleLabel];
        
        thirdResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, thirdTitleLabel.frame.origin.y, KScreenWidth-150, 15)];
        thirdResultLabel.text = thirdResultsArr[i];
        thirdResultLabel.textColor = RMColor(80, 80, 80);
        thirdResultLabel.textAlignment = NSTextAlignmentRight;
        thirdResultLabel.font = [UIFont systemFontOfSize:15];
        
        [thirdView addSubview:thirdResultLabel];
        
    }
    
    thirdView.frame = CGRectMake(25, CGRectGetMaxY(secondView.frame)+ 30, KScreenWidth-40, CGRectGetMaxY(thirdResultLabel.frame)+15);
    
    //四
    UILabel *fourthTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(thirdView.frame)+8, 150, 15)];
    fourthTitleLabel.text = titleArr[3];
    fourthTitleLabel.textColor = LMColor(32, 102, 233);
    fourthTitleLabel.font = [UIFont systemFontOfSize:13];
    [shenPiBgView addSubview:fourthTitleLabel];

    UIView *fourthView = [[UIView alloc]initWithFrame:CGRectMake(25,CGRectGetMaxY(thirdView.frame)+ 30, KScreenWidth-40, 50)];
    fourthView.backgroundColor = [UIColor whiteColor];
    fourthView.layer.cornerRadius = 2;
    fourthView.layer.borderColor = RMColor(225, 225, 225).CGColor;
    fourthView.layer.borderWidth = 1;
    [shenPiBgView addSubview:fourthView];
    
    UILabel *fourthResultLabel;
    for (int i =0 ; i < fourthTitleArr.count; i++) {
        UILabel *fourthTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15+25*i, 80, 15)];
        fourthTitleLabel.text = fourthTitleArr[i];
        fourthTitleLabel.textAlignment = NSTextAlignmentLeft;
        fourthTitleLabel.font = [UIFont systemFontOfSize:15];
        [fourthView addSubview:fourthTitleLabel];
        
        fourthResultLabel  = [[UILabel alloc]initWithFrame:CGRectMake(100, fourthTitleLabel.frame.origin.y, KScreenWidth-150, 15)];
        fourthResultLabel.text = fourthResultsArr[i];
        fourthResultLabel.textColor = RMColor(80, 80, 80);
        
        
        fourthResultLabel.textAlignment = NSTextAlignmentRight;
        fourthResultLabel.font = [UIFont systemFontOfSize:15];
        
        [fourthView addSubview:fourthResultLabel];
        
    }
    
    fourthView.frame = CGRectMake(25, CGRectGetMaxY(thirdView.frame)+ 30, KScreenWidth-40, CGRectGetMaxY(fourthResultLabel.frame)+15);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 1, CGRectGetMaxY(fourthView.frame)+10)];
    line.backgroundColor = LMColor(220, 220, 220);
    [shenPiBgView addSubview:line];
    
    for (int i =0 ; i<4; i++) {
        CGFloat y;
        if (i==0) {
            y = firstTitleLabel.frame.origin.y+4;
        }else if (i==1){
            y = secondTitleLabel.frame.origin.y+4;
        }else if (i==2){
            y = thirdTitleLabel.frame.origin.y+4;
        }else if (i==3){
            y = fourthTitleLabel.frame.origin.y+4;
        }
        UIView *yuanView = [[UIView alloc]initWithFrame:CGRectMake(12, y, 7, 7)];
        if (i<timeArr.count) {
            yuanView.backgroundColor = LMColor(233, 91, 20);
        }else{
            yuanView.backgroundColor = LMColor(197, 197, 197);
        }
        yuanView.layer.cornerRadius = 3.5;
        yuanView.layer.masksToBounds = YES;
        [shenPiBgView addSubview:yuanView];
    }
    
    shenPiBgView.frame = CGRectMake(0, 0, KScreenWidth, CGRectGetMaxY(fourthView.frame)+10);
    

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
    if (willOrDoTag==0) {
        documentsBgView.hidden = NO;
        shenPiBgView.hidden = YES;
//        mainScrollView.contentOffset = CGPointMake(0, 0);
        mainScrollView.contentSize = CGSizeMake(KScreenWidth,CGRectGetMaxY(documentsBgView.frame));

    }else{
        documentsBgView.hidden = YES;
        shenPiBgView.hidden = NO;
//        mainScrollView.contentOffset = CGPointMake(KScreenWidth,0);
        mainScrollView.contentSize = CGSizeMake(KScreenWidth,CGRectGetMaxY(shenPiBgView.frame));

    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

@end
