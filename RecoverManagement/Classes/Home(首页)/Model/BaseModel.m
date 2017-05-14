

//
//  BaseModel.m
//  PersonalTailor
//
//  Created by sandyrilla on 16/5/19.
//  Copyright © 2016年 com.Bluemobi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        @try {
            [self setValuesForKeysWithDictionary:dic];
            
        }
        @catch (NSException *exception) {
            NSLog(@"后台键值映射错误");
        }
        
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
@end
