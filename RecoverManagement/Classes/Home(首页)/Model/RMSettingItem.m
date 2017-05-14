//
//  RMSettingItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@implementation RMSettingItem

-(instancetype)initWithtitle:(NSString *)title subTitle:(NSString *)subTitle{
    if (self = [super init]) {
        self.subTitle = subTitle;
        self.title = title;
    }
    
    return self;
}
+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle{
    return [[self alloc] initWithtitle:title subTitle:subTitle];
}

+(instancetype)itemWithtitle:(NSString *)title subTitle:(NSString *)subTitle vcClass:(Class)vcClass{
    RMSettingItem *item = [self itemWithtitle:title subTitle:subTitle];
    item.vcClass = vcClass;
    
    return item;
}


@end
