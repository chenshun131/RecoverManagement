//
//  RMTextItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/1.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@interface RMTextItem : RMSettingItem
@property(copy,nonatomic)   NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
-(instancetype)initWithplaceholder:(NSString *)placeholder  color:(UIColor *)placeholderColor font:(UIFont * )placeholderFont ;
+(instancetype)itemWithplaceholder:(NSString *)placeholder  color:(UIColor *)placeholderColor font:(UIFont * )placeholderFont ;
@end
