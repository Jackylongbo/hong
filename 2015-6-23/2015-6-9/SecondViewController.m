//
//  SecondViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "SecondViewController.h"
#import "MyButton.h"
#import "MyCollectionViewCell.h"
#import "DDCollectionViewFlowLayout.h"
#import "FirstViewController.h"
#import "ValuatingViewController.h"
#import "mapViewController.h"
#import "MyTableViewCell.h"
#import "BidDetailMessageViewController.h"

@interface SecondViewController()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *AllBidTableView;//全部标
    UITableView *TransferBidTableView;//转让标的
    UIActivityIndicatorView *indicator;//活动指示器

}
@end

@implementation SecondViewController
{
    CGSize m_size;
    UISegmentedControl *segmentControl;

    UIButton *submit_btn;//提交按钮
    NSInteger viewTag;//用来获取当前页面的控件tag
}

@synthesize picker;
@synthesize filePath;
@synthesize timer;
@synthesize dataDictionary;
@synthesize dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[self navigationController]navigationBar].
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.view.userInteractionEnabled = YES;
    
    
    /*
     初始化字典里地数据
     Bname.text = @"Bname";
     profictRate.text = @"12.3%";
     Baddress.text = @"上海浦东";
     InvestAccount.text = @"1000000";
     InvestPeriod.text = @"3个月";
     LowestStart.text = @"50元起购";
     */
    dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      @"典金所",@"Bname",
                      @"13.2%",@"profictRate",
                      @"上海闵行",@"Baddress",
                      @"200000",@"InvestAccount",
                      @"2个月",@"InvestPeriod",
                      @"50元起购",@"LowestStart",
                      nil];
    dataArray = [[NSMutableArray alloc] init];
    for (int i =0; i<10; i++) {
        [dataArray addObject:dataDictionary];
    }
    
    m_size = self.view.bounds.size;
    NSArray *array=@[@"全部标的",@"转让标的"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
   // segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, 64, self.view.bounds.size.width, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置文字景色
    segmentControl.tintColor=[UIColor lightGrayColor];
    //设置背景颜色
    //segmentControl.backgroundColor=[UIColor clearColor];
    
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
   
    AllBidTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentControl.bounds.size.height+64, m_size.width, m_size.height-segmentControl.bounds.size.height-80)];
    AllBidTableView.backgroundColor = [UIColor grayColor];
    AllBidTableView.delegate = self;
    AllBidTableView.dataSource = self;
    AllBidTableView.userInteractionEnabled = YES;
    //AllBidTableView.allowsSelection = YES;
    
    
    //活动指示器
    indicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    AllBidTableView.tableFooterView=indicator;
    [indicator startAnimating];
    [self.view addSubview:AllBidTableView];
}

#pragma mark -tableView delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"second";
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled =YES;
    [cell loadCellData:dataDictionary];///////加载数据到tableview cell
    
    //cell.backgroundColor = [UIColor redColor];
    //NSLog(@"tableview");
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [dataArray count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    self.navigationController.navigationItem.title = @"标-详细信息";
    BidDetailMessageViewController *bidMessageView = [BidDetailMessageViewController new];
    UINavigationController *navigationCtrl = [[UINavigationController alloc] initWithRootViewController:bidMessageView];
    [bidMessageView GetDataFrom:[dataArray objectAtIndex:indexPath.row]];
    [self presentModalViewController:navigationCtrl animated:YES];
}

#pragma mark -getMoreData:
-(void)getMoreData:(int)page
{
    [self insertToBottom];
}

-(void)insertToBottom
{
    for (int j=0; j<10; j++) {
        [dataArray addObject:dataDictionary];
    }
    
    
    [self updateTableview];
}
-(void)updateTableview
{
    [AllBidTableView reloadData];

}

//上拉加载更多
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y>=fmaxf(.0f, scrollView.contentSize.height - scrollView.frame.size.height)+20)
    {
        [indicator startAnimating];
        [self getMoreData:0];
    }
    [indicator stopAnimating];
}

#pragma mark -键盘隐藏事件

//
-(void)dismissKeyboard
{
    [self.view endEditing:YES];

}

//最上面的segmentedcontrol视图
-(void)change:(UISegmentedControl *)segmentcontrol{
   // NSLog(@"segmentControl %ld",segmentcontrol.selectedSegmentIndex);
    if (segmentcontrol.selectedSegmentIndex==0) {
        //全部标的
        
    }
    else if (segmentControl.selectedSegmentIndex==1) {
        
        //转让标的
        /*================网络请求===================*/
        
        
    }
}


//选择照片事件
-(void)choose_photo:(UIButton*)sender
{
//    UIActionSheet *chose_sheet=[[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册图片上传" otherButtonTitles:@"拍照上传", nil];
//    viewTag=sender.tag;
}

#pragma mark -actionSheet protocol method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"1,相册图片上传");
       if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
       {
           picker=[[UIImagePickerController alloc] init];
           picker.delegate = self;
           //picker.allowsImageEditing = YES;
           picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSLog(@"111,相册图片上传");
           [self presentViewController:picker animated:YES completion:nil];
           
       }
        
    }else if (buttonIndex == 1) {
        NSLog(@"2,拍照上传");
    }else if(buttonIndex == 2) {
        NSLog(@"3,取消");
    }
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
#pragma mark -UIImagePickerController
// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - 相册文件选取相关
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark - 拍照按钮事件

//图片路径选择
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"图片路径");
    static int i=0;
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image)==nil) {
            data=UIImageJPEGRepresentation(image,1.0);
        }
        else{
            data=UIImagePNGRepresentation(image);
        }
        //图片保存的路径,将图片放在沙盒的documents 文件夹中
        NSString*doucmentsPath=[NSHomeDirectory() stringByAppendingString:@"/Documents"];
        NSFileManager *filemanager=[NSFileManager defaultManager];
        [filemanager createDirectoryAtPath:doucmentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [filemanager createFileAtPath:[doucmentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        filePath=[[NSString alloc] initWithFormat:@"%@/self%d_%@",doucmentsPath,i++ ,@"image.png"];
        [self dismissViewControllerAnimated:YES completion:nil];
        //选中图片后直接将图片的路径放入textfield
        [self sendDirectToTextField:viewTag path:filePath];
   
    }
    
}
//将图片的路径送给textField的text
-(void)sendDirectToTextField:(NSInteger)tag path:(NSString*)filepath
{
    if (31==tag) {
       
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(32==tag)
    {
        
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(33==tag)
    {
        
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(34==tag)
    {
        
        NSLog(@"%@",filepath);
        filepath=nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self viewDidLoad];
    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//
//    self.navigationController.tabBarItem.badgeValue=@"new";
//}
#pragma mark -keyboard return
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end