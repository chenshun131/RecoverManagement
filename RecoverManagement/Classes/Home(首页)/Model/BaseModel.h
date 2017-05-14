//
//  BaseModel.h
//  PersonalTailor
//
//  Created by sandyrilla on 16/5/19.
//  Copyright © 2016年 com.Bluemobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
