//
//  RMApproverCollectionViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/22.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApproverCollectionViewCell.h"

@implementation RMApproverCollectionViewCell

- (void)initWithImageUrl:(NSString *)imageUrl andName:(NSString *)name{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView *nextStepApproverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    nextStepApproverImageView.layer.cornerRadius = 20;
    nextStepApproverImageView.layer.masksToBounds = YES;
    nextStepApproverImageView.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:nextStepApproverImageView];
    
    UILabel *nextStepNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nextStepApproverImageView.frame)+2, 40, 13)];
    nextStepNameLabel.text = name;
    nextStepNameLabel.textColor = LMColor(100, 100, 100);
    nextStepNameLabel.textAlignment = NSTextAlignmentCenter;
    nextStepNameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nextStepNameLabel];

}
@end
