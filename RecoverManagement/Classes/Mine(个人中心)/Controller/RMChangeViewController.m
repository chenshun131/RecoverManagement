//
//  RMChangeViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMChangeViewController.h"

@interface RMChangeViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate>
{
    PlaceholderTextView *textv;
}
@end

@implementation RMChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = self.titleStr;
    self.view.backgroundColor = RMColor(249, 249, 249);
    [self addLeftView:@""];
    [self addRightBtnWithTitle:@"确定" WithImageName:nil];
    
    [self setView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickView:)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
    
    
}

//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer
{
    for (UIView *child in self.view.subviews) {
        
        // 如果是文本输入框
        if (![child isKindOfClass:[UITextField class]])
            [child endEditing:YES];
        
    }
}


- (void)leftBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
}

- (void)rightClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
}

- (void)setView{
    textv = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 64+10, KScreenWidth, 40)];
    
    if ([_titleStr isEqualToString:@"电话"]) {
        textv.placeholder = @"请输入您的电话号码...";
        textv.keyboardType = UIKeyboardTypePhonePad;
    }else if ([_titleStr isEqualToString:@"邮箱"]) {
        textv.placeholder = @"请输入您的邮箱地址...";
        textv.keyboardType = UIKeyboardTypeEmailAddress;
    }else if ([_titleStr isEqualToString:@"住址"]) {
        
        textv.frame = CGRectMake(0, 64+10, KScreenWidth, 100);
        textv.placeholder = @"请输入您的地址...";
    }
    
    textv.delegate =self;
    textv.placeholderFont = [UIFont systemFontOfSize:16];
    textv.font = [UIFont systemFontOfSize:16];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textv.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textv.text length])];
    textv.attributedText = attributedString;
    
    [self.view addSubview:textv];

}
@end
