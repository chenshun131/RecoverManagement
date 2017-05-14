//
//  RMHomeCollectionCell.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/26.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMHomeCollectionCell.h"
#import "RMHomeCellModel.h"

@interface RMHomeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *homeCellImage;
@property (weak, nonatomic) IBOutlet UILabel *homeCellTitle;
@property (weak, nonatomic) IBOutlet UILabel *homeCellSubtitle;

@end
@implementation RMHomeCollectionCell
- (void)setData:(BaseModel *)model{
    _data = model;
    if ([model isKindOfClass:[RMHomeCellModel class]]) {
        RMHomeCellModel *data =(  RMHomeCellModel *)model;
          _homeCellTitle.text = data.title;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:[NSDate date] ];
        if( data.time){
            _homeCellSubtitle.text = data.time.length>0?destDateString: data.badgeNumber.length>0?data.badgeNumber:@"";
        }
        if ([data.backGroundColor hasPrefix:@"0x"] || [data.backGroundColor hasPrefix:@"#"]) {
            self.backgroundColor = [UIColor colorWithHexString:data.backGroundColor];
        }
        _homeCellImage .image= [UIImage imageNamed:data.imageName];
        _homeCellImage.contentMode =data.isBigger?(UIViewContentModeScaleAspectFill):(UIViewContentModeScaleAspectFit);

    } else if ([model isKindOfClass:[RMProcessApprovalModel class]]){
          RMProcessApprovalModel *data =(  RMProcessApprovalModel *)model;
          _homeCellTitle.text = data.title;
        if ([data.backGroundColor hasPrefix:@"0x"] || [data.backGroundColor hasPrefix:@"#"]) {
            self.backgroundColor = [UIColor colorWithHexString:data.backGroundColor];
        }
        _homeCellImage .image= [UIImage imageNamed:data.imageName];
    }

    
   
 
    
}
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

@end
