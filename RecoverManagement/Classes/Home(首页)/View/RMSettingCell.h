//
//  RMSettingCell.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMSettingItem;
#define textViewH  250
#define collViewH  (80+45)
@interface RMSettingCell : UITableViewCell
/**
 *  表格的数据模型
 */
@property(nonatomic,strong)RMSettingItem *item;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
