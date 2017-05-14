//
//  RMCollectionItem.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/14.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSettingItem.h"

@interface RMCollectionItem : RMSettingItem
@property(strong,nonatomic)NSArray *collectionArray;
+(instancetype)itemWithtitle:(NSString *)title collectionArray:(NSArray *)array ;
@end
