//
//  RMWillTodoLeaveTableViewCell.h
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/4.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMWillTodoLeaveTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UIButton *cellSelectButton;
- (void)initWithName:(NSString*)name andTime:(NSString *)time andShenPi:(NSString *)shenPi andWillOrDo:(NSString *)willOrDo andChooseState:(BOOL)chooseState;//willOrDo 未审批 0 已审批 1
@end
