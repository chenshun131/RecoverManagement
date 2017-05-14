//
//  RMDatePicker.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/31.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMDatePicker.h"
#define pickerH  280

@interface RMDatePicker()

@property (strong, nonatomic)UIView* BGView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic)NSString * selectedString;
@end
@implementation RMDatePicker

+(instancetype)pickerWithOwnNib{
    NSArray* nibs = [[NSBundle mainBundle]loadNibNamed:@"RMDatePicker" owner:nil options:nil];
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
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm"];
   
        NSString *dataString =  [dateFormatter stringFromDate:[self.datePicker date]];
        BOOL close = self.doneBlock(dataString);
        
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




@end
