//
//  PersonerViewController.m
//  RecoverManagement
//
//  Created by 何姝雯 on 2016/10/24.
//  Copyright © 2016年 回收哥. All rights reserved.
//

#import "PersonerViewController.h"
#import "RMPersonerTableViewCell.h"
#import "RMChangeViewController.h"
#import "LoginViewController.h"
#import "RMShapedImageView.h"

@interface PersonerViewController ()<UITableViewDelegate,UITableViewDataSource,BMPopViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *headerView;
    UITableView *mainTableView;
    
    UIImageView *touxiangImageV;
}

@end

@implementation PersonerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.view.backgroundColor = LMColor(143, 161, 161);
    
    [self setHeaderView];
    [self setMainView];
}

- (void)setHeaderView{
    headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 210)];
    headerView.image = [UIImage imageNamed:@"bg2"];
    headerView.userInteractionEnabled = YES;
    [self.view addSubview:headerView];
    
    //标题
    UILabel *titleLB=[[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth-180)/2, 25, 180, 34)];
    titleLB.text = @"个人中心";
    titleLB.textColor = [UIColor whiteColor];
    titleLB.font=[UIFont boldSystemFontOfSize:18];
    titleLB.textAlignment=NSTextAlignmentCenter;
    [headerView addSubview:titleLB];

    UIImageView *touxiangKuangImageV = [[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-70)/2, CGRectGetMaxY(titleLB.frame)+15, 70, 70)];
    touxiangKuangImageV.image = [UIImage imageNamed:@"yuan-bt"];
    
    [headerView addSubview:touxiangKuangImageV];
    
    touxiangImageV = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 66, 66)];
    touxiangImageV.image = [UIImage imageNamed:@"touxiang"];
    touxiangImageV.layer.cornerRadius = 32;
    touxiangImageV.layer.masksToBounds = YES;
    [touxiangKuangImageV addSubview:touxiangImageV];
    
    UIImageView *bianjiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(touxiangKuangImageV.frame)-9, touxiangKuangImageV.frame.origin.y+42, 15, 15)];
    bianjiImageView.image = [UIImage imageNamed:@"bianji"];
    [headerView addSubview:bianjiImageView];
    
    UIButton *touxiangBtn = [[UIButton alloc]initWithFrame:CGRectMake(touxiangKuangImageV.frame.origin.x, touxiangKuangImageV.frame.origin.y, 75, 70)];
    [touxiangBtn addTarget:self action:@selector(touxiangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:touxiangBtn];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(touxiangKuangImageV.frame)+10, KScreenWidth-30, 20)];
    nameLabel.text = @"朱子乐";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont boldSystemFontOfSize:17];
    [headerView addSubview:nameLabel];
    
    UILabel *positionLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(nameLabel.frame)+5, KScreenWidth-30, 20)];
    positionLabel.text = @"Java开发经理（ERP事业部）";
    positionLabel.textColor = [UIColor whiteColor];
    positionLabel.textAlignment = NSTextAlignmentCenter;
    positionLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:positionLabel];
    
}

- (void)setMainView{
    mainTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), KScreenWidth, KScreenHeight-49-headerView.frame.size.height) style:UITableViewStyleGrouped];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.backgroundColor = RMColor(249, 249, 249);
    mainTableView.separatorColor =RMColor(240, 240, 240);
    [self.view addSubview:mainTableView];
}

- (void)touxiangBtnClick:(UIButton *)sender{
    [self setChangeTouXiangView];
}

#pragma mark -- 切换头像
- (void)setChangeTouXiangView{
    UIView *touxiangChangeView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight-150, KScreenWidth, 150)];
    touxiangChangeView.userInteractionEnabled =YES;
    
    [BMPopView   shareInstance].canDisMiss = YES;
    [BMPopView   shareInstance].customFrame = YES;
    
    for (int i = 0; i <3; i++) {
        NSArray *titleArr =@[@"拍照",@"相册",@"取消"];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 50*i, KScreenWidth, 50)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        if (i==2) {
            btn.backgroundColor = LMColor(105, 105, 105);
            
        }else{
            btn.backgroundColor = [UIColor blackColor];
        }
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [btn addTarget:self action:@selector(changeTouxiangBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 300+i;
        [touxiangChangeView addSubview:btn];
        
        
    }
    
    UIView *lineV= [[UIView alloc]initWithFrame:CGRectMake(0, 50, KScreenWidth, 1)];
    lineV.backgroundColor =[UIColor whiteColor];
    [touxiangChangeView addSubview:lineV];
    
    [[BMPopView   shareInstance]   showWithContentView:touxiangChangeView delegate:self];
    
    
}

- (void)changeTouxiangBtn:(UIButton *)btn{
    if (btn.tag == 300) {
        [[BMPopView shareInstance] dismiss];
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
     
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:^{
            
        }];
        
        
        
    }else if (btn.tag==301){
        [[BMPopView shareInstance] dismiss];
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
          
        }
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        [self presentViewController:pickerImage animated:YES completion:^{
            
        }];
        
    }else{
        [[BMPopView shareInstance] dismiss];
    }
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        //图片2进制路径
     //   NSString* filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        touxiangImageV.image = image;
        
    }
    
}


#pragma mark -- tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        RMPersonerTableViewCell *cell = (RMPersonerTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;

    }else{
        return 50;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellName = @"idenifier";
        RMPersonerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if(cell == nil)
        {
            cell = [[RMPersonerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor  =[UIColor whiteColor];
        
        NSArray *titleArr = @[@"入职",@"电话",@"邮箱",@"住址"];
        NSArray *imageArr = @[@"zhiwenicon",@"dianhuaiconlan",@"youxiangiconlan",@"dizhiiconlan"];
        
        NSArray *arr = @[@"2016-08-01",@"18686868888",@"zhangs@hsg.com.cn",@"湖北省武汉市江夏区藏龙岛光谷大道金融港A3栋14楼"];
      
        [cell initWithIndex:indexPath.row andImageName:imageArr[indexPath.row] andData:arr[indexPath.row] andTitle:titleArr[indexPath.row] andCanEdit:YES];
        return cell;

    }else{

        static NSString *cellName2 = @"idenifier2";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellName2];
        if(cell2 == nil)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName2];
        }
        //解决复用
        [cell2.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor  =[UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, KScreenWidth-30, 50)];
        label.text = @"退出登录";
        label.textColor = RMColor(229, 0, 0);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        [cell2 addSubview:label];
        
        [UIFont systemFontSize];
        return cell2;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = @[@"入职",@"电话",@"邮箱",@"住址"];
    if (indexPath.section==0) {
        if (indexPath.row != 0) {
            RMChangeViewController *vc = [[RMChangeViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.titleStr = arr[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        NSLog(@"退出登录。。。。。");
        LoginViewController *vc =[[LoginViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
