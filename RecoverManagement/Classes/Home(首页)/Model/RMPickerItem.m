//
//  RMPickerItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMPickerItem.h"

@implementation RMPickerItem
+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle pickerArray:(NSArray* )pickerArray{
    RMPickerItem *  item = [super itemWithtitle:title subTitle:subTitle];
    item.pickerArray = pickerArray;
    
    return item;
}
@end
