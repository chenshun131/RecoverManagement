//
//  RMApprovalViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/8.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMApprovalViewController.h"
#import "AddressListViewController.h"
#import "RMApproverCollectionViewCell.h"
#import "RMWillTodoAllViewController.h"
#import "WillTodoLeaveViewController.h"
#import "WillTodoRetroactiveViewController.h"
#import "RMWillToDoWorkOvertimeViewController.h"

@interface RMApprovalViewController ()<UITextViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIScrollView *backgroundScrollView;
    NSArray *approverArr;
    UIView *nextStepApproverView;
    UILabel *omitLabel;
    
    UICollectionView *approverCollectionView;
    
    UITapGestureRecognizer *tap;
}


@end

@implementation RMApprovalViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backXuanZe:) name:@"tongzhini" object:nil];

}

- (void)backXuanZe:(NSNotification *)noti{
    approverArr = noti.userInfo[@"NameArr"];
    
    if (approverArr.count<4) {
        approverCollectionView.frame = CGRectMake(KScreenWidth-10-45*approverArr.count, 15, 45*approverArr.count-5, 55);
        omitLabel.hidden = YES;
    }else{
        approverCollectionView.frame = CGRectMake(KScreenWidth-30-45*3, 15, 45*3-5, 55);
        omitLabel.hidden = NO;
    }
    [approverCollectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = self.titleLB.text = [NSString stringWithFormat:@"%@审批-通过",_state];
    [self addLeftView:@""];
    
    self.view.backgroundColor = LMColor(249, 249, 249);
     approverArr = @[@"兮兮"];
    [self setView];
    
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

- (void)leftBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    backgroundScrollView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-height);
    [UIView commitAnimations];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification {
    backgroundScrollView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight-64);
}

//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer{
    for (UIView *child in self.view.subviews) {
        // 如果是文本输入框
        if (![child isKindOfClass:[UITextField class]])
            [child endEditing:YES];
        
    }
}

- (void)setView{
    backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    backgroundScrollView.userInteractionEnabled = YES;
    backgroundScrollView.delegate =self;
    backgroundScrollView.scrollEnabled =YES;
    backgroundScrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:backgroundScrollView];
    
    backgroundScrollView.contentSize = CGSizeMake(KScreenWidth, KScreenHeight-64);
    
    UIView *bgView  = [[UIView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth, 280)];
    bgView.backgroundColor = [UIColor whiteColor];
    [backgroundScrollView addSubview:bgView];
    
    UILabel *nowApproverLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 150, 15)];
    nowApproverLabel.text=@"当前步骤审批人";
    nowApproverLabel.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:nowApproverLabel];
    
    UIImageView *nowApproverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-15-40, 15, 40, 40)];
    nowApproverImageView.layer.cornerRadius = 20;
    nowApproverImageView.layer.masksToBounds = YES;
    nowApproverImageView.image = [UIImage imageNamed:@"touxiang"];
    [bgView addSubview:nowApproverImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-70, CGRectGetMaxY(nowApproverImageView.frame)+2, 70, 13)];
    nameLabel.text = @"李四";
    nameLabel.textColor = LMColor(50, 50, 50);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:nameLabel];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 84, KScreenWidth, 1)];
    line1.backgroundColor = LMColor(230, 230, 230);
    [bgView addSubview:line1];
    
    UILabel *shenpiOpinionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line1.frame), 80, 50)];
    shenpiOpinionLabel.text = @"审批意见";
    shenpiOpinionLabel.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:shenpiOpinionLabel];
    
    UILabel *vetoOpinionLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-15-100, shenpiOpinionLabel.frame.origin.y, 100, 50)];
    vetoOpinionLabel.text = @"通过";
    vetoOpinionLabel.textColor = LMColor(0, 164, 74);
    vetoOpinionLabel.textAlignment = NSTextAlignmentRight;
    vetoOpinionLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:vetoOpinionLabel];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shenpiOpinionLabel.frame), KScreenWidth, 1)];
    line2.backgroundColor = LMColor(230, 230, 230);
    [bgView addSubview:line2];
    
    UIView *yijianView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame), KScreenWidth, 150)];
    yijianView.backgroundColor  = [UIColor whiteColor];
    yijianView.userInteractionEnabled = YES;
    [backgroundScrollView addSubview:yijianView];
    
    UILabel *yijianLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 15)];
    yijianLabel.text = @"补充意见";
    yijianLabel.font = [UIFont systemFontOfSize:16];
    [yijianView addSubview:yijianLabel];
    
    UITextView *yijianTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 40, KScreenWidth-30, 100)];
    yijianTextView.text = @"同意。";
    yijianTextView.font = [UIFont systemFontOfSize:15];
    yijianTextView.delegate = self;
    yijianTextView.layer.cornerRadius = 2;
    yijianTextView.layer.borderColor = LMColor(230, 230, 230).CGColor;
    yijianTextView.layer.borderWidth = 1;
    [yijianView addSubview:yijianTextView];
    
    nextStepApproverView  = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(bgView.frame)+15, KScreenWidth, 85)];
    nextStepApproverView.backgroundColor = [UIColor whiteColor];
    nextStepApproverView.userInteractionEnabled = YES;
    [backgroundScrollView addSubview:nextStepApproverView];
    
    UILabel *nextStepApproverLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, 150, 15)];
    nextStepApproverLabel.text=@"下一步骤审批人";
    nextStepApproverLabel.font = [UIFont systemFontOfSize:16];
    [nextStepApproverView addSubview:nextStepApproverLabel];
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    approverCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(KScreenWidth-15-40, 15, 40, 55) collectionViewLayout:flowLayout];
    approverCollectionView.delegate = self;
    approverCollectionView.dataSource = self;
    approverCollectionView.backgroundColor = [UIColor clearColor];
  
    //collectionCell的注册
    [approverCollectionView registerClass:[RMApproverCollectionViewCell class] forCellWithReuseIdentifier:@"myheheIdentifier"];
    [nextStepApproverView addSubview:approverCollectionView];
    

    omitLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth-30, 35, 20, 20)];
    omitLabel.text = @"...";
    [nextStepApproverView addSubview:omitLabel];
    omitLabel.hidden = YES;
 
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nextStepApproverView.frame), KScreenWidth-20, 30)];
    hintLabel.text = @"*点击用户头像更换当前步骤审批人*";
    hintLabel.textColor = LMColor(150, 150, 150);
    hintLabel.textAlignment = NSTextAlignmentRight;
    hintLabel.font = [UIFont systemFontOfSize:13];
    [backgroundScrollView addSubview:hintLabel];
    
    UIButton *tijiaoBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(nextStepApproverView.frame)+65, KScreenWidth-60, 40)];
    [tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    tijiaoBtn.backgroundColor  = LMColor(32, 102, 233);
    [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tijiaoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [tijiaoBtn addTarget:self action:@selector(tijiaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundScrollView addSubview:tijiaoBtn];
    

    
}

#pragma mark -- textview delegate
-(void)textViewDidBeginEditing:(UITextView *)textView{
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickView:)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.view removeGestureRecognizer:tap];
}


#pragma mark -- collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (approverArr.count<4) {
        return approverArr.count;
    }else{
        return 3;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RMApproverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myheheIdentifier" forIndexPath:indexPath];
    
    if (!cell) {
      
    }
  
    [cell initWithImageUrl:@"" andName:approverArr[indexPath.row]];
    
    
    return cell;

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    return CGSizeMake(40, 55);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AddressListViewController *vc = [[AddressListViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.stateStr = @"xuanze";
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)tijiaoBtnClick:(UIButton *)sender{
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[WillTodoLeaveViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }else if ([vc isKindOfClass:[WillTodoRetroactiveViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }else if ([vc isKindOfClass:[RMWillToDoWorkOvertimeViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }else if ([vc isKindOfClass:[RMWillTodoAllViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }

}
@end
