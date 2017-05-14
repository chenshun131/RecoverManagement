//
//  RMNotifyTableViewCell.h
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/15.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNotifyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImage;
@property (weak, nonatomic) IBOutlet UILabel *titleNotify;
@property (weak, nonatomic) IBOutlet UILabel *subtitleNotify;

@end
