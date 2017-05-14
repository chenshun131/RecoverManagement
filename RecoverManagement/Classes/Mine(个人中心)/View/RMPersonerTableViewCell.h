//
//  RMPersonerTableViewCell.h
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMPersonerTableViewCell : UITableViewCell

- (void)initWithIndex:(NSInteger)index andImageName:(NSString *)imageName andData:(NSString *)data andTitle:(NSString *)title andCanEdit:(BOOL)canEdit;

@end
