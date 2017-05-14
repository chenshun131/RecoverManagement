//
//  RMMeetingHeadCell.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/15.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMMeetingHeadCell.h"

@implementation RMMeetingHeadCell
- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
        _imgView.userInteractionEnabled = YES;
           _imgView.layer.cornerRadius = 30;
         _imgView.image = [UIImage imageNamed:@"touxiang"];
        
        [self addSubview:_imgView];
      
    }
    
    
    return self;
}
@end
