//
//  RMAttendanceDetailViewController.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/2.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMBaseViewController.h"

@interface RMAttendanceDetailViewController : RMBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *lastTime;

@end
