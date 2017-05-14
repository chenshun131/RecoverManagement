//
//  RMHomeCellModel.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/25.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
//首页功能模型
@interface RMHomeCellModel : BaseModel

@property (nonatomic, assign) BOOL isBigger;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, copy) NSString *badgeNumber;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *backGroundColor;
@property (nonatomic, copy) NSString *destinationControllerClassName;//目标控制器类名

+ (NSArray *)homeModelList;
@end

//审批流程模型
@interface RMProcessApprovalModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, copy) NSString *badgeNumber;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *backGroundColor;
@property (nonatomic, copy) NSString *destinationControllerClassName;//目标控制器类名

+ (NSArray *)approvalModelList;
@end
