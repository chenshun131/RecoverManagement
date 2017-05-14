//
//  RMBaseViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/27.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMBaseViewController.h"

@interface RMBaseViewController ()

@end

@implementation RMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
/**
 *  判断登录
 *
 *  @return 是否登录
 */
- (BOOL)checkLoginStatus{
    NSString *userid = [[NSUserDefaults standardUserDefaults] valueForKey:KUserid];
    if (userid.length > 0) {
        return YES;
    } else {
        return NO;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
