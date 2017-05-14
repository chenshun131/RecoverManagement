//
//  AddressListViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "AddressListViewController.h"
#import "RMAddressListTableViewCell.h"
#import "RMContactInformationViewController.h"
#import "RMDailyHistoryViewController.h"

@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,BMPopViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UITableView *mainTableView;
    
    NSDictionary *dataDic;
    NSMutableArray *_dataSource;//索引数组
    
    UIView *departmentToFindView;
    
    BOOL bKeyBoardHide;//判断键盘状态
    
    NSMutableArray *dataArr;
}

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLB.text = @"通讯录";
    if ([_stateStr isEqualToString:@"xuanze"]) {
        [self addRightBtnWithTitle:@"确定" WithImageName:@""];
        [self addLeftView:@""];
    }
    
    bKeyBoardHide = 1;
    
    dataDic = @{@"A" : @[@"安茜",@"安道尔",@"安妮",@"阿奴"],
                @"B":@[@"白百何",@"版本儿",@"报表"],
                @"C":@[@"长江",@"吃吃"],
                @"D":@[@"大宝",@"大大"],
                @"F":@[@"方正"],
                @"G":@[@"哥哥",@"哥特"],
                @"H":@[@"何华",@"何姿"],
                @"J":@[@"杰克"],
                @"K":@[@"空空",@"孔方兄"],
                @"L":@[@"刘留",@"李丽"],
                @"M":@[@"美人",@"米饭",@"面团"],
                @"N":@[@"宁远"],
                @"P":@[@"胖子",@"裴三"],
                @"Q":@[@"齐七"],
                @"R":@[@"人民币",@"软妹子",@"阮思平"],
                @"S":@[@"邵市",@"煞星"],
                @"T":@[@"兔兔",@"团团"],
                @"W":@[@"万五",@"王源"],
                @"X":@[@"许栩",@"消防员"],
                @"Y":@[@"院墙",@"芋头"],
                @"Z":@[@"张洒",@"章鱼",@"张翰"],
                
                };
    
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    
    dataArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<keyArr.count; i++) {
        RMSelectModel *model = [[RMSelectModel alloc]init];
        [dataArr addObject:model];
        model.dataArr = [NSMutableArray array];
        NSArray *arr = [dataDic valueForKey:keyArr[i]];
        for (int j = 0; j<arr.count; j++) {
            RMSelectModel *model1 = [[RMSelectModel alloc]init];
            
            [model.dataArr addObject:model1];
            
            
        }
        
    }
    //索引数组
    _dataSource = [[NSMutableArray alloc] init] ;
    //初始化数据
    for(char c = 'A'; c <= 'Z'; c++ )
    {
        [_dataSource addObject:[NSString stringWithFormat:@"%c",c]];
           }
    
    [self setMainView];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickView:)];
    tap.delegate =self;
    [self.view addGestureRecognizer:tap];
}

- (void)leftBtnClick:(UIButton *)sender{
    if ([_stateStr isEqualToString:@"xuanze"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    
    if ([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"])
    {
        if (bKeyBoardHide == 1) {
            return NO;
            
        }else{
            [self.view endEditing:YES];
        }
       
    }
    return  YES;
}

//直接在textview的状态里判断 记得写textview的委托<br>
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    bKeyBoardHide = NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    bKeyBoardHide = YES;
}

//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer
{
    [mainTableView endEditing:YES];
    for (UIView *child in self.view.subviews) {
        
        // 如果是文本输入框
        if (![child isKindOfClass:[UITextField class]])
            [child endEditing:YES];
        
    }
}

- (void)rightClick:(UIButton *)btn{
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *selectNameArray = [NSMutableArray arrayWithCapacity:0];
    for (RMSelectModel *model in dataArr) {
        
        NSInteger index = [dataArr indexOfObject:model];
        
        for (RMSelectModel *model1 in model.dataArr) {
            
            NSInteger index1 = [model.dataArr indexOfObject:model1];
            
            if (model1.isSelect == YES) {
                [selectNameArray addObject:[[dataDic valueForKey:keyArr[index]] objectAtIndex:index1]];
            }
        }
    }
    
  //  NSArray *nameArr = [dataDic valueForKey:keyArr[indexPath.section]];
    if (selectNameArray.count == 0) {
        [MBProgressHUD showError:@"您还没有选择审批人"];
    }else{
        NSDictionary *dictio=[[NSDictionary alloc]initWithObjectsAndKeys:selectNameArray,@"NameArr", nil];
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhini" object:nil userInfo:dictio];
        
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];

        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -- 按部门查找
- (void)setDepartmentToFindView{
    [self.view endEditing:YES];
    
    departmentToFindView = [[UIView   alloc]   initWithFrame:CGRectMake(0, 0, KScreenWidth, 180)];
    departmentToFindView.backgroundColor = [UIColor  whiteColor];
    
    [BMPopView   shareInstance].canDisMiss = YES;
    [BMPopView   shareInstance].customFrame = YES;
    [BMPopView shareInstance].panduanString = @"addressList";
    
    NSArray *departmentArr = @[@"研发部",@"基建部",@"人事部"];
    NSArray *numArr = @[@"26",@"26",@"6"];
    NSArray *imageArr = @[@"tongxunzulan",@"lianxizuqianlan",@"lianxizulv"];
    for (int i = 0; i < departmentArr.count; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 50*i, KScreenWidth, 50)];
        bgView.userInteractionEnabled = YES;
        [departmentToFindView addSubview:bgView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 7, 35, 35)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [bgView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+15, 17, 120, 15)];
        titleLabel.text = departmentArr[i];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [titleLabel sizeToFit];
        [bgView addSubview:titleLabel];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+15, 17, KScreenWidth-CGRectGetMaxX(titleLabel.frame)-30, 15)];
        numLabel.text = numArr[i];
        numLabel.textColor = LMColor(232, 80, 0);
        numLabel.textAlignment = NSTextAlignmentRight;
        numLabel.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:numLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, KScreenWidth, 1)];
        line.backgroundColor = LMColor(240, 240, 240);
        [bgView addSubview:line];
        
        UIButton *departmentBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 50)];
        [departmentBtn addTarget:self action:@selector(departmentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        departmentBtn.tag = 300+i;
        [bgView addSubview:departmentBtn];
    }
    
    UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 150, KScreenWidth, 30)];
    topBtn.imageEdgeInsets = UIEdgeInsetsMake(9, (KScreenWidth-15)/2, 9, (KScreenWidth-15)/2);
    [topBtn setImage:[UIImage imageNamed:@"disclosure-arrow-zhankai"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [departmentToFindView addSubview:topBtn];
    
    [[BMPopView   shareInstance]   showWithContentView:departmentToFindView delegate:self];
   
}

//按部门查找
- (void)departmentBtnClick:(UIButton *)sender{
    [[BMPopView   shareInstance] dismiss];
}

//将按部门查找的View收回去
- (void)topBtnClick:(UIButton *)sender{
    [[BMPopView   shareInstance] dismiss];
}

- (void)setMainView{
    ///搜索
    UIView *souBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 45)];
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
    textF.placeholder = @"姓名/职称/部门";
    textF.font = [UIFont systemFontOfSize:15];
    [textF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgWhiteView addSubview:textF];
    
    
    
    //按部门查找
    UIView *searchBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(souBgView.frame), KScreenWidth, 30)];
    searchBgView.backgroundColor = [UIColor whiteColor];
    
    searchBgView.userInteractionEnabled = YES;
    [self.view addSubview:searchBgView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
    titleLabel.text = @"按部门查找";
    titleLabel.textColor = LMColor(236, 120, 77);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [searchBgView addSubview:titleLabel];
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-10-15, 14, 15, 9)];
    [bottomBtn setImage:[UIImage imageNamed:@"disclosure-arrowxiala"] forState:UIControlStateNormal];
    [searchBgView addSubview:bottomBtn];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBgView addSubview:searchBtn];
    
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45+30, KScreenWidth, KScreenHeight-64-45-30-49) style:UITableViewStyleGrouped];
    if ([_stateStr isEqualToString:@"xuanze"]) {
        mainTableView.frame = CGRectMake(0, 64+45+30, KScreenWidth, KScreenHeight-64-45-30);
    }
    mainTableView.delegate =self;
    mainTableView.dataSource = self;
    mainTableView.separatorColor = LMColor(235, 235, 235);
    mainTableView.backgroundColor  = LMColor(249, 249, 249);
    //改变索引的颜色
    mainTableView.sectionIndexColor = [UIColor blackColor];
    [self.view addSubview:mainTableView];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[BMPopView   shareInstance] dismiss];
    return YES;
}

-(void)textFieldDidChange :(UITextField *)theTextField{


}

-(void)searchBtnClick:(UIButton *)sender{
    [self setDepartmentToFindView];
}

#pragma mark -- tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSArray *arr = [dataDic valueForKey:keyArr[section]];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 15)];
    
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
 
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 15)];
    if ([_stateStr isEqualToString:@"xuanze"]) {
        label.frame = CGRectMake(45, 0, 100, 15);
    }
    label.text = keyArr[section];
    label.textAlignment  =NSTextAlignmentLeft;
    label.textColor = LMColor(236, 120, 77);
    label.font = [UIFont systemFontOfSize:14];
    [head addSubview:label];
    
    return head;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName = @"idenifier";
    RMAddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell = [[RMAddressListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor  =[UIColor whiteColor];
    
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSArray *nameArr = [dataDic valueForKey:keyArr[indexPath.section]];

    RMSelectModel *model = dataArr[indexPath.section];
    RMSelectModel *model1 = model.dataArr[indexPath.row];
    
    [cell initWithName:nameArr[indexPath.row] andDepartment:@"人事部" andJob:@"人事助理" andState:self.stateStr andImageUrl:@"" andChooseState:model1.isSelect];
    
    cell.selectBtn.tag = 1000*(indexPath.section+1)+indexPath.row;
    cell.cellSelectButton.tag = 100*(indexPath.section+1)+indexPath.row;
    [cell.cellSelectButton addTarget:self action:@selector(cellSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];

  
    return cell;


}

- (void)cellSelectButtonClick:(UIButton *)sender{
    UIButton *btn = sender;
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:(sender.tag - sender.tag%100)*10+sender.tag%100];
    
    btn.selected = !btn.selected;
    btn2.selected = !btn2.selected;
    
    
    if (btn.tag == sender.tag) {
        RMSelectModel *model =  dataArr[sender.tag/100-1];
        
        RMSelectModel *model1 = model.dataArr[sender.tag%100];
        model1.isSelect = btn2.selected;
      
    }
    
    [mainTableView reloadData];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RMContactInformationViewController *vc = [[RMContactInformationViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -- 设置索引
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _dataSource;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    
    NSArray *keyArr = [[dataDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];

    for(NSString *character in keyArr)
    {
        if([character isEqualToString:title])
        {
            return count;
            
        }
        count ++;
        
    }
   
    return count;
}

#pragma mark -  tableview分割线与tableview等宽
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(void)viewDidLayoutSubviews{
    
    if ([mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}

@end
