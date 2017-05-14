//
//  RMNotifyDetailModel.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/16.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMNotifyDetailModel.h"

@implementation RMNotifyDetailModel
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
  
        @try {
            [self setValuesForKeysWithDictionary:dic];
            
        }
        @catch (NSException *exception) {
            NSLog(@"后台键值映射错误");
        }@finally {
            if(_titleDetailNotify.length>0){
                CGSize titleSize = [_titleDetailNotify boundingRectWithSize:CGSizeMake(KScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : RMText15Font}context:nil].size;
                _titleDetailNotifyFrame = (CGRect){{10,10},titleSize};
            }
             if(_subtitleDetailNotify.length>0){
                        CGSize detailSize = [_subtitleDetailNotify sizeWithAttributes:@{NSFontAttributeName : RMTime12Font}];
            _subtitleDetailNotifyFrame =  (CGRect){{KScreenWidth-detailSize.width-10, CGRectGetMaxY(_titleDetailNotifyFrame)+10},detailSize};
                 self.cellHeight =  CGRectGetMaxY(_subtitleDetailNotifyFrame)+10;
             }
        
        }
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}

@end
