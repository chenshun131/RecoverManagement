//
//  RMAddressListTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/2.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMAddressListTableViewCell.h"

@implementation RMAddressListTableViewCell

- (void)initWithName:(NSString *)name andDepartment:(NSString *)department andJob:(NSString *)job andState:(NSString *)state andImageUrl:(NSString *)imageUrl andChooseState:(BOOL)chooseState{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if ([state isEqualToString:@"xuanze"]) {
        _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
        [_selectBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectBtn];
        
        _selectBtn.selected = chooseState;
        
        _cellSelectButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5,40, 40)];
      
        [self.contentView addSubview:_cellSelectButton];
        _cellSelectButton.selected = chooseState;

        
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 35, 35)];
    if ([state isEqualToString:@"xuanze"]){
        imageView.frame = CGRectMake(45, 8, 35, 35);
    }
    imageView.layer.cornerRadius = 3;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+15, 17, 200, 15)];
    nameLabel.text = name;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [nameLabel sizeToFit];
    [self.contentView addSubview:nameLabel];
  
    UILabel *zhiweiLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), nameLabel.frame.origin.y, KScreenWidth-CGRectGetMaxX(nameLabel.frame)-15, 15)];
    zhiweiLabel.text = [NSString stringWithFormat:@"-%@-%@",department,job];
    zhiweiLabel.textColor = LMColor(150, 150, 150);
    zhiweiLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:zhiweiLabel];
}

- (void)selectBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
