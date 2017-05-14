//
//  RMSettingPicker.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//
#define pickerH  280
#import "RMPickerView.h"
@interface RMPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic)UIView* BGView;
@property (strong, nonatomic)NSString * selectedString;
@end
@implementation RMPickerView

+(instancetype)pickerWithOwnNib{
    NSArray* nibs = [[NSBundle mainBundle]loadNibNamed:@"RMSettingPicker" owner:nil options:nil];
    return nibs.firstObject;
}

-(void)show{
    if (!_BGView ) {
        _BGView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _BGView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.75];
        _BGView.alpha = 0.0;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:_BGView];
    [_BGView addSubview:self];
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, pickerH);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(0, -pickerH);
        _BGView.alpha = 1.0;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.transform = CGAffineTransformIdentity;
        _BGView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_BGView removeFromSuperview];
    }];
}

- (IBAction)done:(id)sender {
    if (self.doneBlock) {
        BOOL close = self.doneBlock(self.selectedString);
        
        if (close) {
            [self close:nil];
        }
    }else{
        [self close:nil];
    }
    
}
- (IBAction)close:(id)sender {
    [self hide];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _pickerArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedString = _pickerArray[row];
    
}

@end
