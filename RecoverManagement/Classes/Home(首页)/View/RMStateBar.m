//
//  RMStateBar.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/3.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMStateBar.h"
@interface RMStateBar ()
{
    NSArray *_normalImages;
    NSArray *_seletedImage;
     NSArray *_titles;
    UIButton *_oldButton;
}

@end
@implementation RMStateBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

//设置按钮图片
- (void)setButtonImageWithNormal:(NSArray *)normalImages selectedImages:(NSArray *)selectedImages title:(NSArray *)titles target:(BOOL)target
{
    //赋值
    _normalImages = normalImages;
    _seletedImage = selectedImages;
    _titles =titles;
    
    //计算按钮宽度
    NSInteger buttonWidth = self.frame.size.width/titles.count;
    Class class = NSClassFromString(self.customButtonClassName);
    if (![class isSubclassOfClass:[UIButton class]]) {
      class = NSClassFromString(@"UIButton");
    }
    for (int i = 0; i < titles.count; i++)
    {
        UIButton *button = [[class alloc]initWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth,  self.height)];
      
        //设置图片
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        if (normalImages) {
               [button setImage:[self getButtonImageWith:normalImages[i]] forState:UIControlStateNormal];
               [button sizeToFit];
        }
        if (selectedImages) {
            [button setImage:[self getButtonImageWith:selectedImages[i]] forState:UIControlStateSelected];

        }
        button.tag =  self.subviews.count;
        
        [self addSubview:button];
        if (!target) continue;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
 
        //默认第一个选中
        if (i == 0)
        {
            button.selected = YES;
            _oldButton =button;
        }
        
      
    }

    
}
- (void)buttonClick:(UIButton *)button
{
    _oldButton.selected = NO;
    
    //当前点击按钮
    button.selected =  !button.selected;
    _oldButton = button;
    //2.回调
    if ([_delegate respondsToSelector:@selector(didSelectedIndex:)])
    {
        [_delegate didSelectedIndex:button.tag - 1];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;

    CGFloat  w = self.width / count;
    CGFloat  h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0 ; i < count; i++) {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}
//返回图片对象
- (UIImage *)getButtonImageWith:(id)obj
{
    UIImage *image = nil;
    
    if ([obj isKindOfClass:[UIImage class]])
    {
        image = (UIImage *)obj;
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        image = [UIImage imageNamed:obj];
    }
    
    return image;
}

@end
