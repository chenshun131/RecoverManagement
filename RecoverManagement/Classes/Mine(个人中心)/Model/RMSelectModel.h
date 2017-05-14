//
//  RMSelectModel.h
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/14.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMSelectModel : NSObject
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)NSInteger index;
@end
