//
//  RMSignBtn.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/15.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMSignBtn.h"

@implementation RMSignBtn
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
         self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = contentRect.size.width/3;
    
    return CGRectMake(0, 0, contentRect.size.width, imageX*2);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
     CGFloat imageX = contentRect.size.width/3;
   
    
    return CGRectMake(0, imageX*2, contentRect.size.width, imageX);
}

@end
