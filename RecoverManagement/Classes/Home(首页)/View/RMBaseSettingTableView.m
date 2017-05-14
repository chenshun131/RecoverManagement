//
//  RMBaseSettingTableView.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMBaseSettingTableView.h"
#import "RMSettingGroup.h"
#import "RMSettingItem.h"
#import "RMSettingCell.h"
#import "RMTextItem.h"
#import "RMDateItem.h"
#import "RMPickerItem.h"
#import "RMDatePicker.h"
#import "RMPickerView.h"
#import "RMCollectionItem.h"
@interface RMBaseSettingTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation RMBaseSettingTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
      
        UIView *backgroundView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, KScreenWidth ,100)];
        UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.frame = CGRectMake(30, 30, KScreenWidth - 30*2, 44);
        commitBtn.backgroundColor = [UIColor blueColor];
        commitBtn.titleLabel.textColor = [UIColor whiteColor];
        commitBtn.titleLabel.font = RMNavTitle18Font;
        [commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [backgroundView addSubview:commitBtn];
          self.tableView.tableFooterView = backgroundView;
        [self addSubview:_tableView];
   
    }
    return self;
}
-(NSMutableArray *)cellData{
    if (!_cellData) {
        _cellData = [NSMutableArray array];
    }
    return _cellData;
}
#pragma mark - 组的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellData.count;
}

#pragma mark 组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    RMSettingGroup *group = self.cellData[section];
    
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RMSettingCell *cell = [RMSettingCell cellWithTableView:tableView];
    
    //获取组的模型数据
    RMSettingGroup *group = self.cellData[indexPath.section];
    
    //获取行的模型数据
    RMSettingItem *item = group.items[indexPath.row];
    
    //设置模型 显示数据
    cell.item = item;
    
    return cell;
}

#pragma mark cell的点中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //获取组模型
    RMSettingGroup *group = self.cellData[indexPath.section];
    
    //获取行的模型
    RMSettingItem *item = group.items[indexPath.row];
    
    if([item isKindOfClass:[RMDateItem class]]){
      [self createDateSelectorViewWithTableIndex:indexPath.row];
    }else if ([item isKindOfClass:[RMPickerItem class]]){
        
    }
    //判断是否有 "特殊的操作"
    if (item.operation) {
        //有特殊的操作，operation是有值，然后调用
        item.operation();
    }else if(item.vcClass){
        //创建控制器再显示
        id vc = [[item.vcClass alloc] init];
        //设置下一个控制器的标题
        [vc setTitle:item.title];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取组模型
    RMSettingGroup *group = self.cellData[indexPath.section];
    
    //获取行的模型
    RMSettingItem *item = group.items[indexPath.row];
    if ([item isKindOfClass:[RMTextItem class]]) {
         return textViewH;
    }
    if ([item isKindOfClass:[RMCollectionItem class]]) {
        return collViewH;
    }
    return 44;
}
#pragma mark 头部标题
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

#pragma mark 尾部标题
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{    return 10.f;
}

#pragma mark - textView Delegate
- (void)createDateSelectorViewWithTableIndex:(NSUInteger)index{
    RMDatePicker * datePicker = [RMDatePicker pickerWithOwnNib];
    WS(weakSelf)
    datePicker.doneBlock =  ^(NSString * str){
      
        [weakSelf.tableView  reloadData];
        return YES;
    };
    [datePicker show];
}


@end
