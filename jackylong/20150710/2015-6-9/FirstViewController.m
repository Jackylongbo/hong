//
//  FirstViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "GetCheapViewController.h"
#import "MyTableViewCell.h"
#import "loginOrRegisterViewController.h"

@interface FirstViewController ()
{
    CGSize m_size;//获取当前页面的size
}
@end

@implementation FirstViewController
@synthesize HorizonScrollView;//用来轮播图片用的
@synthesize VerticalScrollView;
@synthesize tableview;
@synthesize imageArrary;
@synthesize pageControl;

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
    
    m_size = self.view.frame.size;
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(runScrollView) userInfo:nil repeats:YES];
    //
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.view.userInteractionEnabled = YES;
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //
    [self.navigationItem setTitle:@"典金所"];
    //从本地读取用户信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *username = [user objectForKey:@"userName"];
    NSString *userpass = [user objectForKey:@"userPass"];
    if (username==NULL||userpass==NULL) {
        //初始化导航栏右侧
        UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"登录/注册" style:UIBarButtonItemStylePlain target:self action:@selector(JumpToLogin)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }else
    {
        NSLog(@"您的账号已经登录");
    
    }
    //轮放图片
    imageArrary = [[NSMutableArray alloc] init];
    [imageArrary addObject:@"pic1.jpg"];
    [imageArrary addObject:@"pic2.jpg"];
    [imageArrary addObject:@"pic3.jpg"];
    [imageArrary addObject:@"pic4.jpg"];
    
    tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height-110)];
    tableview.allowsSelection=NO;
    tableview.backgroundColor=[UIColor whiteColor];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
 
   //下拉刷新视图
    if (_refreshTableHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-tableview.bounds.size.height, self.view.bounds.size.width, tableview.bounds.size.height)];
        view.delegate = self;
        [tableview addSubview:view];
        _refreshTableHeaderView = view;
    }
    [_refreshTableHeaderView refreshLastUpdatedDate];
}

//跳转至登录页面
-(void)JumpToLogin
{
    loginOrRegisterViewController *login= [[loginOrRegisterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark -tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"identity";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    //添加一个scrollview
    cell.backgroundColor=[UIColor whiteColor];
    VerticalScrollView = [self create_scrollview];
    VerticalScrollView.backgroundColor = [UIColor grayColor];
    VerticalScrollView.delegate = self;
    VerticalScrollView.userInteractionEnabled = YES;
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageArrary objectAtIndex:[imageArrary count]-1]]];
    imageview.frame = CGRectMake(0, 0, m_size.width, m_size.height/3);
    [VerticalScrollView addSubview:imageview];
    imageview = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:[imageArrary objectAtIndex:0]]];
    imageview.frame = CGRectMake(m_size.width*([imageArrary count]+1), 0, m_size.width, m_size.height/3);
    [VerticalScrollView addSubview:imageview];
    [VerticalScrollView setContentSize:CGSizeMake(m_size.width*([imageArrary count]+2), m_size.height/3)];
    [VerticalScrollView setContentOffset:CGPointMake(0, 0)];
    [VerticalScrollView scrollRectToVisible:CGRectMake(m_size.width, 0, m_size.width, m_size.height/3) animated:YES];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 160, 80, 20)];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    pageControl.numberOfPages = [imageArrary count];
  
    [cell.contentView addSubview:VerticalScrollView];
    [cell.contentView addSubview:pageControl];
    //添加一个view
    
    return cell;
}
///
#pragma mark --
#pragma mark 触发事件
-(void)runScrollView
{
    //NSLog(@"开始循环");
    int page = (int)pageControl.currentPage;
    page++;
    page = page>[imageArrary count]-1?0:page;
    pageControl.currentPage = page;
    //NSLog(@"%d",pageControl.currentPage);
    [self turnPage];
}
-(void)turnPage
{
    int page = (int)pageControl.currentPage;
    //NSLog(@"turnpage = %d",pageControl.currentPage);
    [VerticalScrollView scrollRectToVisible:CGRectMake(m_size.width*(page+1), 0, m_size.width, m_size.height/3) animated:NO];
}

-(UIScrollView*)create_scrollview
{
    UIScrollView *scorllview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height/3.0f)];
    scorllview.contentSize = CGSizeMake(m_size.width*[imageArrary count], 0);
    scorllview.pagingEnabled = YES;
    scorllview.showsHorizontalScrollIndicator=NO;
    scorllview.delegate = self;
    
    for (int i=0; i<[imageArrary count]; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(m_size.width*(i+1), 0, m_size.width, m_size.height/3)];
        NSString *imageName= [NSString stringWithString:[imageArrary objectAtIndex:i]];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.clipsToBounds=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.image=[UIImage imageNamed:imageName];
        //添加边框
//        CALayer * layer = [imageView layer];
//        layer.borderColor = [[UIColor whiteColor] CGColor];
//        layer.borderWidth = 5.0f;
        [scorllview addSubview:imageView];
        
    }
    return scorllview;
}



//tableview 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableview.bounds.size.height;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0;
}
#pragma mark =========================scrollview delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = VerticalScrollView.frame.size.width;
    int currentPage = floor((VerticalScrollView.contentOffset.x - pagewidth/ ([imageArrary count]+2)) / pagewidth) + 1;
    if (currentPage==0) {
        [VerticalScrollView scrollRectToVisible:CGRectMake(m_size.width*[imageArrary count], 0, m_size.width, m_size.height/3) animated:YES];
    }
    else if(currentPage ==[imageArrary count]+1)
    {
        [VerticalScrollView scrollRectToVisible:CGRectMake(m_size.width, 0, m_size.width, m_size.height/3) animated:NO];
    }

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    int page = floor((VerticalScrollView.contentOffset.x-VerticalScrollView.frame.size.width/([imageArrary count]+2))/VerticalScrollView.frame.size.width)+1;
    page--;
    pageControl.currentPage = page;
}

#pragma mark - EGORefreshTableHeaderViewDelegate methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{

    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0f];
}
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}
-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}


#pragma mark - dataloading
-(void)reloadTableViewDataSource
{
    _reloading = YES;
}
-(void)doneLoadingTableViewData
{
    
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    
//    [super viewDidDisappear:animated];
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self viewDidLoad];
    
    //从本地读取用户信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *username = [user objectForKey:@"userName"];
    NSString *userpass = [user objectForKey:@"userPass"];
    if (username==NULL||userpass==NULL) {
        //初始化导航栏右侧
        UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"登录/注册" style:UIBarButtonItemStylePlain target:self action:@selector(JumpToLogin)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }else
    {
        NSLog(@"您已登录");
        self.navigationItem.rightBarButtonItem = nil;
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewDidAppear:(BOOL)animated{
//    
//    [self viewDidLoad];
//    
//}
@end
