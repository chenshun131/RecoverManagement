//
//  RMApplyAllTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApplyAllTableViewCell.h"

@implementation RMApplyAllTableViewCell

- (void)initWithTitle:(NSString *)title andTime:(NSString *)time andShenPi:(NSString *)shenPi andWillOrDo:(NSString *)willOrDo{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth-70, 15)];
    if ([willOrDo isEqualToString:@"0"]) {
        titleLabel.text = [NSString stringWithFormat:@"当前步骤：%@",title];
    }else{
        titleLabel.text = [NSString stringWithFormat:@"审批结果：%@",title];
    }
    
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+10, KScreenWidth-70, 15)];
    timeLabel.text = time;
    timeLabel.textColor = RMColor(166, 166, 166);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timeLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-10-8, 16, 8, 12)];
    rightImageV.image = [UIImage imageNamed:@"disclosure-arrow--"];
    [self.contentView addSubview:rightImageV];
    
    if ([willOrDo isEqualToString:@"1"]){
        UIImageView *shenpiImageV = [[UIImageView alloc]initWithFrame:CGRectMake(rightImageV.frame.origin.x-5-15, 15, 15, 15)];
        if ([shenPi isEqualToString:@"0"]) {
            shenpiImageV.image=[UIImage imageNamed:@"foujueicon"];
        }else{
            shenpiImageV.image=[UIImage imageNamed:@"tongguoicon"];
        }

        [self.contentView addSubview:shenpiImageV];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
