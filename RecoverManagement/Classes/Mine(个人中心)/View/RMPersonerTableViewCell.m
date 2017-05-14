//
//  RMPersonerTableViewCell.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMPersonerTableViewCell.h"

@implementation RMPersonerTableViewCell

- (void)initWithIndex:(NSInteger)index andImageName:(NSString *)imageName andData:(NSString *)data andTitle:(NSString *)title andCanEdit:(BOOL)canEdit{
    //解决复用
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
    if ([title isEqualToString:@"入职"]) {
        imageV.frame = CGRectMake(14, 15, 12, 20);
    }else if ([title isEqualToString:@"电话"]) {
        imageV.frame = CGRectMake(12, 17, 16, 16);
    }
    else if ([title isEqualToString:@"邮箱"]) {
        imageV.frame = CGRectMake(12, 18, 16, 13);
    }
    imageV.image = [UIImage imageNamed:imageName];
    [self.contentView addSubview:imageV];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(38, 17, 35, 15)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:titleLabel];
    
    if (canEdit == YES) {
        if (index>0) {
            UIImageView *rightImagev = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-15-5, 19, 8, 12)];
            rightImagev.image = [UIImage imageNamed:@"disclosure-arrow--"];
            [self.contentView addSubview:rightImagev];
        }
    }
    
    UILabel *dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+18, 17, KScreenWidth-45-CGRectGetMaxX(titleLabel.frame), 60)];
    
    dataLabel.text = data;
    dataLabel.textAlignment = NSTextAlignmentRight;
    dataLabel.textColor = RMColor(80, 80, 80);
    dataLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:dataLabel];
    if (index != 3) {
        dataLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+18, 17, KScreenWidth-45-CGRectGetMaxX(titleLabel.frame), 15);

    }else{
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:dataLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];//行间距
        [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [dataLabel.text length])];
        dataLabel.attributedText = attStr;
        
        dataLabel.numberOfLines = 0;
        [dataLabel sizeToFit];
    }
    
    if (canEdit == NO) {
        dataLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+18, 17, KScreenWidth-33-CGRectGetMaxX(titleLabel.frame), 15);
    }
    
    CGRect frame = CGRectMake(0, 0, KScreenWidth, CGRectGetMaxY(dataLabel.frame)+18);
    self.frame = frame;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
