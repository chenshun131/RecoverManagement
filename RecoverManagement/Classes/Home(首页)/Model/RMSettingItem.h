//
//  RMSettingItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义一个block,无返回值，也无参数
typedef void (^OperationBlock)();
@interface RMSettingItem : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
/**
 * 控制器的类型
 */
@property(nonatomic,assign)Class vcClass;

/**
 *  存储一个特殊的Block 操作
 *   block 使用copy
 */
@property(nonatomic,copy)OperationBlock operation;


-(instancetype)initWithtitle:(NSString *)title subTitle:(NSString *)subTitle;

+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle;

+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle  vcClass:(Class)vcClass;



@end
