//
//  BasicViewController.h
//  GreatChargeShoppingMall
//
//  Created by wangjh on 15/10/9.
//  Copyright (c) 2015年 edison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController


@property(nonatomic,strong)UIView *statusBarView;//状态栏


@property(nonatomic,strong)UIImageView *leftImg;//左按钮图片
@property(nonatomic,strong)UILabel *titleLB;//标题
@property(nonatomic,strong)UIButton *leftBtn;//左按钮
@property(nonatomic,strong)UIButton *rightBtn;//右按钮
@property(nonatomic,strong)UIImageView *rightImg;//右按钮
@property(nonatomic,strong)UIView *navView; 
-(UISearchBar *)addsearchBar:(NSString *)placeHolder;


-(void)leftBtnClick:(UIButton *)sender;
-(void)rightBtnClick:(UIButton *)sender;
- (void)addLeftView:(NSString *)imageName;
- (void)addRightView:(NSString *)imageName andhightimage:(NSString *)hightimageName rightBtn:(NSString *)rightBut;
- (UILabel *)addLabel:(CGRect)frame andText:(NSString *)text;


-(void)addBackBtnWithImageName:(NSString*)imageName;

-(void)addBackBtn;

-(void)addRightBtnWithTitle:(NSString *)titleName WithImageName:(NSString*)imageName;
-(void)rightClick:(UIButton*)btn;

//判断登录
- (BOOL)checkLoginStatus;

-(void)back;

@end
