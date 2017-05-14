//
//  RMTFieldItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/14.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@interface RMTFieldItem : RMSettingItem
@property(copy,nonatomic)   NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
-(instancetype)initWithtitle:(NSString *)title placeholder:(NSString *)placeholder  color:(UIColor *)placeholderColor font:(UIFont * )placeholderFont ;
+(instancetype)itemWithtitle:(NSString *)title placeholder:(NSString *)placeholder  color:(UIColor *)placeholderColor font:(UIFont * )placeholderFont ;
@end
