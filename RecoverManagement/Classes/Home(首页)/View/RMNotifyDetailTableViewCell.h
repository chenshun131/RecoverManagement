//
//  RMNotifyDetailTableViewCell.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/16.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMNotifyDetailModel.h"
@interface RMNotifyDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) RMNotifyDetailModel *model;
// cell的高度

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
