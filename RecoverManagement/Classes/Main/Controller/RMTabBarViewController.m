//
//  RMTabBarViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMTabBarViewController.h"
#import "RMNavigationViewController.h"
#import "RMHomeViewController.h"
#import "ManagementViewController.h"
#import "AddressListViewController.h"
#import "PersonerViewController.h"
#import "LoginViewController.h"

@interface RMTabBarViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation RMTabBarViewController
- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpAllChildViewController];
   
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold"  size:13.0f]} forState:UIControlStateNormal];
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold"  size:13.0f]} forState:UIControlStateSelected];
     [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
    // 首页
    RMHomeViewController *home = [[RMHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"shouye"] selectedImage:[UIImage imageWithOriginalName:@"shouyegaoliang"] title:@"首页"];
 
    
    // 审批管理
    ManagementViewController *message = [[ManagementViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"shenpiguanli"] selectedImage:[UIImage imageWithOriginalName:@"shenpigaunligaoliang"] title:@"审批管理"];
   
    
    // 通讯录
    AddressListViewController *discover = [[AddressListViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tongxunlu"] selectedImage:[UIImage imageWithOriginalName:@"tongxunlugao"] title:@"通讯录"];
    
    
    // 个人中心
    PersonerViewController *profile = [[PersonerViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"gerenzhongxin"] selectedImage:[UIImage imageWithOriginalName:@"gerenzhongxingaoliang"] title:@"个人中心"];
  
}


#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    // 设置子控件对应tabBarItem的模型属性
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    RMNavigationViewController *nav = [[RMNavigationViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
