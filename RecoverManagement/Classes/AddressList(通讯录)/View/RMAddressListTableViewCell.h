//
//  RMAddressListTableViewCell.h
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/2.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMAddressListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UIButton *cellSelectButton;
- (void)initWithName:(NSString *)name andDepartment:(NSString *)department andJob:(NSString *)job andState:(NSString *)state andImageUrl:(NSString *)imageUrl andChooseState:(BOOL)chooseState;
@end
