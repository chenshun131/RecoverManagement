//
//  RMTFieldItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/14.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMTFieldItem.h"

@implementation RMTFieldItem
-(instancetype)initWithtitle:(NSString *)title placeholder:(NSString *)placeholder color:(UIColor *)placeholderColor font:(UIFont *)placeholderFont{
    if (self = [super initWithtitle:title subTitle:nil]) {
        self.placeholder = placeholder;
        self.placeholderColor = placeholderColor?placeholderColor: [UIColor lightGrayColor];
        self.placeholderFont = placeholderFont?placeholderFont:RMText15Font;
    }
    
    return self;
}
+(instancetype)itemWithtitle:(NSString *)title placeholder:(NSString *)placeholder color:(UIColor *)placeholderColor font:(UIFont *)placeholderFont {
    return [[self alloc] initWithtitle:title placeholder:placeholder color:placeholderColor font:placeholderFont];
}
@end
