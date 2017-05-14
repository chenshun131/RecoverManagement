//
//  RMPickerItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@interface RMPickerItem : RMSettingItem
@property (nonatomic,strong) NSArray* pickerArray;
+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle pickerArray:(NSArray* )pickerArray;
@end
