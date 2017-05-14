//
//  RMSettingGroup.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMSettingGroup : NSObject
/**
 *  组的头部标题
 */
@property(nonatomic,copy)NSString *headerTitle;
/**
 *  组的尾部标题
 */
@property(nonatomic,copy)NSString *footerTitle;
/**
 *  组的每一行数据模型
 */
@property(nonatomic,strong)NSArray *items;

@end
