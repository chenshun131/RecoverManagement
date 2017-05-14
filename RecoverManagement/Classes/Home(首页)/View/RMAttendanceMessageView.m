//
//  RMAttendanceMessageView.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMAttendanceMessageView.h"

@implementation RMAttendanceMessageView
+(instancetype)messageViewWithOwnNib{
    NSArray* nibs = [[NSBundle mainBundle]loadNibNamed:@"RMAttendanceMessageView" owner:nil options:nil];
    return nibs.firstObject;
}


@end
