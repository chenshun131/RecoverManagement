//
//  RMShapedImageView.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/11/10.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMShapedImageView.h"
@interface RMShapedImageView()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end
@implementation RMShapedImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
//    _maskLayer = [CAShapeLayer layer];
//    _maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
//    _maskLayer.fillColor = [UIColor blackColor].CGColor;
//    _maskLayer.strokeColor = [UIColor redColor].CGColor;
//    _maskLayer.frame = self.bounds;
//    _maskLayer.contentsCenter = CGRectMake(1, 1, 0.1, 0.1);
//    _maskLayer.contentsScale = [UIScreen mainScreen].scale;
//    
//    _contentLayer = [CALayer layer];
//    _contentLayer.mask = _maskLayer;
//    _contentLayer.frame = self.bounds;
//    [self.layer addSublayer:_contentLayer];
    
    float viewWidth = 80;
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    [[UIColor whiteColor] setStroke];
    [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2), (viewWidth / 4))];
    [path addLineToPoint:CGPointMake((viewWidth / 2), 0)];
    [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)), (viewWidth / 4))];
    [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)), (viewWidth / 2) + (viewWidth / 4))];
    [path addLineToPoint:CGPointMake((viewWidth / 2), viewWidth)];
    [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2), (viewWidth / 2) + (viewWidth / 4))];
    [path closePath];
    
    CAShapeLayer * shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapLayer.path = path.CGPath;
  //  _headerImageView.layer.mask = shapLayer;
    
}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}
@end
