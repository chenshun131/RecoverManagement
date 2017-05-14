//
//  RMAttendanceMessageView.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMAttendanceMessageView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
+(instancetype)messageViewWithOwnNib;
@end
