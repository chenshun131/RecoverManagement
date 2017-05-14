//
//  RMNotifyDetailViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/16.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMNotifyDetailViewController.h"
#import "RMNotifyDetailTableViewCell.h"
#import "RMNotifyDetailModel.h"
@interface RMNotifyDetailViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView ;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation RMNotifyDetailViewController
{
    NSArray *titles;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     titles = @[@{@"titleDetailNotify":@"公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻公司要闻",@"subtitleDetailNotify":@"2016-10-5"},@{@"titleDetailNotify":@"放假通知放假通知放假通知放假通知放假通知",@"subtitleDetailNotify":@"2016-10-5"},@{@"titleDetailNotify":@"行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知行政通知",@"subtitleDetailNotify":@"2016-10-5"},@{@"titleDetailNotify":@"会议通知会议通知会议通知会议通知",@"subtitleDetailNotify":@"2016-10-5"},@{@"titleDetailNotify":@"其他通知其他通知其他通知其他通知其他通知其他通知",@"subtitleDetailNotify":@"2016-10-5"}];
    [self setMainView];
   
}

- (NSMutableArray *)data{
    if (!_data) {
        _data =@[].mutableCopy;
        for (NSDictionary*dic in titles) {
            RMNotifyDetailModel*model=[RMNotifyDetailModel modelWithDic:dic];
            [_data addObject:model];
        }
      
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
    [_tableView registerClass:[RMNotifyDetailTableViewCell class]   forCellReuseIdentifier:@"NotifyDetailCell" ];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      RMNotifyDetailModel*model=_data[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RMNotifyDetailTableViewCell *cell =  [RMNotifyDetailTableViewCell cellWithTableView:tableView];
    
    cell.model = _data[indexPath.row];

   
    return cell;
}

#pragma mark cell的点中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
