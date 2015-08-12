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
#import "AboutUsViewController.h"
#import "mapViewController.h"
#import "MyTableViewCell.h"
#import "BidDetailMessageViewController.h"
#import "TransferTableViewCell.h"

@interface SecondViewController()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SecondViewController
{
    CGSize m_size;
    UISegmentedControl *segmentControl;

    UIButton *submit_btn;//提交按钮
    NSInteger viewTag;//用来获取当前页面的控件tag
}
@synthesize AllBidTableView;
@synthesize TransferBidTableView;
@synthesize picker;
@synthesize filePath;
@synthesize timer;
@synthesize dataDictionary;
@synthesize dataArray;//存放全部标的

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
    self.navigationItem.title = @"投资项目";
    
    /*
     初始化字典里地数据
     Bname.text = @"Bname";
     profictRate.text = @"12.3%";
     Baddress.text = @"上海浦东";
     InvestAccount.text = @"1000000";
     InvestPeriod.text = @"3个月";
     LowestStart.text = @"50元起购";
     http://www.dianjinsuo.com/finance.do
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
    /*===================全部标===================*/
    AllBidTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segmentControl.bounds.size.height+64, m_size.width, m_size.height-segmentControl.bounds.size.height-100)];
    AllBidTableView.backgroundColor = [UIColor grayColor];
    AllBidTableView.delegate = self;
    AllBidTableView.dataSource = self;
    AllBidTableView.separatorInset= UIEdgeInsetsZero;
    EGORefreshTableHeaderView *Headerview = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-AllBidTableView.bounds.size.height, self.view.bounds.size.width, AllBidTableView.bounds.size.height)];
    Headerview.delegate = self;
    [AllBidTableView addSubview:Headerview];
    _refreshTableHeaderView = Headerview;
    [_refreshTableHeaderView refreshLastUpdatedDate];
    /*==================转让标======================*/
    
    //[self getDataFromWeb];
    
    [self.view addSubview:AllBidTableView];
}
///从网站请求数据
-(void)getDataFromWeb
{
    NSString *strUrl = @"http://www.dianjinsuo.com/finance.do";
    NSURL *Url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        //NSString *datastr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"request data:%@",datastr);
        
    }
    ];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -tableView delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"AllBidViewcell";
    static NSString *TCellId = @"Transform";
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    TransferTableViewCell *Tcell =(TransferTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TCellId];
    if (segmentControl.selectedSegmentIndex==0) {
        
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
    else if(segmentControl.selectedSegmentIndex==1)
    {
        if (Tcell==nil) {
            Tcell = [[TransferTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TCellId];
        }
        Tcell.separatorInset = UIEdgeInsetsZero;
        Tcell.selectionStyle = UITableViewCellSelectionStyleNone;
        Tcell.userInteractionEnabled =YES;
        /*
         @property (nonatomic ,strong)UILabel* TransferPrice;//转让价格
         @property (nonatomic ,strong)UILabel* TransferTime;//承接事件
         @property (nonatomic ,strong)UILabel* MoneyToLast;//剩余本金
         @property (nonatomic ,strong)UILabel* PeriodToLast;//剩余期数
         */
        Tcell.TransferPrice.text = @"";
        //[Tcell loadCellData:dataDictionary];
        return Tcell;
    }
    else
    {
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (segmentControl.selectedSegmentIndex==0) {
        return [dataArray count];
    }
    else if(segmentControl.selectedSegmentIndex==1)
    {
        return 10;
    }
    else
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (segmentControl.selectedSegmentIndex==0)
    {
        BidDetailMessageViewController *bidMessageView = [BidDetailMessageViewController new];
        UINavigationController *navigationCtrl = [[UINavigationController alloc] initWithRootViewController:bidMessageView];
        [bidMessageView GetDataFrom:[dataArray objectAtIndex:indexPath.row]];
        UITabBarController *tabbar = [[UITabBarController alloc] init];
        [tabbar addChildViewController:navigationCtrl];
        [self presentViewController:tabbar animated:YES completion:nil];
    }
    else if (segmentControl.selectedSegmentIndex==1)
    {
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
}
#pragma mark -getMoreData:
#pragma mark -上拉加载更多数据
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


#pragma mark =========================
//上拉加载更多  下拉刷新
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y>=fmaxf(.0f, scrollView.contentSize.height - scrollView.frame.size.height)+20)
    {
        [self getMoreData:0];
    }
    if (segmentControl.selectedSegmentIndex==0) {
        [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
    if (segmentControl.selectedSegmentIndex==1) {
        [_refreshTransferHeadrView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (segmentControl.selectedSegmentIndex==0) {
        [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    if (segmentControl.selectedSegmentIndex==1) {
        [_refreshTransferHeadrView egoRefreshScrollViewDidScroll:scrollView];
    }
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
    _reloading = NO;
    if (segmentControl.selectedSegmentIndex==0) {
        [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:AllBidTableView];
    }
    if (segmentControl.selectedSegmentIndex==1) {
        [_refreshTransferHeadrView egoRefreshScrollViewDataSourceDidFinishedLoading:TransferBidTableView];
    }
    
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
    if (segmentcontrol.selectedSegmentIndex==0)
    {
        //全部标的
        [TransferBidTableView removeFromSuperview];
        [self.view addSubview:AllBidTableView];
    }
    else if (segmentControl.selectedSegmentIndex==1)
    {
        //转让标的
        [AllBidTableView removeFromSuperview];
        TransferBidTableView = [[UITableView alloc] init];
        TransferBidTableView.frame = CGRectMake(0, segmentControl.bounds.size.height+64, m_size.width, m_size.height-segmentControl.bounds.size.height-100);
        TransferBidTableView.delegate = self;
        TransferBidTableView.dataSource = self;
        TransferBidTableView.backgroundColor =[UIColor redColor];
        EGORefreshTableHeaderView *transHeaderView =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(.0f, .0f-TransferBidTableView.bounds.size.height, self.view.bounds.size.width, TransferBidTableView.bounds.size.height)];
        transHeaderView.delegate= self;
        [TransferBidTableView addSubview:transHeaderView];
        _refreshTransferHeadrView = transHeaderView;
        [_refreshTransferHeadrView refreshLastUpdatedDate];
        
        [self.view addSubview:TransferBidTableView];
        
        
    }
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:AllBidTableView];
}

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
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [AllBidTableView removeFromSuperview];
}
-(void)viewDidUnload
{
    _refreshTableHeaderView = nil;
    
}
@end
