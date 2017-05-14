//
//  RMProcessApprovalViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/8.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMProcessApprovalViewController.h"
#import "RMHomeCollectionCell.h"
#import "RMHomeCellModel.h"
@interface RMProcessApprovalViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) UICollectionView *mainView;
@end

@implementation RMProcessApprovalViewController
- (NSArray *)data{
    if (!_data) {
        
        _data =   [RMProcessApprovalModel  approvalModelList].copy;
    }
    return _data;
}
- (void)addClick:(UIBarButtonItem *)sender{
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithOriginalName:@"tianjia"] style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
    
    self.navigationItem.rightBarButtonItem = editingButton;
    [self setMainView];
 
}
- (void)setMainView{
    ///搜索
    UIView *souBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
    souBgView.backgroundColor = [UIColor clearColor];
    souBgView.userInteractionEnabled  =YES;
    [self.view addSubview:souBgView];
    
    UIView *bgWhiteView = [[UIView alloc]initWithFrame:CGRectMake(15, 8, KScreenWidth-30, 30)];
    bgWhiteView.backgroundColor = COLOR(255, 255, 255, 0.3) ;
    bgWhiteView.userInteractionEnabled = YES;
    bgWhiteView.layer.cornerRadius = 5;
    bgWhiteView.layer.masksToBounds = YES;
    [souBgView addSubview:bgWhiteView];
    
    UIImageView *souImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 15, 15)];
    souImageV.image = [UIImage imageNamed:@"search-icon"];
    [bgWhiteView addSubview:souImageV];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(souImageV.frame)+5,0 ,KScreenWidth-60 , 30)];
    textF.delegate  =self;
    [bgWhiteView addSubview:textF];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 130);
    layout.sectionInset = UIEdgeInsetsMake(0,20, 0, 20);
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, KScreenWidth, KScreenHeight-64-45) collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
 
    mainView.backgroundColor = [UIColor blackColor];
    [mainView registerNib:[UINib nibWithNibName:@"RMHomeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionCell"];
    [self.view addSubview:mainView];
}

//点击除了文本框以外的任何地方，退出键盘（编辑）
- (void)tapClickView:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat  itemWidth =floor( (_mainView.bounds.size.width-40-20)/3);
     return CGSizeMake(itemWidth, itemWidth+20);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RMHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    if (_data.count>0) {
        cell.data = _data[indexPath.item];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RMProcessApprovalModel *model = _data[indexPath.item];
    if (model&&model.destinationControllerClassName){
        
        Class class = NSClassFromString(model.destinationControllerClassName);
        //创建控制器再显示
        id vc = [[class alloc] init];
        //设置下一个控制器的标题
        [vc setTitle:model.title];
        @try {
            [vc setValuesForKeysWithDictionary:model.param];
        } @catch (NSException *exception) {
            NSLog(@"%@键值映射出错",self.class);
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClickView:)];
    view.tag = 100;
        [view addGestureRecognizer:tap];
    [self .view addSubview:view];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
     [self.view endEditing:YES];
    [[self.view  viewWithTag:100]  removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
