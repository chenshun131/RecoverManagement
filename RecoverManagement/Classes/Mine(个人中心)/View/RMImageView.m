//
//  RMImageView.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/10.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMImageView.h"

@implementation RMImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(100.0, 0.0)];
    
    // Draw the lines
    [aPath addLineToPoint:CGPointMake(200.0, 40.0)];
    [aPath addLineToPoint:CGPointMake(160, 140)];
    [aPath addLineToPoint:CGPointMake(40.0, 140)];
    [aPath addLineToPoint:CGPointMake(0.0, 40.0)];
    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    [aPath stroke];//Draws line 根据坐标点连线
}


@end
