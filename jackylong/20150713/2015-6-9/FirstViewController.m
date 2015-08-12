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
    //
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.view.userInteractionEnabled = YES;
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //
    [self.navigationItem setTitle:@"微贷网"];
    //初始化导航栏右侧
    UIBarButtonItem* rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"登录/注册" style:UIBarButtonItemStylePlain target:self action:@selector(JumpToLogin)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;

    tableview =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height-110)];
    tableview.allowsSelection=NO;
    tableview.backgroundColor=[UIColor whiteColor];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
 
   
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
    [self presentModalViewController:nav animated:YES];
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
    cell.backgroundColor=[UIColor purpleColor];
    VerticalScrollView = [self create_scrollview];
    VerticalScrollView.backgroundColor = [UIColor grayColor];
    [cell.contentView addSubview:VerticalScrollView];
    //添加一个view
    
    return cell;
}

-(UIScrollView*)create_scrollview
{
    UIScrollView *scorllview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height/3.0f)];
    scorllview.contentSize = CGSizeMake(m_size.width*2, 0);
    scorllview.pagingEnabled = YES;
    scorllview.showsHorizontalScrollIndicator=NO;
    scorllview.delegate = self;
    
    for (int i=0; i<2; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(m_size.width*i, 0, m_size.width, m_size.height/3)];
        NSString *imageName=[NSString stringWithFormat:@"pic0%d.jpg",i+1];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableview.bounds.size.height;

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始刷新");
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0;
}
#pragma mark =========================

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
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

-(void)viewDidAppear:(BOOL)animated
{
//    loginOrRegisterViewController *login= [[loginOrRegisterViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] init];
//    
//    [nav pushViewController:login animated:YES];
//    
//    
//    self.view.window.rootViewController = nav;
    
}

#pragma mark - dataloading
-(void)reloadTableViewDataSource
{
    _reloading = YES;
}
-(void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
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
