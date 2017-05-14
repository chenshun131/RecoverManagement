//
//  GuideViewController.m
//  ACONApp
//
//  Created by 朱红轻飞溅 on 14/11/25.
//  Copyright (c) 2014年 zw. All rights reserved.
//

#import "GuideViewController.h"
#import "UIView+FLKAutoLayout.h"
#import "LoginViewController.h"
#import "RMTabBarViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_page1View;
    UIImageView *_page2View;
    UIImageView *_page3View;
    UIImageView *_page4View;
    
    UIButton *nextBtn;
    
    UIPageControl *pageControl;
    
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置状态栏颜色
    self.statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    self.statusBarView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.statusBarView];

    
    [self initViews];
    [self layoutViews];
    
}

- (void)initViews
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.userInteractionEnabled=YES;
    [self.view addSubview:_scrollView];
    
       /**
     *  添加引导页
     */
    _page1View = [[UIImageView alloc] init];
    _page1View.userInteractionEnabled = YES;
    
   
  
    [_scrollView addSubview:_page1View];
    
    _page2View = [[UIImageView alloc] init];
    _page2View.userInteractionEnabled = YES;
 
    [_scrollView addSubview:_page2View];
    
    _page3View = [[UIImageView alloc] init];
    _page3View.userInteractionEnabled = YES;
   
    _page1View.image = [UIImage imageNamed:@"welcome1"];
    _page2View.image = [UIImage imageNamed:@"welcome2"];
    _page3View.image = [UIImage imageNamed:@"welcome3"];

    [_scrollView addSubview:_page3View];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAction)];
    [_page3View addGestureRecognizer:tap];

}


- (void)layoutViews
{
    [_scrollView alignToView:self.view];

    
    
    float screenWidth = self.view.frame.size.width;
    float screenHeight = self.view.frame.size.height;
    

    
    [_page1View constrainWidth:@(screenWidth).stringValue];
    [_page1View constrainHeight:@(screenHeight).stringValue];
    
    [_page1View alignTop:@"0" leading:@"0" toView:_scrollView];
    
    
    [_page2View constrainWidth:@(screenWidth).stringValue];
    [_page2View constrainHeight:@(screenHeight).stringValue];
    [_page2View alignTop:@"0" leading:@(screenWidth).stringValue toView:_scrollView];
    
    
    
    [_page3View constrainWidth:@(screenWidth).stringValue];
    [_page3View constrainHeight:@(screenHeight).stringValue];
    [_page3View alignTop:@"0" leading:@(screenWidth*2).stringValue toView:_scrollView];
    [_page3View alignTrailingEdgeWithView:_scrollView predicate:@"0"];
    
    
}
//-(void)pageChange
//{
////    int currenPage =pageControl.currentPage;
//    //用当前点数乘以单位偏移量
//    [_scrollView setContentOffset:CGPointMake(pageControl.currentPage *KScreenWidth, 0) animated:YES];
//}
#pragma mark - page control
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x==0)
    {
        pageControl.currentPage = 0;
    }
    else if (scrollView.contentOffset.x==KScreenWidth)
    {
        pageControl.currentPage = 1;

    }
    else if (scrollView.contentOffset.x==KScreenWidth*2)
    {
        pageControl.currentPage = 2;

    }else if (scrollView.contentOffset.x>KScreenWidth*2){
        [self enterAction];
    }
}


- (void)enterAction
{
    
    RMTabBarViewController *VC = [[RMTabBarViewController alloc]init];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    VC.navigationController.navigationBarHidden=YES;
    AppDelegate *app =[UIApplication sharedApplication].delegate;
    app.window.rootViewController = nav;
    
   [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_HAS_LAUNCHED_ONCE];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
