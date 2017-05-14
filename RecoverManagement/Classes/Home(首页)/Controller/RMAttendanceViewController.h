//
//  RMAttendanceViewController.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//考勤&日报&会议

#import <UIKit/UIKit.h>
#import "RMBaseViewController.h"
typedef NS_ENUM(NSUInteger, RMFunctionType) {
    RMFunctionAttendance= 0,//考勤
    RMFunctionDaily,//日报
    RMFunctionConference,//会议
   
};
@interface RMAttendanceViewController : RMBaseViewController
@property (nonatomic, copy) NSString *  functionTypeEnumNumber;
@property (nonatomic, copy) NSString * nextControllerClassName;
@property (nonatomic, copy) NSString *rightItemImage;
@property (nonatomic, strong)NSDictionary *param;
@end
