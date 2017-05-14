//
//  RMAttendanceViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//
#import "RMDailyHistoryViewController.h"
#import "RMApplyViewController.h"
#import "RMAttendanceViewController.h"
#import "RMCalendarView.h"
#import "RMStateBar.h"

@interface RMAttendanceViewController ()
@property (strong, nonatomic) RMCalendarView *calendarView;
@property (nonatomic, strong) NSDate *date;
@end

@implementation RMAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.date = [NSDate date];
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalName:self.rightItemImage] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    
    self.navigationItem.rightBarButtonItem = editingButton;
    [self setupCalendarView];
  
}

- (void)rightItemClick:(UIBarButtonItem *)sender{
    switch ([self.functionTypeEnumNumber integerValue]) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
           
            RMDailyHistoryViewController *vc = [[RMDailyHistoryViewController alloc]init];
        
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            RMApplyViewController *vc = [[RMApplyViewController alloc]init];
            vc.applyTypeEnumNumber = @"4";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
   }
-(void)pushNextVCwithTitle:(NSString *)title{
 
        Class class = NSClassFromString(self.nextControllerClassName);
        //创建控制器再显示
        id vc = [[class alloc] init];
        //设置下一个控制器的标题
        [vc setTitle:title];
        @try {
              [vc setValuesForKeysWithDictionary:self.param];
        } @catch (NSException *exception) {
            NSLog(@"%@键值映射出错",self.class);
        }
        [self.navigationController pushViewController:vc animated:YES];
   

}

- (RMCalendarView *)calendarView{
    if (!_calendarView) {
        
        _calendarView =   [[RMCalendarView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.width )];
        self.calendarView. allDaysImage = [UIImage imageNamed:@"lvyuan"];
        self.calendarView. partDaysImage = [UIImage imageNamed:@"hongyuan"];
        self.calendarView. dateImage = [UIImage imageNamed:@"xuxianyuan"];
    }
    return _calendarView;
}



- (void)setupCalendarView {

    //日期状态
    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"8", @"9", @"17",  @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
    [self.view addSubview:self.calendarView];
    //    self.calendarView.isShowOnlyMonthDays = NO;
    self.calendarView.date = [NSDate date];
        WS(weakSelf)
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
        [weakSelf pushNextVCwithTitle:  [NSString stringWithFormat:@"%li-%li-%li",year,month,day]]   ;
    };

    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    RMStateBar *citybar = [[RMStateBar alloc ]initWithFrame:CGRectMake(20,CGRectGetMaxY(self.calendarView.frame)+20, KScreenWidth-40, 44)];
  citybar.customButtonClassName =@"RMLeftImageButton";
    NSArray *normalImages,*titles;

    NSInteger functionType =  [self.functionTypeEnumNumber integerValue];
    if (functionType == RMFunctionAttendance) {//考勤 （绿 灰 红 橙）
        normalImages = @[@"lvdian",@"huidian",@"hongdian",@"chengdian"];
        titles = @[@" 全勤",@" 迟到/早退",@" 未签到",@" 请假"];
    } else  if (functionType == RMFunctionDaily){//日报 （ 绿  红）
        normalImages = @[@"lvdian",@"hongdian"];
        titles = @[@" 正常报工",@" 异常报工"];
    }else  if (functionType == RMFunctionConference){//会议 （绿 灰 红）
        normalImages = @[@"lvdian",@"huidian",@"hongdian"];
        titles = @[@" 参加会议",@" 过期会议",@" 会议邀请"];
    }
    [citybar setButtonImageWithNormal:normalImages selectedImages:nil title:titles target:NO];
    [self.view addSubview:citybar];

}

- (void)setupNextMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = nil;

    [self.view addSubview:self.calendarView];
    self.calendarView.allDaysArr = [NSArray arrayWithObjects:  @"17",  @"21", @"25",  @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"19",nil];
    self.date = [self.calendarView nextMonth:self.date];
    [self.calendarView createCalendarViewWith:self.date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}

- (void)setupLastMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = nil;

    [self.view addSubview:self.calendarView];
    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"6", @"8", @"9", @"11", @"16", @"17", @"21", @"25",  @"30", nil];
    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"29", @"12",@"15", @"18", @"19",nil];
    self.date = [self.calendarView lastMonth:self.date];
    [self.calendarView createCalendarViewWith:self.date];
    WS(weakSelf)
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
          };
  
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
