//
//  GetCheapViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "GetCheapViewController.h"
#import "MyTableViewCell.h"
#import "MyTabBarViewController.h"
@interface GetCheapViewController ()
{
    UITextView *a_textView;
    
}
@end

@implementation GetCheapViewController
@synthesize m_tableView;
@synthesize arr;
@synthesize datas;
@synthesize segmentedControl;
@synthesize imageArray;
@synthesize nameArray;
@synthesize priceArray;
@synthesize dictionary;

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
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor grayColor];
    m_tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-150) style:UITableViewStylePlain];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    m_tableView.allowsSelection=NO;
    m_tableView.userInteractionEnabled=YES;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 30)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"加载更多" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getMoreData:) forControlEvents:UIControlEventTouchUpInside];
    m_tableView.tableFooterView=btn;
    //m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //segmentedcontrol
    NSArray *array=@[@"全部",@"金饰",@"珠宝",@"钻石",@"钟表",@"热卖",@"搜索",@"其他"];
    segmentedControl=[[UISegmentedControl alloc]initWithItems:array];
    // segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentedControl.frame=CGRectMake(0, 60, self.view.bounds.size.width, 40);
    //默认选择
    //segmentControl.selectedSegmentIndex=1;
    //设置背景色
    segmentedControl.tintColor=[UIColor orangeColor];
    //设置
    segmentedControl.backgroundColor=[UIColor blackColor];
    //设置监听事件
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex=0;
    //[self GetRequest];
    nameArray=[NSMutableArray arrayWithObjects:@"1",@"2", nil];
    priceArray=[NSMutableArray arrayWithObjects:@"11",@"22", nil];
    imageArray=[NSMutableArray arrayWithObjects:@"button_1.png",@"button_2.png",@"button_3.png",@"button_4.png", nil];
    
    dictionary=[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                nameArray,@"name",
                imageArray,@"image",
                priceArray,@"price", nil];
//    dictionary=[NSMutableDictionary dictionaryWithObjectsAndKeys:
//         nameArray,@"name",
//         imageArray,@"image",
//         priceArray,@"price", nil];
    //NSLog(@"%@",dictionary);
    
    //NSLog(@"图片数组长度%ld",);
    [self.view addSubview:m_tableView];
}

//加页脚
-(void)addFooterView
{
    
}
-(void)getMoreData:(int)page
{

}

#pragma mark - segmentedcontrol
-(void)change:(UISegmentedControl *)segmentcontrol
{
    NSLog(@"选择%ld",segmentedControl.selectedSegmentIndex);

}


#pragma mark -tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid=@"cellId";
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil)
    {
        cell=[[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid] ;
    }
    //NSLog(@"%@",dictionary);
    [cell refreshData:dictionary];//将网络中请求到的数据放到cell中显示
    
    //cell.imageView.image=
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///MyTableViewCell *newCell=[[MyTableViewCell alloc] init];
    //newCell.i
    return 160;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
