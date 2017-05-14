//
//  RMTextItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/1.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMTextItem.h"

@implementation RMTextItem
-(instancetype)initWithplaceholder:(NSString *)placeholder color:(UIColor *)placeholderColor font:(UIFont *)placeholderFont{
    if (self = [super init]) {
        self.placeholder = placeholder;
        self.placeholderColor = placeholderColor?placeholderColor: [UIColor lightGrayColor];
        self.placeholderFont = placeholderFont?placeholderFont:RMText15Font;
    }
    
    return self;
}
+(instancetype)itemWithplaceholder:(NSString *)placeholder color:(UIColor *)placeholderColor font:(UIFont *)placeholderFont {
    return [[self alloc] initWithplaceholder:placeholder color:placeholderColor font:placeholderFont];
}
@end
