//
//  RMDateItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMDateItem.h"

@implementation RMDateItem
+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle datePickerMode:(UIDatePickerMode)datePickerMode{
    RMDateItem *  item = [super itemWithtitle:title subTitle:subTitle];
    item.datePickerMode = datePickerMode;
    
    return item;
}
@end
