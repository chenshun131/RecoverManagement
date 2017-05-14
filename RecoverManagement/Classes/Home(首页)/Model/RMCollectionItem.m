//
//  RMCollectionItem.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/14.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMCollectionItem.h"

@implementation RMCollectionItem
+(instancetype)itemWithtitle:(NSString *)title collectionArray:(NSArray *)array {
    RMCollectionItem *  item = [super itemWithtitle:title subTitle:nil];
    item.collectionArray = array;
    
    return item;
}
@end
