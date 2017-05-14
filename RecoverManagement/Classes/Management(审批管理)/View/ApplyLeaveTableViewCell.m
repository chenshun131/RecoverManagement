//
//  applyLeaveTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "ApplyLeaveTableViewCell.h"

@implementation ApplyLeaveTableViewCell

- (void)initWithTitle:(NSString*)title andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andSetupTime:(NSString *)setupTime andShenPi:(NSString *)shenPi andShenPiResult:(NSString *)shenpiResult andWillOrDo:(NSString *)willOrDo{
    
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 15)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
    
    NSArray *imageArr = @[@"yousanjiaocheng",@"zuosanjiaocheng"];
    for (int i = 0; i< 2; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame) + 12 + 25*i, 6, 10)];
        imageV.image = [UIImage imageNamed:imageArr[i]];
        [self.contentView addSubview:imageV];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame) +10, CGRectGetMaxY(titleLabel.frame) + 10 + 25*i, 150, 15)];
        if(i==0)
        {
            timeLabel.text = startTime;
        }else{
            timeLabel.text = endTime;
        }
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = RMColor(234, 102, 50);
        timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:timeLabel];
    
    }
    
    UILabel *setupTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+65, 150, 15)];
    setupTimeLabel.text = [NSString stringWithFormat:@"%@发起",setupTime];
    setupTimeLabel.textColor = RMColor(166, 166, 166);
    setupTimeLabel.textAlignment = NSTextAlignmentLeft;
    setupTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:setupTimeLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-10-8, 11, 8, 12)];
    rightImageV.image = [UIImage imageNamed:@"disclosure-arrow--"];
    [self.contentView addSubview:rightImageV];
    
    if ([willOrDo isEqualToString:@"0"]) {
        UILabel *shenpiLabel = [[UILabel alloc]initWithFrame:CGRectMake(rightImageV.frame.origin.x-5-65, 10, 65, 15)];
        shenpiLabel.text = shenPi;
        shenpiLabel.textAlignment = NSTextAlignmentRight;
        shenpiLabel.textColor = RMColor(32, 102, 233);
        shenpiLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:shenpiLabel];
    }else{
        UIImageView *shenpiImageV = [[UIImageView alloc]initWithFrame:CGRectMake(rightImageV.frame.origin.x-5-15, 10, 15, 15)];
        if ([shenpiResult isEqualToString:@"0"]) {
            shenpiImageV.image=[UIImage imageNamed:@"foujueicon"];
        }else{
            shenpiImageV.image=[UIImage imageNamed:@"tongguoicon"];
        }

        [self.contentView addSubview:shenpiImageV];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
