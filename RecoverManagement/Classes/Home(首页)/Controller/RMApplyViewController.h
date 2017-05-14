//
//  RMApplyViewController.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMBaseViewController.h"
typedef NS_ENUM(NSUInteger, RMApplyType) {
    RMApplyReport= 0,//日报
    RMApplyLeave,//请假
    RMApplyOverwork,//加班
    RMApplyRepair,//补签
    RMApplyMeeting//会议
};

@interface RMApplyViewController : RMBaseViewController
@property (nonatomic, copy) NSString *  applyTypeEnumNumber;
@end
