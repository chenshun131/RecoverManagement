//
//  RMHomeCellModel.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/25.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMHomeCellModel.h"

@implementation RMHomeCellModel
+ (NSArray *)homeModelList
{
    //加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomePropertyList" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dicArray) {
        RMHomeCellModel *model = [RMHomeCellModel modelWithDic:dic];
        [tmpArray addObject:model];
    }
    return tmpArray;
}
@end

@implementation RMProcessApprovalModel
+ (NSArray *)approvalModelList
{
    //加载plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProcessApprovalList" ofType:@"plist"];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
    
    //字典转模型
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dicArray) {
        RMProcessApprovalModel *model = [RMProcessApprovalModel modelWithDic:dic];
        [tmpArray addObject:model];
    }
    return tmpArray;
}
@end
