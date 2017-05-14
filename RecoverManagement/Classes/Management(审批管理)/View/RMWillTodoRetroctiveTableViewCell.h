//
//  RMWillTodoRetroctiveTableViewCell.h
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMWillTodoRetroctiveTableViewCell : UITableViewCell

- (void)initWithName:(NSString*)name andTime:(NSString *)time andShenPi:(NSString *)shenPi andWillOrDo:(NSString *)willOrDo;//willOrDo 未审批 0 已审批 1
@end
