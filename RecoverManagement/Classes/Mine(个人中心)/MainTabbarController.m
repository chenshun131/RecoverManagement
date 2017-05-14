//
//  MainTabbarController.m
//  HealthySay
//
//  Created by 苏荷 on 15/12/10.
//  Copyright (c) 2015年 wang. All rights reserved.
//

#import "MainTabbarController.h"
#import "FirstViewController.h"
#import "ManagementViewController.h"
#import "AddressListViewController.h"
#import "PersonerViewController.h"

#import "LoginViewController.h"

#import <UIKit/UIKit.h>
@interface MainTabbarController ()


@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FirstViewController *vc1 = [[FirstViewController alloc]init];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    
    ManagementViewController *vc2 = [[ManagementViewController alloc]init];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    AddressListViewController *vc3 = [[AddressListViewController alloc]init];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    
    PersonerViewController *vc4 = [[PersonerViewController alloc]init];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    
    self.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
    


}

@end
