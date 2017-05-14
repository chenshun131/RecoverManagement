//
//  RMBaseSettingTableView.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMBaseSettingTableView : UIView
/**
 *  表格数据，里面存储CZSettingGroup
 */
@property(nonatomic,strong)NSMutableArray *cellData;
@property(nonatomic,strong)UITableView *tableView;

@end
