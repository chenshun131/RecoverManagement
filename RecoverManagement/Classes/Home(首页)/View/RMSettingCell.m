//
//  RMSettingCell.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/28.
//  Copyright © 2016年 回收哥. All rights reserved.
//


#import "PlaceholderTextView.h"
#import "RMSettingCell.h"
#import "RMSettingItem.h"
#import "RMTextItem.h"
#import "RMTFieldItem.h"
#import "RMCollectionItem.h"
#import "RMMeetingHeadCell.h"
@interface RMSettingCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UIView *customView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation RMSettingCell


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"SettingCell";
    RMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[RMSettingCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}


-(void)setItem:(RMSettingItem *)item{
    _item = item;
    
    
    if([item isKindOfClass:[RMTextItem class]]){
        [self textViewCellwithItem:item];
        return;
    }
    if([item isKindOfClass:[RMTFieldItem class]]){
        [self  textFieldCellwithItem:item];
        return;
    }
    if([item isKindOfClass:[RMCollectionItem class]]){
      [self collectionCellwithItem:item];
        return;
    }
    //显示图片和标题
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item. subTitle;
    self.detailTextLabel.textColor = [UIColor blueColor];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)textViewCellwithItem:(RMSettingItem *)item{
    RMTextItem *textItem =(RMTextItem*)item;
    [ self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    PlaceholderTextView *TextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, textViewH)];
    TextView.placeholder = textItem.placeholder;
    TextView.placeholderFont = textItem.placeholderFont;
    TextView. placeholderColor =textItem.placeholderColor;
    [ TextView   addMaxTextLengthWithMaxLength:KScreenWidth-20 andEvent:nil];
    _customView =TextView;
    [self.contentView addSubview:TextView];
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)textFieldCellwithItem:(RMSettingItem *)item{
    RMTFieldItem *textItem =(RMTFieldItem*)item;
      [ self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc ]initWithFrame:CGRectMake(15, 8, 80, 20)];
    title.text =textItem.title;
      [self.contentView addSubview:title];
    UITextField *TextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title.frame)+20, 5,180 , 20)];
    TextField.placeholder = textItem.placeholder;
    TextField.font = textItem.placeholderFont? textItem.placeholderFont:RMText15Font;
    TextField. placeholder =textItem.placeholder;
    _customView  = TextField;
    [self.contentView addSubview:TextField];
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (void)collectionCellwithItem:(RMSettingItem *)item{
    RMCollectionItem *collItem =(RMCollectionItem*)item;
    [ self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc ]initWithFrame:CGRectMake(15, 8, 70, 30)];
    title.text =collItem.title;
    [self.contentView addSubview:title];
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.itemSize = CGSizeMake(100, 130);
    flowLayout.sectionInset = UIEdgeInsetsMake(0,20, 0, 20);
    UICollectionView *collectoinView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, collViewH-45) collectionViewLayout:flowLayout];
      [collectoinView registerClass:[RMMeetingHeadCell class] forCellWithReuseIdentifier:@"HeadCell"];
    collectoinView.dataSource=self;
    collectoinView.delegate=self;
    [collectoinView setBackgroundColor:[UIColor clearColor]];
    self.data =collItem.collectionArray.mutableCopy;
    [self.contentView addSubview:collectoinView];
    self.accessoryType = UITableViewCellAccessoryNone;
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;

//    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(60, 60);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RMMeetingHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeadCell" forIndexPath:indexPath];
    
    if (_data.count>0) {
       cell. imgView.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",_data[indexPath.item] ]];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
