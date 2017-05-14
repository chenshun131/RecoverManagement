//
//  RMAttendanceDetailViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/2.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMAttendanceDetailViewController.h"
#import "RMApplyViewController.h"
@interface RMAttendanceDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *qingjiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *buqianBtn;
@property (nonatomic, copy) NSString *  applyTypeEnumNumber;
@end

@implementation RMAttendanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor blackColor];
   self. qingjiaBtn.layer.borderColor = [UIColor orangeColor].CGColor;
      self. buqianBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self. qingjiaBtn.layer.borderWidth = 1.5;
    self. buqianBtn.layer.borderWidth = 1.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//请假(1)||补签(3)
- (IBAction)BtnClick:(UIButton *)sender {
   _applyTypeEnumNumber  = [NSString stringWithFormat:@"%ld" ,sender.tag ];
    RMApplyViewController *applyVC = [[RMApplyViewController alloc]init];
    applyVC.applyTypeEnumNumber =_applyTypeEnumNumber;
    NSString *state =sender.tag==1?@"请假":@"补签";
    applyVC.title =[NSString stringWithFormat:@" 考勤-%@申请" ,state];

    [self.navigationController pushViewController:applyVC animated:YES];
}

@end
