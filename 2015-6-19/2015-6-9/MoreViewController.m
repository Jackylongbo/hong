//
//  MoreViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MoreViewController.h"
#import "DDSAppDelegate.h"
#import "BusinessIntrodutionViewController.h"
#import "EnvironDisplayViewController.h"
#import "FirstViewController.h"
#import "MyTabBarViewController.h"

@interface MoreViewController ()
{
    NSMutableArray *titleArray;//tableview标题分组,下面将一个tableview分成3个组
    NSMutableArray *dataArray1;
    NSMutableArray *dataArray2;
    NSMutableArray *dataArray3;
    CGSize m_size;
    
    UIScrollView *m_scrollView;
    UIPageControl *pageCtrl;
}
@end

@implementation MoreViewController
@synthesize  more_tableview;
@synthesize imageArray;//店面图片介绍
@synthesize titleArr;//图片标题

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
    m_size=self.view.bounds.size;
    
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
    UIImage *backgroundImage=[UIImage imageNamed:@"bg.jpg"];
    UIColor *backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
    [self.navigationItem setTitle:@"更多内容"];
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backToView)];
    self.navigationItem.leftBarButtonItem=leftBarItem;
    more_tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    more_tableview.delegate=self;
    more_tableview.dataSource=self;
    more_tableview.sectionFooterHeight=2.0f;
   //从文件中读取图片信息和标题信息
    NSString *path=[[NSBundle mainBundle] pathForResource:@"environmentDisplay" ofType:@"plist"];
    NSDictionary *ditionary=[NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* image=[ditionary objectForKey:@"image"];
   // NSLog(@"%@",image);
    imageArray =[[NSMutableArray alloc] init];
    for (NSMutableString *str in image)
    {
       NSMutableString*string= [NSMutableString stringWithFormat:@"%@.jpg",str];
       [imageArray addObject:string];
       // NSLog(@"%@",str);
    }
    //NSLog(@"%@",imageArray);
    dataArray1 =[[NSMutableArray alloc] initWithArray: [ditionary objectForKey:@"data1"]];
    dataArray2=[[NSMutableArray alloc] initWithArray:[ditionary objectForKey:@"data2"]];
    dataArray3=[[NSMutableArray alloc] initWithArray: [ditionary objectForKey:@"data3"]];
    titleArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    [self.view addSubview:more_tableview];
}
//
-(void)backToView
{
    //[self.view addSubview:more_tableview];
    MyTabBarViewController *tabBarView=[MyTabBarViewController new];
    self.view.window.rootViewController=tabBarView;
    //[self.navigationController pushViewController:firstView animated:YES];
}

#pragma mark - tableView 代理方法实现
//指定每个分区中有多少行，默认为1
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return  [dataArray1 count];//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            break;
        case 1:
            return  [dataArray2 count];
            break;
        case 2:
            return [dataArray3 count];
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"moreCellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor=[UIColor orangeColor];
    switch (indexPath.section) {
        case 0:
            [[cell textLabel] setText:[dataArray1 objectAtIndex:indexPath.row]];
            break;
        case 1:
            [[cell textLabel] setText:[dataArray2 objectAtIndex:indexPath.row]];
            break;
        case 2:
            [[cell textLabel] setText:[dataArray3 objectAtIndex:indexPath.row]];
            if (indexPath.row==0) {
//                NSLog(@"推送.........");
                UISwitch *swith=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, 5, 40, 25)];
                cell.accessoryType=UITableViewCellAccessoryNone;
                [cell addSubview:swith];
            }
            break;
        default:
            [[cell textLabel] setText:@"Unknown"];
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/14;
}
//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
    
}

//每个section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
            break;
        case 1:
            
            return [titleArray objectAtIndex:section];//提取标题数组的元素用来显示标题
            break;
        case 2:
            return [titleArray objectAtIndex:section];
        default:
            return @"Unknown";
            break;
    }
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 8.0 ;
}
//选中每一行的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先判断是在哪个分组，然后判断是哪一行
    switch (indexPath.section) {
        case 0:
            //NSLog(@"第一组");
            switch (indexPath.row) {
                case 0:
                    NSLog(@"业务介绍");
                    [self BusinessIntrodution];
                    if (self.navigationItem.title!=nil||[self.navigationController.title isEqualToString:@"更多内容"]) {
                        //self.navigationItem.title=@"";
                        [self.navigationItem setTitle:@"业务介绍"];
                    }
                    break;
                case 1:
                    NSLog(@"典当流程");
                    [self PawnProcess];
                    break;
                case 2:
                    NSLog(@"优惠活动");
                    [self Preferentialactivity];
                    break;
                case 3:
                    NSLog(@"环境展示");
                    [self Environmentaldisplay];
                    break;
                case 4:
                    NSLog(@"关于我们");
                    
                    [self AboutUs];
                    break;
                case 5:
                    NSLog(@"地址导航");
                    [self Addressnavigation];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"短信分享给好友");
                    
                    break;
                case 1:
                    NSLog(@"分享到新浪微博");
                    break;
                case 2:
                    NSLog(@"分享到腾讯微博");
                    break;
                default:
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"推送设置");
                    break;
                case 1:
                    NSLog(@"关于应用");
                    break;
                case 2:
                {
                    NSLog(@"退出应用");
                    DDSAppDelegate *exit=[DDSAppDelegate new];
                    [exit exitApplication];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }

}


#pragma mark - 业务介绍
-(void)BusinessIntrodution
{
    //[more_tableview removeFromSuperview];
    BusinessIntrodutionViewController *business=[BusinessIntrodutionViewController new];
    [self.navigationController pushViewController:business animated:YES];
    //网络请求 进入官网首页
}
#pragma mark - 典当流程
-(void)PawnProcess
{
    [self.navigationItem setTitle:[dataArray1 objectAtIndex:1]];
}
#pragma mark - 优惠活动
-(void)Preferentialactivity
{
    [self.navigationItem setTitle:[dataArray1 objectAtIndex:2]];

}
#pragma mark - 环境展示
-(void)Environmentaldisplay
{
    [self.navigationItem setTitle:[dataArray1 objectAtIndex:3]];
    EnvironDisplayViewController *environDisplay=[EnvironDisplayViewController new];
    [self.navigationController pushViewController:environDisplay animated:YES];
    
    
    //几张图片展示
//    m_scrollView=[self create_scrollView];
//    pageCtrl=[self create_pageControl];
//    [self.navigationController setTitle:@"环境展示"];
//    [more_tableview removeFromSuperview];
//    [self.view addSubview:m_scrollView];
//    [self.view addSubview:pageCtrl];
    
}
-(UIScrollView*)create_scrollView
{
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height)];
    scrollview.backgroundColor=[UIColor blackColor];
    //
    scrollview.contentSize=CGSizeMake(m_size.width*[imageArray count], 0);
    scrollview.pagingEnabled=YES;//过屏幕一半自动跳转
    scrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动指示符
    scrollview.delegate=self;//滑动完毕一个width以后需要pageControl跟进，所以需要实现这个方法(scrollViewDidScroll)
    
    for (int i=0; i<[imageArray count]; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(m_size.width*i, 0, m_size.width, m_size.height)];
        NSString *imageName=[imageArray objectAtIndex:i];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.clipsToBounds=YES;
        
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.image=[UIImage imageNamed:imageName];
        [scrollview addSubview:imageView];
    }
    
    return scrollview;
}
-(UIPageControl*)create_pageControl
{
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(85, m_size.height*0.90, 150, 30)];
    pageControl.numberOfPages=[imageArray count];
    
    UIImage *checkedPointImage=[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:checkedPointImage];
    
    UIImage *pointImage=[UIImage imageNamed:@"new_feature_pagecontrol_point.png"];
    pageControl.pageIndicatorTintColor=[UIColor colorWithPatternImage:pointImage];
    
    return pageControl;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    more_tableview.contentSize=CGSizeMake(0, self.view.bounds.size.height+60);
    pageCtrl.currentPage=scrollView.contentOffset.x/m_size.width;
}
#pragma mark -关于我们
-(void)AboutUs
{
    [self.navigationItem setTitle:[dataArray1 objectAtIndex:4]];
}
#pragma mark - 地址导航
-(void)Addressnavigation
{
    [self.navigationItem setTitle:[dataArray1 objectAtIndex:5]];
}
/*==========================================================*/
//短信分享给好友

//分享到新浪微博

//分享到腾讯微博

/*==========================================================*/
//推送设置

//关于应用

//退出应用

/*==========================================================*/
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//
//{
//    
//    // Return YES for supported orientations
//    
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//刷新页面的数据
- (void)viewDidAppear:(BOOL)animated{
    
    if ([self isBeingDismissed]) {
        return;
    }
    [self viewDidLoad];
    
}
@end
