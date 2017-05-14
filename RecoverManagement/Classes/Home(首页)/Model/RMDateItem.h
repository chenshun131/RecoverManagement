//
//  RMDateItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@interface RMDateItem : RMSettingItem

@property (nonatomic) UIDatePickerMode datePickerMode;
+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle datePickerMode:(UIDatePickerMode)datePickerMode;
@end
