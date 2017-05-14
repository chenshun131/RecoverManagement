//
//  RMLeftImageButton.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/9.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMLeftImageButton.h"

@implementation RMLeftImageButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor grayColor];
        self.selected = NO;
      
    }
    return self;
}




@end
