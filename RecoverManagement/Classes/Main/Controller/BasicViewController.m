//
//  BasicViewController.m
//  GreatChargeShoppingMall
//
//  Created by wangjh on 15/10/9.
//  Copyright (c) 2015年 edison. All rights reserved.
//

#import "BasicViewController.h"


@interface BasicViewController ()<UISearchBarDelegate,UITextFieldDelegate>
{
    
}
@end

@implementation BasicViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    MainTabbarController *tabBar = (MainTabbarController *)self.tabBarController;
//    [tabBar hiddenTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //当前类的背景色
    self.view.backgroundColor = [UIColor blackColor];
    

    //设置状态栏颜色
    self.statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
    self.statusBarView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.statusBarView];
    
    _navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];

    _navView.backgroundColor = [UIColor blackColor];


    _navView.userInteractionEnabled = YES;
    [self.view addSubview:_navView];

    //标题
    self.titleLB=[[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-180)/2, 25, 180, 34)];
    self.titleLB.textColor = [UIColor whiteColor];
    self.titleLB.font=[UIFont boldSystemFontOfSize:18];
    self.titleLB.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.titleLB];
 
    
}




- (void)addRightView:(NSString *)imageName andhightimage:(NSString *)hightimageName rightBtn:(NSString *)rightBut
{
    //右按钮
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-75, 20, 75, 44)];
    self.rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.rightBtn setTitleColor:RMColor(170, 170, 170) forState:UIControlStateNormal];
    [self.view addSubview:self.rightBtn];
    
    //右图片
    self.rightImg=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-40, 30, 20, 20)];
    self.rightImg.image =[UIImage imageNamed:imageName];
     self.rightImg.highlightedImage =[UIImage imageNamed:hightimageName];
    [self.rightBtn setTitle:rightBut forState:(UIControlStateNormal)];
    [self.rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.rightImg];
}

- (void)addLeftView:(NSString *)imageName
{
    
    //左边图片
    self.leftImg=[[UIImageView alloc]initWithFrame:CGRectMake(12, 33, 20, 20)];
    self.leftImg.userInteractionEnabled =YES;
    [self.view addSubview:self.leftImg];
    //左边按钮
    self.leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    self.leftImg.image = [UIImage imageNamed:@"fanhui"];
    [self.leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:self.leftBtn];
}

-(void)leftBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)addLabel:(CGRect)frame andText:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14.0];
    
    return label;
}


-(UITextField *)addsearchBar:(NSString *)placeHolder
{
    
    UIView *seaView = [[UIView alloc]initWithFrame:CGRectMake(10, 70, KScreenWidth-20, 45)];
    seaView.backgroundColor = RMColor(182, 214, 204);
    seaView.layer.cornerRadius = 45/2.f;
    seaView.layer.masksToBounds = YES;
    [self.view addSubview:seaView];
    UIImageView *seaImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 9, 25, 25)];
    seaImage.image = [UIImage imageNamed:@"search-.png"];
    [seaView addSubview:seaImage];
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(122, 77, seaView.frame.size.width, 30)];
    textF.font = [UIFont boldSystemFontOfSize:19.0f];
    textF.placeholder = placeHolder;
    textF.delegate = self;
    textF.returnKeyType = UIReturnKeySearch;
  
    textF.font = [UIFont systemFontOfSize:17.0f];
    
    [textF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    return textF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void)addBackBtnWithImageName:(NSString*)imageName{
    
    UIButton *backBtn=[[UIButton alloc]init];
    backBtn.frame=CGRectMake(10, 27, 40, 30);
    [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
}


-(void)addBackBtn{
    
    UIButton *backBtn=[[UIButton alloc]init];
    backBtn.frame=CGRectMake(2, 27, 40, 30);
 
    [backBtn setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backBtn];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)addRightBtnWithTitle:(NSString *)titleName WithImageName:(NSString*)imageName{
    
    UIButton *rightBtn=[[UIButton alloc]init];
    [rightBtn setTitleColor:[UIColor colorWithRed:32/255.0 green:101/255.0 blue:231/255.0 alpha:1] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-50, 27, 40, 30);
    rightBtn.titleLabel.font= [UIFont boldSystemFontOfSize:16];
    
    if (titleName.length>0) {
        
        [rightBtn setTitle:titleName forState:UIControlStateNormal];
    }
    
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    if (imageName.length>0) {
        rightBtn.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-30, 34, 20, 20);
        [rightBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [_navView addSubview:rightBtn];
}

-(void)rightClick:(UIButton*)btn{
    
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

@end
