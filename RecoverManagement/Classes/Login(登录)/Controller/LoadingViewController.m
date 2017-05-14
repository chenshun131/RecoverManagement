//
//  LoadingViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "LoadingViewController.h"
#import "GuideViewController.h"
#import "RMTabBarViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self performSelector:@selector(initContentView) withObject:nil afterDelay:2];
}

- (void)initContentView
{
    [self checkFirshTimeLaunch];
}

/**
 *  检查是否第一次登陆
 
 */
- (void)checkFirshTimeLaunch
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:KEY_HAS_LAUNCHED_ONCE])
    {
        
        RMTabBarViewController *VC = [[RMTabBarViewController alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
        VC.navigationController.navigationBarHidden = YES;
        self.view.window.rootViewController = nav;
        
    }
    else
    {
        [self presentIntro];
    }
}

/**
 *  引导页
 */
-(void)presentIntro {
    
    GuideViewController *vc=[[GuideViewController alloc] init];
    vc.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}


@end
