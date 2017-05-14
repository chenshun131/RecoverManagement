//
//  RMHomeViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "RMHomeViewController.h"
#import "RMDragCellCollectionView.h"
#import "RMHomeCollectionCell.h"
#import "RMHomeCellModel.h"

@interface RMHomeViewController ()<RMDragCellCollectionViewDataSource, RMDragCellCollectionViewDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) RMDragCellCollectionView *mainView;
@property (nonatomic, weak) UIPinchGestureRecognizer *pinchRecognizer ;
@property (nonatomic, assign) UIBarButtonItem *editButton;

@end

@implementation RMHomeViewController
{
    CGFloat  lastScale;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回收哥企业管理平台";
    lastScale=1.0;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(0,20, 0, 20);
   RMDragCellCollectionView *mainView = [[RMDragCellCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-36) collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.shakeLevel = 3.0f;
    mainView.minimumPressDuration = 2.5;
    mainView.backgroundColor = [UIColor blackColor];
    [mainView registerNib:[UINib nibWithNibName:@"RMHomeCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionCell"];
    [self.view addSubview:mainView];
    UIBarButtonItem *editingButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rm_edting:)];
    _editButton = editingButton;
    self.navigationItem.rightBarButtonItem = editingButton;
}

- (NSArray *)data{
    if (!_data) {
       
                _data =   [RMHomeCellModel  homeModelList].copy;
    }
    return _data;
}

- (void)rm_edting:(UIBarButtonItem *)sender{
    if (_mainView.isEditing) {
        [_mainView rm_stopEditingModel];
        sender.title = @"编辑";
    }else{
        [_mainView rm_enterEditingModel];
        sender.title = @"退出";
    }
}


#pragma mark - <XWDragCellCollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RMHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionCell" forIndexPath:indexPath];
    if (_data.count>0) {
         cell.data = _data[indexPath.item];
    }
    
    return cell;
}
- (NSArray *)dataSourceArrayOfCollectionView:(RMDragCellCollectionView *)collectionView{
    return _data;
}

#pragma mark - <XWDragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RMHomeCellModel *model = _data[indexPath.item];
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

- (void)dragCellCollectionView:(RMDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray;
}

- (void)dragCellCollectionView:(RMDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
    _editButton.enabled = NO;
}

- (void)dragCellCollectionViewCellEndMoving:(RMDragCellCollectionView *)collectionView{
    _editButton.enabled = YES;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    _pinchRecognizer.enabled = [_mainView  indexPathForItemAtPoint:point];
    
    return [_mainView hitTest:point withEvent:event];
}
- (void)doubleTapCellCollectionView:(RMDragCellCollectionView *)collectionView tapCellIndexPath:(NSIndexPath *)IndexPath{
       RMHomeCellModel *model =    _data[IndexPath.item];
    model.isBigger = !model.isBigger;
//            [_mainView reloadData];
    [UIView performWithoutAnimation:^{
        [_mainView  reloadItemsAtIndexPaths:@[IndexPath]];
    }];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    RMHomeCellModel *model =    _data[indexPath.item];
    CGFloat  itemWidth =floor( (_mainView.bounds.size.width-40-20)/3);
      if (   model.isBigger == YES) {
        return CGSizeMake(round(itemWidth*2+10), itemWidth);
    }
    return CGSizeMake(itemWidth, itemWidth);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
