//
//  RMNotifyViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/15.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMNotifyViewController.h"
#import "RMNotifyTableViewCell.h"
#import "RMNotifyDetailViewController.h"
@interface RMNotifyViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) NSArray *data;
@end

@implementation RMNotifyViewController
{
    NSArray *titles;
    NSArray * Images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMainView];
    titles = @[@"公司要闻",@"放假通知",@"行政通知",@"会议通知",@"其他通知"];
    Images = @[@"xinwen",@"fangjiatongzhi",@"xingzhengtongzhi",@"huiyitongzhi",@"qitatongzhi"];
}
- (NSArray *)data{
    if (!_data) {
        
        _data =  @ [];
    }
    return _data;
}
- (void)setMainView{
    ///搜索
    UIView *souBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
    souBgView.backgroundColor = LMColor(226, 226, 226);
    souBgView.userInteractionEnabled  =YES;
    [self.view addSubview:souBgView];
    
    UIView *bgWhiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 8, KScreenWidth-30, 30)];
    bgWhiteView.backgroundColor = [UIColor whiteColor];
    bgWhiteView.userInteractionEnabled = YES;
    bgWhiteView.layer.cornerRadius = 5;
    bgWhiteView.layer.masksToBounds = YES;
    [souBgView addSubview:bgWhiteView];
    
    UIImageView *souImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 15, 15)];
     souImageV.image = [UIImage imageNamed:@"search-icon-hui"];
    [bgWhiteView addSubview:souImageV];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(souImageV.frame)+5,0 ,KScreenWidth-60 , 30)];
    textF.delegate  =self;
    [bgWhiteView addSubview:textF];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, KScreenWidth, KScreenHeight-45) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"RMNotifyTableViewCell" bundle:nil]  forCellReuseIdentifier:@"NotifyCell" ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    return titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RMNotifyTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"NotifyCell"];
    cell.headImage.image = [UIImage imageNamed:Images[indexPath.row]];
    cell.badgeImage.image = [UIImage imageNamed:@"tishidian"];
    cell.titleNotify.text = titles[indexPath.row];
    cell.subtitleNotify.text = @"2016-10-5";
    cell.headImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.badgeImage.contentMode = UIViewContentModeScaleAspectFit;
    return cell;
}

#pragma mark cell的点中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMNotifyDetailViewController *vc = [[RMNotifyDetailViewController alloc]init];
   vc.title = titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
