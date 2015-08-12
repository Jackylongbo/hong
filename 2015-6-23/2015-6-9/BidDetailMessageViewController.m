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


@interface BidDetailMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *detailTableview;
    LDProgressView *Ldprogressview;
    NSArray *titleArray ; //存放标题
    NSArray *dataArray1;
    NSArray *dataArray2;
    NSArray *dataArray3;
    
    UIView *BidView;//标的信息
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
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title  = @"标的详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(GetBack)];
    
    UIImage *image = [UIImage imageNamed:@"1.png"];
    self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"标满？" image:image selectedImage:nil];
    
    
    detailTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    detailTableview.delegate = self;
    detailTableview.dataSource = self;
    detailTableview.sectionFooterHeight = 4.0f;
    
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
    titleArray = [NSArray arrayWithObjects:@"标信息",@"标介绍",@"安全提醒", nil];
    dataArray1 = [NSArray arrayWithObjects:@"", nil];
    dataArray2 = [NSArray arrayWithObjects:@"", nil];
    dataArray3 = [NSArray arrayWithObjects:@"项目详情",@"借款人信息",@"投标记录", nil];
    
    [self.view addSubview:detailTableview];
}
-(void)initBidView:(UIView*)Bview
{

    /*---------------------------------填充BicView内容-------------------------------------------*/
    [BnameLabel setFrame:CGRectMake(10, 5, Bview.bounds.size.width-10, 25)];
    
    BnameLabel.font = [UIFont systemFontOfSize:16.0f];
    BlastedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, Bview.bounds.size.width/4-10, 25)];
    BlastedLabel.text = @"剩余可投:";
    BlastedLabel.font = [UIFont systemFontOfSize:13.0f];
    [BLastContentLabel setFrame:CGRectMake(BLastContentLabel.frame.origin.x+Bview.bounds.size.width/4, 40, Bview.bounds.size.width/4-20, 25)];
    BLastContentLabel.textColor = [UIColor redColor];
    BLastContentLabel.font = [UIFont systemFontOfSize:13.0f];
    InvestMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(BLastContentLabel.frame.origin.x+BLastContentLabel.bounds.size.width+40, 40, Bview.bounds.size.width/4-10, 25)];
    InvestMoneyLabel.text = @"项目总额:";
    InvestMoneyLabel.font = [UIFont systemFontOfSize:13.f];
    
    [InvestMoney setFrame:CGRectMake(Bview.bounds.size.width-80, 40, Bview.bounds.size.width/4-10, 25)];
    InvestMoney.font = [UIFont systemFontOfSize:13.f];
    InvestMoney.textColor = [UIColor redColor];
    
    ProfictRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 85, 60, 20)];
    ProfictRateLabel.font = [UIFont systemFontOfSize:13.f];
    ProfictRateLabel.text = @"年化利率";
    [profictRate setFrame:CGRectMake(20, 100, 70, 30)];
    //profictRate =[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 70, 30)];
    profictRate.textColor = [UIColor redColor];
    profictRate.font = [UIFont systemFontOfSize:18.f];
    InvestPeriodLabel = [[UILabel alloc] initWithFrame:CGRectMake(Bview.bounds.size.width/2, 75, 110, 30)];
    InvestPeriodLabel.text = @"理财期限(月)";
    [InvestPeriod setFrame:CGRectMake(Bview.bounds.size.width/2+20, 110, 60, 30)];
    //InvestPeriod = [[UILabel alloc] initWithFrame:CGRectMake(Bview.bounds.size.width/2, 110, 40, 30)];
    InvestPeriod.font = [UIFont systemFontOfSize:20.f];
    
    Ldprogressview = [[LDProgressView alloc] initWithFrame:CGRectMake(10, profictRate.frame.origin.y+profictRate.bounds.size.height+20, Bview.bounds.size.width-20, 20)];
    Ldprogressview.progress = 1.0f;
    
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
}

//获取传递的数据
-(void)GetDataFrom:(NSDictionary *)dictionary
{
    /*
     dataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
     @"典金所",@"Bname",
     @"13.2%",@"profictRate",
     @"上海闵行",@"Baddress",
     @"200000",@"InvestAccount",
     @"2个月",@"InvestPeriod",
     @"50元起购",@"LowestStart",
     nil];
     
     */
    dic = [NSDictionary dictionaryWithDictionary:dictionary];
    bname = [dic objectForKey:@"Bname"];
    bmoney = [dic objectForKey:@"InvestAccount"];
    NSLog(@"%@",bmoney);
    brate = [dic objectForKey:@"profictRate"];
    bperiod = [dic objectForKey:@"InvestPeriod"];
}


-(void)GetBack
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    switch (indexPath.section) {
        case 0:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self initBidView:cell.contentView];
            break;
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 2:
            [[cell textLabel] setText:[dataArray3 objectAtIndex:indexPath.row]];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 200;
            break;
        case 2:
            return 40;
            break;
        default:
            return 0;
            break;
    }

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
