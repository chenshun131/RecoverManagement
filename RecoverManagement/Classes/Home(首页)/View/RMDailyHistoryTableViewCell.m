//
//  RMDailyHistoryTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMDailyHistoryTableViewCell.h"

@implementation RMDailyHistoryTableViewCell

- (void)initWithTitle:(NSString*)title andContent:(NSString *)content{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, KScreenWidth-50, 15)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
    
    UILabel *contenteLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+10, KScreenWidth-50, 15)];
    contenteLabel.text = @"可以包括但不限于也不必须包括所有如下所有如下所有如下";
    contenteLabel.textColor = LMColor(120, 120, 120);
    contenteLabel.textAlignment = NSTextAlignmentLeft;
    contenteLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contenteLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-15-12, 25, 12, 15)];
    rightImageV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:rightImageV];
    
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
