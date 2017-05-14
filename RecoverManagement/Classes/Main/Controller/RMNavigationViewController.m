//
//  RMNavigationViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMNavigationViewController.h"
#import "UIBarButtonItem+Item.h"
@interface RMNavigationViewController ()

@end

@implementation RMNavigationViewController
+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[RMNavigationViewController class]]];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //导航颜色
[[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    //默认带有一定透明效果，可以使用以下方法去除系统效果
    [self.navigationBar setTranslucent:NO];
    // 设置导航默认标题的颜色及字体大小
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance]  setTitleTextAttributes:dict];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"fanhui"] highImage:[UIImage imageNamed:@"fanhui"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.rightBarButtonItem = right;
    }
    
    [super pushViewController:viewController animated:animated];
    
}
- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
