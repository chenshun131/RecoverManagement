//
//  LoginViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "LoginViewController.h"
#import "RMTabBarViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *mainScrollView;
    UIImageView *bgVeiw;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    self.navigationController.navigationBarHidden = YES;
    
    [self setBgView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickView:)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    
    NSDictionary *userInfo = [aNotification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    int height = keyboardRect.size.height;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    NSTimeInterval animatonDuration = 0.25f;
    [UIView setAnimationDuration:animatonDuration];
    
    mainScrollView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight-height);
    [UIView commitAnimations];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    mainScrollView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
}

//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer{
    for (UIView *child in self.view.subviews) {
        // 如果是文本输入框
        if (![child isKindOfClass:[UITextField class]])
            [child endEditing:YES];
        
    }
}

- (void)setBgView{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    mainScrollView.delegate = self;
   // mainScrollView.autoresizingMask = ;
    mainScrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:mainScrollView];
    
    mainScrollView.contentSize = CGSizeMake(KScreenWidth,KScreenHeight);
    
    bgVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    bgVeiw.image = [UIImage imageNamed:@"bg"];
    bgVeiw.userInteractionEnabled = YES;
    [mainScrollView addSubview:bgVeiw];
    
    UIImageView *hsgImageV = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/3, KScreenHeight/5, KScreenWidth/3, KScreenHeight/5)];
    hsgImageV.image = [UIImage imageNamed:@"logo"];
    [bgVeiw addSubview:hsgImageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/4+5, CGRectGetMaxY(hsgImageV.frame) + 15, KScreenWidth/2-10, 30)];
    label.text = @"企业管理平台";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:24];
    
    [bgVeiw addSubview:label];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label.frame)+30, KScreenWidth-60, 90)];
    backView.userInteractionEnabled = YES;
    [bgVeiw addSubview:backView];
    
    UIImageView *phoneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 15, 17)];
    phoneImageView.image = [UIImage imageNamed:@"yonghu"];
    [backView addSubview:phoneImageView];
    
    UITextField *phoneTextF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImageView.frame)+5, 22, KScreenWidth-110, 17)];
    phoneTextF.placeholder = @"用户工号";
    [phoneTextF setValue:LMColor(145, 176, 203) forKeyPath:@"_placeholderLabel.textColor"];
    phoneTextF.font = [UIFont boldSystemFontOfSize:14];
    [backView addSubview:phoneTextF];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(8, 45, KScreenWidth-76, 1)];
    line.image = [UIImage imageNamed:@"wenbenline"];
    [backView addSubview:line];
    
    UIImageView *passwordImageV = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame)+22, 15, 17)];
    passwordImageV.image = [UIImage imageNamed:@"mima"];
    [backView addSubview:passwordImageV];
    
    UITextField *passwordTextF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneImageView.frame)+5, CGRectGetMaxY(line.frame)+22, KScreenWidth-110, 17)];
    passwordTextF.placeholder = @"密码";
    [passwordTextF setValue:LMColor(145, 176, 203) forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextF.font = [UIFont boldSystemFontOfSize:14];
    [backView addSubview:passwordTextF];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(8, CGRectGetMaxY(line.frame)+44, KScreenWidth-76, 1)];
    line2.image = [UIImage imageNamed:@"wenbenline"];
    [backView addSubview:line2];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(backView.frame)+45, KScreenWidth-60, 40)];
    loginBtn.backgroundColor = RMColor(32, 102, 233);
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgVeiw addSubview:loginBtn];
}

- (void)loginBtnClick:(UIButton *)sender{
    RMTabBarViewController *tb = [[RMTabBarViewController alloc]init];
    [self.navigationController pushViewController:tb animated:YES];
}


@end
