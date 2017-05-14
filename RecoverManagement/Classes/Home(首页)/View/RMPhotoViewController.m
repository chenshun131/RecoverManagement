//
//  RMPhotoViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//
#import "BMPopView.h"
#import "RMPhotoViewController.h"
#import "RMAttendanceMessageView.h"
@interface RMPhotoViewController ()

@end

@implementation RMPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.image = self.backgroundImage;
    imageV.contentMode = UIViewContentModeScaleToFill;
    self.view  = imageV;
    BMPopView *pop =  [BMPopView shareInstance];
    [pop showWithContentView:  [self popViewState:NO]];
  
}
-(UIView *)popViewState:(BOOL)success{
 
    UIView *popView = [[UIView alloc]initWithFrame:self.view.bounds];
    RMAttendanceMessageView * messageView = [RMAttendanceMessageView messageViewWithOwnNib];
    messageView.center = popView.center;
    [popView addSubview:messageView];
    if (success) {
        popView.frame = CGRectMake(0, 100, KScreenWidth, KScreenHeight-100);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMinY(messageView.frame)-40, popView.width, 40)];
  

        label.text = @"签到成功!";
        label.textColor = [UIColor greenColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor  = [UIColor clearColor];
         [popView addSubview:label];
    }else{
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.tag = 1;
        cancelButton.frame = CGRectMake(20, CGRectGetMaxY(messageView.frame), KScreenWidth - 40,  40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor orangeColor] ] ;
        [cancelButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [popView addSubview:cancelButton];
        UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.tag = 2;
        commitButton.frame = CGRectMake(20, CGRectGetMaxY(cancelButton.frame)+10, KScreenWidth - 40,  40);
        [commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor blueColor] ] ;
        [commitButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [popView addSubview:commitButton];
    
    }
  
    return popView;
}
-(void)buttonClick:(UIButton *)sender{
    if (sender.tag==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [[BMPopView shareInstance]  dismiss];
    } else {
            [[BMPopView shareInstance]  dismiss];
           [self dismissViewControllerAnimated:YES completion:^{
               [BMPopView shareInstance] . canDisMiss = YES;
               [BMPopView shareInstance] .customFrame = YES;
            
               [ [BMPopView shareInstance] showWithContentView:  [self popViewState:YES] ];
           }];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
