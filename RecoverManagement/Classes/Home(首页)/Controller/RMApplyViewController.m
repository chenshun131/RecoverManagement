//
//  RMApplyViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApplyViewController.h"
#import "RMBaseSettingTableView.h"
#import "RMPickerItem.h"
#import "RMDateItem.h"
#import "RMTextItem.h"
#import "RMSettingGroup.h"
#import "RMSettingItem.h"
#import "RMTFieldItem.h" 
#import "RMCollectionItem.h"
@interface RMApplyViewController ()
@property (nonatomic, strong)RMBaseSettingTableView *mainView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSString *currentSelectedTime;
@end

@implementation RMApplyViewController
{
    NSString *_today;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  "];
       _today =  [dateFormatter stringFromDate:[NSDate date]];
    [self loadDataWithType:[self.applyTypeEnumNumber integerValue]];
    [self initUI];
  
}

-(void)loadDataWithType:(RMApplyType)applyType{
    switch (applyType) {
        case RMApplyReport:
            [self loadReportData];//日报
             break;
        case RMApplyLeave:
         [self loadLeaveData];//请假
            break;
        case RMApplyOverwork:
      [self loadOverworkData];//加班
            break;
        case RMApplyRepair:
       [self loadRepairData];//补签
            break;
        case RMApplyMeeting:
            [self loadMeetingData];//补签
            break;
        default:
            break;
    }
}
- (void)loadReportData{
   

    
    NSMutableArray *tempArray = @[].mutableCopy;
    
     RMSettingItem *item1 = [RMDateItem  itemWithtitle: @"日报日期" subTitle:_today datePickerMode:UIDatePickerModeDate ];
     RMSettingItem *item2 = [RMPickerItem itemWithtitle:@"日报类型" subTitle:@"工作日报" pickerArray:@[@"工作日报"]];
     RMSettingItem *item3 = [RMPickerItem itemWithtitle:@"任务计划" subTitle:@"选择任务" pickerArray:@[]];
    RMSettingItem *item4 = [RMPickerItem itemWithtitle: @"工作时长" subTitle:@"8小时"  pickerArray:@[@"8小时"]];
    
    RMSettingGroup *group1 = [[RMSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4];
       [tempArray   addObject:group1];
    
    
   RMSettingItem *item5 = [RMTextItem itemWithplaceholder:@"请输入工作内容描述(300字以内)" color:nil font:nil];
    
    RMSettingGroup *group2 = [[RMSettingGroup alloc] init];
    group2.items = @[item5];
    [tempArray   addObject:group2];
    
    _dataSource = tempArray;
}
- (void)loadLeaveData{
    NSMutableArray *tempArray = @[].mutableCopy;
    RMSettingItem *item1 = [RMPickerItem itemWithtitle: @"请假类型"  subTitle:@"事假" pickerArray:@[@"事假"]];
   RMSettingItem *item2 = [RMDateItem itemWithtitle: @"开始时间" subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
     RMSettingItem *item3 = [RMDateItem itemWithtitle: @"结束时间"subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
    RMSettingItem *item4 =  [RMPickerItem itemWithtitle: @"请假时长" subTitle:[NSString string] pickerArray:@[]];
    
    RMSettingGroup *group1 = [[RMSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4];
    [tempArray   addObject:group1];
    
    RMSettingItem *item5 = [RMTextItem itemWithplaceholder:@"请输入请假说明(300字以内)" color:nil font:nil];
    
    RMSettingGroup *group2 = [[RMSettingGroup alloc] init];
    group2.items = @[item5];
    [tempArray   addObject:group2];
    
    _dataSource = tempArray;
}
- (void)loadOverworkData{
    NSMutableArray *tempArray = @[].mutableCopy;
    RMSettingItem *item2 = [RMDateItem itemWithtitle: @"开始时间" subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
    
    RMSettingItem *item3 = [RMDateItem itemWithtitle: @"结束时间"subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
    
    RMSettingGroup *group1 = [[RMSettingGroup alloc] init];
    group1.items = @[item2,item3];
    [tempArray   addObject:group1];
    
    RMSettingItem *item5 = [RMTextItem itemWithplaceholder:@"请输入加班原因(300字以内)" color:nil font:nil];
    
    RMSettingGroup *group2 = [[RMSettingGroup alloc] init];
    group2.items = @[item5];
    [tempArray   addObject:group2];
    
    _dataSource = tempArray;
}
- (void)loadRepairData{
    NSMutableArray *tempArray = @[].mutableCopy;
    RMSettingItem *item1 = [RMDateItem itemWithtitle: @"补签日期" subTitle:[NSString string] datePickerMode:UIDatePickerModeDate ];
  
    RMSettingItem *item2 = [RMPickerItem itemWithtitle: @"补签地点"  subTitle: @"请选择" pickerArray:@[]];
    RMSettingItem *item3 = [RMPickerItem itemWithtitle: @"补签类型"  subTitle: @"请选择" pickerArray:@[]];

    RMSettingItem *item4 = [RMDateItem itemWithtitle: @"补签时间" subTitle:[NSString string] datePickerMode:UIDatePickerModeTime ];
       RMSettingGroup *group1 = [[RMSettingGroup alloc] init];
    group1.items = @[item1,item2,item3,item4];
    [tempArray   addObject:group1];
    
    RMSettingItem *item5 = [RMTextItem itemWithplaceholder:@"请输入补签说明(300字以内)" color:nil font:nil];
    
    RMSettingGroup *group2 = [[RMSettingGroup alloc] init];
    group2.items = @[item5];
    [tempArray   addObject:group2];

    
    _dataSource = tempArray;
}

- (void)loadMeetingData{
    NSMutableArray *tempArray = @[].mutableCopy;
    RMSettingItem *item1 =  [RMDateItem itemWithtitle: @"开始时间" subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
    
    RMSettingItem *item2  = [RMDateItem itemWithtitle: @"结束时间"subTitle:[NSString string] datePickerMode:UIDatePickerModeDateAndTime ];
    RMSettingItem *item3 = [RMPickerItem itemWithtitle: @"地点"  subTitle: @"请选择" pickerArray:@[]];
    
    RMTFieldItem *item4 = [RMTFieldItem itemWithtitle: @"主题" placeholder:@"请输入会议主题..." color:[UIColor grayColor]  font:nil];
    RMSettingGroup *group1 = [[RMSettingGroup alloc] init];
    group1.items = @[item1,item2];
    [tempArray   addObject:group1];
    RMSettingGroup *group2 = [[RMSettingGroup alloc] init];
    group2.items = @[item3,item4];
    [tempArray   addObject:group2];
  
    RMCollectionItem *item5 = [RMCollectionItem itemWithtitle:@"参加人员" collectionArray:@[]];
    
    RMSettingGroup *group3 = [[RMSettingGroup alloc] init];
    group3.items = @[item5];
    [tempArray   addObject:group3];
    
    
    _dataSource = tempArray;
}


- (void)initUI{
    _mainView = [[RMBaseSettingTableView alloc]initWithFrame:self.view.bounds];
    _mainView.cellData =_dataSource;
    [self.view addSubview:_mainView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
