//
//  RMDatePicker.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMDatePicker : UIView
+(instancetype)pickerWithOwnNib;
@property (nonatomic, copy) BOOL(^doneBlock)(NSString*);
-(void)show;
@end
