//
//  RMNotifyDetailTableViewCell.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/16.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMNotifyDetailTableViewCell.h"
@interface RMNotifyDetailTableViewCell ()
@property (weak, nonatomic)  UILabel *titleDetailNotify;
@property (weak, nonatomic)  UILabel *subtitleDetailNotify;

@end
@implementation RMNotifyDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NotifyDetailCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}
// 添加所有子控件
- (void)setUpAllChildView
{
    
    UILabel *titleDetailNotify = [[UILabel alloc] init];
    titleDetailNotify.numberOfLines = 0;
    titleDetailNotify.font = RMText15Font;
    [self addSubview:titleDetailNotify];
    _titleDetailNotify = titleDetailNotify;
    

    UILabel *subtitleDetailNotify = [[UILabel alloc] init];
    subtitleDetailNotify.numberOfLines = 1;
    subtitleDetailNotify.font = RMTime12Font;
    [self addSubview:subtitleDetailNotify];
    _subtitleDetailNotify = subtitleDetailNotify;
    

}

- (void)setModel:(RMNotifyDetailModel *)model
{
    _model = model;
    _titleDetailNotify.text =  model.titleDetailNotify;
    _titleDetailNotify.frame = model.titleDetailNotifyFrame;
    
    // 设置原创微博frame
       _subtitleDetailNotify.text =  model.subtitleDetailNotify;
    _subtitleDetailNotify.frame = model.subtitleDetailNotifyFrame;

    
    
   
}
@end
