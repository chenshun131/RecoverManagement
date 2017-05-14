//
//  RMNotifyDetailModel.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/16.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNotifyDetailModel : NSObject
@property (copy, nonatomic)  NSString *titleDetailNotify;
@property (copy, nonatomic)  NSString *subtitleDetailNotify;
// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect titleDetailNotifyFrame;

/**   ******原创微博子控件frame**** */
// 头像Frame
@property (nonatomic, assign) CGRect subtitleDetailNotifyFrame;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
