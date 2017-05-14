//
//  RMSignInViewController.m
//  RecoverManagement
//
//  Created by sandyrilla on 2016/11/2.
//  Copyright © 2016年 回收哥. All rights reserved.
//
#import "RMPhotoViewController.h"
#import "RMSignInViewController.h"
#import "RMStateBar.h"
#import "RMSignBtn.h"
#define rowH 80
@interface RMSignInViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView ;
 @property (nonatomic, strong)   BMKMapView* mapView;
 @property (nonatomic, strong)   BMKLocationService*locService;

@end

@implementation RMSignInViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
- (void)initUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KScreenHeight -64-(rowH*3), KScreenWidth, rowH*3) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    RMStateBar *citybar = [[RMStateBar alloc ]initWithFrame:CGRectMake(0, CGRectGetMinY(_tableView.frame)-44, KScreenWidth, 44)];
    [citybar setButtonImageWithNormal:nil selectedImages:nil title:@[@"武汉",@"天津",@"深圳",@"荆门"]  target:YES];
  [self.view addSubview:citybar];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, CGRectGetMinY(citybar.frame))];
    _mapView.mapType = BMKMapTypeStandard;
  
    _mapView.zoomLevel = 21;  //在手机上当前可使用的级别为3-21级
  
    _mapView.rotateEnabled = NO;  //设定地图View能否支持旋转
  
   _mapView.scrollEnabled = NO;  //设定地图View能否支持用户移动地图
    
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    //添加到view上
    
    [self.view addSubview:self.mapView];    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    UIView *dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    dateView.backgroundColor =COLOR(0, 0, 0, 0.5);
      [self.view addSubview:dateView];
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  "];
    NSString *today =  [dateFormatter stringFromDate:[NSDate date]];
    [button setTitle:[NSString stringWithFormat:@" %@(%@)",today,[self  weekDayStr]] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithOriginalName:@"riqi"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.center= dateView.center;
    button.userInteractionEnabled = NO;
     [self.view addSubview:button];
}

- (NSString*)weekDayStr
{
    NSString *weekDayStr = nil;

    NSDateComponents *weekdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate  date]];
    NSInteger week = [weekdayComponents weekday];
 
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";  
            break;  
    }  
    return weekDayStr;  
}

#pragma mark - 组的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark 组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //组数据
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MapCell"];
    cell.imageView.image = [UIImage imageNamed:@"dingweiblue"];
    cell.textLabel.text = @"金融港";
     cell.detailTextLabel.text = @"武汉市江夏区光谷大道金融港A3栋";
    return cell;
}

#pragma mark cell的点中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   }


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return rowH;
}
#pragma mark 头部标题
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

#pragma mark 尾部标题
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{    return 44.f;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bar = [[UIView alloc ]initWithFrame:CGRectMake(0,0, KScreenWidth, rowH)];
    UIImageView  *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0,rowH*0.25-5, KScreenWidth, rowH*0.75+5)];
    imageV.image = [UIImage imageNamed:@"bg"];
    [bar addSubview:imageV];
    RMSignBtn *btn = [[RMSignBtn alloc ]initWithFrame:CGRectMake(0, 0, 50, 55)];
 
    btn.center  = CGPointMake(imageV.center.x, imageV.height *0.5);
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithOriginalName:@"qiandaoicon"] forState:UIControlStateNormal];
  
    [btn   addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:btn];

    return bar;
}
#pragma mark 签到
- (void)buttonClick:(UIButton *)button
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self pushPickerControllerSourceType:UIImagePickerControllerSourceTypeCamera];
    }

}
- (void)pushPickerControllerSourceType:(NSUInteger)sourceType{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    //    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}
#pragma mark -  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
     [picker dismissViewControllerAnimated:YES completion:^{
    self.modalPresentationStyle=UIModalPresentationPageSheet;
    RMPhotoViewController *imageVC = [[RMPhotoViewController alloc]init];
    imageVC.backgroundImage =compressedImage;
    [self presentViewController:imageVC animated:YES completion:NULL];
     }];
}

#pragma mark --地图
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
 _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
    self.mapView.zoomLevel =18;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

@end
