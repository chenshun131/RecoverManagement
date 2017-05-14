//
//  RMStateBar.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RMStateBar;
@protocol RMStateBarDelegate <NSObject>
@optional

- (void)didSelectedIndex:(NSInteger)index;

@end

@interface RMStateBar : UIView

@property (nonatomic, weak) id<RMStateBarDelegate> delegate;
@property (nonatomic, copy) NSString * customButtonClassName;
- (void)setButtonImageWithNormal:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages title:(NSArray *)titles target:(BOOL)target;
@end
