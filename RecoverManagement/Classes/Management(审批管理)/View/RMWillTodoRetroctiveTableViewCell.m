//
//  RMWillTodoRetroctiveTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMWillTodoRetroctiveTableViewCell.h"

@implementation RMWillTodoRetroctiveTableViewCell

- (void)initWithName:(NSString *)name andTime:(NSString *)time andShenPi:(NSString *)shenPi andWillOrDo:(NSString *)willOrDo{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 15)];
    nameLabel.text = [NSString stringWithFormat:@"%@的补签审批",name];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    
    UILabel *setupTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame)+20, 150, 15)];
    setupTimeLabel.text = time;
    setupTimeLabel.textColor = RMColor(166, 166, 166);
    setupTimeLabel.textAlignment = NSTextAlignmentLeft;
    setupTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:setupTimeLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-10-8, 29, 8, 12)];
    rightImageV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:rightImageV];
    
    if ([willOrDo isEqualToString:@"1"]){
        UIImageView *shenpiImageV = [[UIImageView alloc]initWithFrame:CGRectMake(rightImageV.frame.origin.x-5-15, 27, 15, 15)];
        shenpiImageV.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:shenpiImageV];
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
