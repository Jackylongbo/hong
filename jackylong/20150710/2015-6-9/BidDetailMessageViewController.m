//
//  BidDetailMessageViewController.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//


/*
 介绍标的详细信息
 
 */



#import "BidDetailMessageViewController.h"
#import "LDProgressView.h"
#import "IMRowView.h"
#import "BidCaculatorViewController.h"

@interface BidDetailMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *detailTableview;
    LDProgressView *Ldprogressview;
    NSMutableArray *titleArray ; //存放标题
    NSMutableArray *dataArray1;
    NSMutableArray *dataArray2;
    NSMutableArray *dataArray3;
    
    UIView *BidView;//标的信息
    
    BOOL isSelected;//cell1是否被选中
    BOOL isSelected1;//cell2
    BOOL isSelected2;//cell3
    NSInteger selectedIndex;//被选中的cell下标
    NSIndexPath *_openIndexPath;
    NSIndexSet *indexset;
}


@end

@implementation BidDetailMessageViewController
@synthesize BnameLabel;
@synthesize BLastContentLabel;
@synthesize BlastedLabel;
@synthesize profictRate;
@synthesize ProfictRateLabel;
@synthesize InvestMoneyLabel;
@synthesize InvestMoney;
@synthesize InvestPeriod;
@synthesize InvestPeriodLabel;
////
@synthesize bname;
@synthesize brate;
@synthesize bmoney;
@synthesize bperiod;
@synthesize dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title  = @"标的详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(GetBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"标计算器" style:UIBarButtonItemStyleDone target:self action:@selector(GotoCaculator)];
    //UIImage *image = [UIImage imageNamed:@"1.png"];
    //self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"标满？" image:image selectedImage:nil];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width-10, 40)];
    [btn setTitle:@"立即投标" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    btn.tag = 10011;
    [btn addTarget:self action:@selector(FastToGet:) forControlEvents:UIControlEventTouchUpInside];
    //[self.navigationController.view addSubview:btn];
    [self.navigationController.tabBarController.tabBar addSubview:btn];
    
    
    detailTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    detailTableview.delegate = self;
    detailTableview.dataSource = self;
    detailTableview.sectionFooterHeight = 4.0f;
    detailTableview.separatorInset = UIEdgeInsetsZero;
    
    BidView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    
    BnameLabel = [[UILabel alloc] init];
    BLastContentLabel = [[UILabel alloc] init];
    InvestMoney = [[UILabel alloc] init];
    InvestPeriod = [[UILabel alloc] init];
    profictRate = [[UILabel alloc] init];
    
    BnameLabel.text = bname;
    InvestMoney.text = bmoney;
    profictRate.text = brate;
    InvestPeriod.text = bperiod;
    
    //初始化tableview的样式和标题及内容
    titleArray = [NSMutableArray arrayWithObjects:@"标信息",@"标介绍",@"安全提醒", nil];
    dataArray1 = [NSMutableArray arrayWithObjects:@"", nil];
    dataArray2 = [NSMutableArray arrayWithObjects:@"", nil];
    
    MYItem * item1 = [[MYItem alloc] init];
    item1.title = @"项目详情";
    item1.subtitle = @"11111";
    MYItem * item2 = [[MYItem alloc] init];
    item2.title = @"借款人资料";
    item2.subtitle = @"22222";
    MYItem * item3 = [[MYItem alloc] init];
    item3.title = @"当前项目投资记录";
    item3.subtitle = @"33333";
    MYItem *item4 = [[MYItem alloc] init];
    item4.title = @"担保资料和合作协议";
    dataArray3 = [NSMutableArray arrayWithObjects:item1,item2,item3, item4,nil];
    
    [self.view addSubview:detailTableview];
}


-(void)initBidView:(UIView*)Bview
{

    /*---------------------------------填充Bview内容-------------------------------------------*/
    [BnameLabel setFrame:CGRectMake(10, 5, Bview.bounds.size.width-10, 25)];
    
    BnameLabel.font = [UIFont systemFontOfSize:16.0f];
    BlastedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 25)];
    BlastedLabel.text = @"剩余可投:";
    BlastedLabel.font = [UIFont systemFontOfSize:13.0f];
    [BLastContentLabel setFrame:CGRectMake(80, 40, 80, 25)];
    BLastContentLabel.textColor = [UIColor redColor];
    BLastContentLabel.backgroundColor = [UIColor grayColor];
    BLastContentLabel.font = [UIFont systemFontOfSize:13.0f];
    InvestMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 40, 80, 25)];
    InvestMoneyLabel.text = @"借款总额:";
    InvestMoneyLabel.font = [UIFont systemFontOfSize:13.f];
    
    [InvestMoney setFrame:CGRectMake(Bview.bounds.size.width-80, 40, Bview.bounds.size.width/4-10, 25)];
    InvestMoney.font = [UIFont systemFontOfSize:13.f];
    InvestMoney.textColor = [UIColor redColor];
    
    ProfictRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 60, 20)];
    ProfictRateLabel.font = [UIFont systemFontOfSize:13.f];
    ProfictRateLabel.text = @"年利率";
    [profictRate setFrame:CGRectMake(10, 100, 70, 30)];
    //profictRate =[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 70, 30)];
    profictRate.textColor = [UIColor redColor];
    profictRate.font = [UIFont systemFontOfSize:18.f];
    InvestPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(Bview.bounds.size.width/2, 85, 110, 30)];
    InvestPeriodLabel.text = @"借款期限(月)";
    [InvestPeriod setFrame:CGRectMake(Bview.bounds.size.width/2+20, 110, 60, 30)];
    //InvestPeriod = [[UILabel alloc] initWithFrame:CGRectMake(Bview.bounds.size.width/2, 110, 40, 30)];
    InvestPeriod.font = [UIFont systemFontOfSize:20.f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, profictRate.frame.origin.y+profictRate.bounds.size.height+20, 80, 20)];
    label.text = @"投标进度:";
    label.textColor = [UIColor lightGrayColor];
    Ldprogressview = [[LDProgressView alloc] initWithFrame:CGRectMake(100, profictRate.frame.origin.y+profictRate.bounds.size.height+20, Bview.bounds.size.width-120, 20)];
    Ldprogressview.progress = 0.54f;
    Ldprogressview.type = LDProgressStripes;
    Ldprogressview.borderRadius = @2;
    Ldprogressview.animate = @YES;
    Ldprogressview.color = [UIColor greenColor];
    
    [Bview addSubview:BnameLabel];
    [Bview addSubview:BlastedLabel];
    [Bview addSubview:BLastContentLabel];
    [Bview addSubview:InvestPeriod];
    [Bview addSubview:InvestMoney];
    [Bview addSubview:InvestMoneyLabel];
    [Bview addSubview:InvestPeriodLabel];
    [Bview addSubview:profictRate];
    [Bview addSubview:ProfictRateLabel];
    [Bview addSubview:Ldprogressview];
    [Bview addSubview:label];
}
///
-(void)FastToGet:(UIButton*)sender
{
    NSLog(@"立即抢狗狗");
    
}

//
-(void)BidIntrodution:(UIView*)contentview
{
    
}


//获取传递的数据
-(void)GetDataFrom:(NSDictionary *)dictionary
{
    dic = [NSDictionary dictionaryWithDictionary:dictionary];
    bname = [dic objectForKey:@"Bname"];
    bmoney = [dic objectForKey:@"InvestAccount"];
    brate = [dic objectForKey:@"profictRate"];
    bperiod = [dic objectForKey:@"InvestPeriod"];
}

//导航栏左侧的item 绑定事件
-(void)GetBack
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//导航栏右侧item 绑定事件
-(void)GotoCaculator
{
    BidCaculatorViewController *bidCaculator= [[BidCaculatorViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:bidCaculator];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [nav setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                if (cell!=nil) {
                    cell=nil;
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                    [self initBidView:cell.contentView];
                }
            }
            break;
        case 1:
            if (indexPath.row==0) {
                
                if (cell!=nil) {
                    cell=nil;
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                    //[cell.contentView addSubview:nil];
                    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
            }
            break;
        case 2:
        {
            if (cell!=nil)
            {
                cell=nil;
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                MYItem *item =[dataArray3 objectAtIndex:indexPath.row];
                IMRowView *rowView = nil;
                rowView = [[IMRowView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight)];
                //rowView.IMrowtype = IMRowViewTypeTwo;
                cell.separatorInset = UIEdgeInsetsZero;
                if (indexPath.row==0) {
                    rowView.IMrowtype = IMRowViewTypeOne;
                    //NSLog(@"%ld  indexpath.row = %ld",rowView.IMrowtype,indexPath.row);
                }
                else if(indexPath.row == 1)
                {
                    rowView.IMrowtype = IMRowViewTypeTwo;
                   // NSLog(@"%ld  indexpath.row = %ld",rowView.IMrowtype,indexPath.row);
                }
                else if(indexPath.row==2)
                {
                    rowView.IMrowtype = IMRowViewTypeThree;
                   // NSLog(@"%ld  indexpath.row = %ld",rowView.IMrowtype,indexPath.row);
                }
                [cell.contentView addSubview:rowView];
                rowView.frame =CGRectMake(0, 0, cell.contentView.bounds.size.width, item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight);
                rowView.item = item;
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [dataArray1 count];
            break;
        case 1:
            return [dataArray2 count];
            break;
        case 2:
            return [dataArray3 count];
            break;
        default:
            return 0;
            break;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }
    else if(indexPath.section==1)
    {
        return 200;
    }else if(indexPath.section==2)
    {
        MYItem *item = [dataArray3 objectAtIndex:indexPath.row];
        return item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight;
    }
    else
        return 0;
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

//有多少个分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [titleArray count];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//tableviewcell选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        //局部刷新
        MYItem *item = nil;
        indexset = [[NSIndexSet alloc] initWithIndex:2];
        if (!_openIndexPath) {
            item = [dataArray3 objectAtIndex:indexPath.row];
            item.isopen= YES;
            //[detailTableview beginUpdates];
            [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//            [detailTableview reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
            _openIndexPath = indexPath;
            item =nil;
            
            //[detailTableview endUpdates];
        }else
        {
            //[detailTableview beginUpdates];
            if (_openIndexPath.row==indexPath.row) {
                item = [dataArray3 objectAtIndex:_openIndexPath.row];
                item.isopen=NO;
                [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_openIndexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                _openIndexPath=nil;
                item = nil;
            }
            else
            {
                item = [dataArray3 objectAtIndex:_openIndexPath.row];
                item.isopen = NO;
                item=nil;
                item = [dataArray3 objectAtIndex:indexPath.row];
                item.isopen = YES;
                [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_openIndexPath,indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                _openIndexPath = indexPath;
                item=nil;
            }
            //[detailTableview reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
            //[detailTableview endUpdates];
        }
        [detailTableview reloadSections:indexset withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [detailTableview removeFromSuperview];
    NSLog(@"视图消失");
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.view addSubview:detailTableview];
    NSLog(@"视图出现");
}
-(void)viewWillAppear:(BOOL)animated
{
        //[self viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
