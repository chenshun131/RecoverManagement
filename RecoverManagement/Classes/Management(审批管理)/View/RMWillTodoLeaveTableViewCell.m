//
//  RMWillTodoLeaveTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/4.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMWillTodoLeaveTableViewCell.h"

@implementation RMWillTodoLeaveTableViewCell

- (void)initWithName:(NSString *)name andTime:(NSString *)time andShenPi:(NSString *)shenPi andWillOrDo:(NSString *)willOrDo andChooseState:(BOOL)chooseState{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    if ([willOrDo isEqualToString:@"0"]) {
        _chooseBtn = [[UIButton  alloc]initWithFrame:CGRectMake(15, 25, 20, 20)];
        [_chooseBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
        [self.contentView addSubview:_chooseBtn];
        
        _chooseBtn.selected = chooseState;
        
        _cellSelectButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 15,40, 40)];
      
        [self.contentView addSubview:_cellSelectButton];
        _cellSelectButton.selected = chooseState;
    }
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 15)];
    if ([willOrDo isEqualToString:@"0"]) {
        nameLabel.frame =CGRectMake(CGRectGetMaxX(_chooseBtn.frame)+15,15 , 200, 15);
    }
    nameLabel.text = [NSString stringWithFormat:@"%@审批",name];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:nameLabel];
    
    UILabel *setupTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x, CGRectGetMaxY(nameLabel.frame)+10, KScreenWidth-30, 15)];
    setupTimeLabel.text = time;
    setupTimeLabel.textColor = RMColor(166, 166, 166);
    setupTimeLabel.textAlignment = NSTextAlignmentLeft;
    setupTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:setupTimeLabel];
    
    UIImageView *rightImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-10-8, 29, 8, 12)];
    rightImageV.image = [UIImage imageNamed:@"disclosure-arrow--"];
    [self.contentView addSubview:rightImageV];
    
    if ([willOrDo isEqualToString:@"1"]){
        UIImageView *shenpiImageV = [[UIImageView alloc]initWithFrame:CGRectMake(rightImageV.frame.origin.x-5-15, 27, 15, 15)];
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

}

@end
