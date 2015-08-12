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
#import "MYItem.h"
#import "IMRowView.h"


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
    
    MYItem *item1  = [[MYItem alloc] init];
    item1.title = [NSString stringWithFormat:@"项目详情"];
    item1.subtitle = [NSString stringWithFormat:@"1"];
    MYItem *item2 = [[MYItem alloc] init];
    item2.title = [NSString stringWithFormat:@"借款人信息"];
    item2.subtitle = [NSString stringWithFormat:@"2"];
    MYItem *item3 = [[MYItem alloc] init];
    item3.title = [NSString stringWithFormat:@"投标记录"];
    item3.subtitle = [NSString stringWithFormat:@"3"];
    
    //初始化tableview的样式和标题及内容
    titleArray = [NSMutableArray arrayWithObjects:@"标信息",@"标介绍",@"安全提醒", nil];
    dataArray1 = [NSMutableArray arrayWithObjects:@"", nil];
    dataArray2 = [NSMutableArray arrayWithObjects:@"", nil];
    dataArray3 = [NSMutableArray arrayWithObjects:item1,item2,item3, nil];
    
    [self.view addSubview:detailTableview];
}
-(void)initBidView:(UIView*)Bview
{

    /*---------------------------------填充Bview内容-------------------------------------------*/
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
    MYItem *item = nil;
    IMRowView *rowview = nil;
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
            
            //[self initBidView:cell.contentView];
            break;
        case 1:
            
            break;
        case 2:
        {
            item = [dataArray3 objectAtIndex:indexPath.row];
            rowview = [[IMRowView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight)];
            rowview.tag = 2222;
            [[cell textLabel] setText:item.title];
            cell.separatorInset = UIEdgeInsetsZero;
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            rowview = (IMRowView*)[cell.contentView viewWithTag:2222];
            rowview.frame = CGRectMake(0, 0, cell.contentView.bounds.size.width, item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight);
            rowview.item = item;
            [cell.contentView addSubview:rowview];
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

    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 200;
            break;
        case 2:
        {
            ////////
            MYItem *item = [dataArray3 objectAtIndex:indexPath.row];
            return item.isopen?IMRowHeight+IMRowSubHeight:IMRowHeight;
        }
            
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
//    
//    UIView *showview= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
//    UITableViewCell *currentCell = [self tableView:detailTableview cellForRowAtIndexPath:indexPath];
    if (indexPath.section==2)
        {
            NSLog(@"选择第3组");
            MYItem *item = nil;
            if (_openIndexPath) {
                //NSLog(@"%@",_openIndexPath);
                if (_openIndexPath.row==indexPath.row) {
                    item = [dataArray3 objectAtIndex:_openIndexPath.row];
                    item.isopen = NO;
                    //[detailTableview insertRowsAtIndexPaths:[NSArray arrayWithObjects:_openIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                    [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_openIndexPath , nil] withRowAnimation:UITableViewRowAnimationFade];
                    _openIndexPath = nil;
                }
                else
                {
                    item = [dataArray3 objectAtIndex:_openIndexPath.row];
                    item.isopen = NO;
                    item = [dataArray3 objectAtIndex:indexPath.row];
                    item.isopen = YES;
                    //[detailTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:_openIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_openIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                    _openIndexPath = indexPath;
                }
            }
            else
            {
                item = [dataArray3 objectAtIndex:indexPath.row];
                item.isopen = YES;
                //[detailTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:_openIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                [detailTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
                _openIndexPath = indexPath;
            }
            
//            if ([currentCell.textLabel.text isEqualToString:@"项目详情"])
//            {
//                
//                if (isSelected == NO)
//                {
//                    NSLog(@"第3组第0行");
//                    //NSString *str = @"aaaaa";
//                    [dataArray3 insertObject:showview atIndex:indexPath.row+1];
//                    [detailTableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                }
//                else
//                {
//                    [dataArray3 removeObjectAtIndex:indexPath.row+1];
//                    [detailTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                }
//                isSelected = !isSelected;
//                }
//            }
//            if ([currentCell.textLabel.text isEqualToString:@"借款人信息"])
//            {
//                    NSLog(@"第3组第1行");
//                    if (isSelected1 == NO)
//                    {
//                        NSLog(@"第3组第0行");
//                        //NSString *str = @"aaaaa";
//                        [dataArray3 insertObject:showview atIndex:indexPath.row+1];
//                        [detailTableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                    }
//                    else
//                    {
//                        [dataArray3 removeObjectAtIndex:indexPath.row+1];
//                        [detailTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//                    }
//                    isSelected1 = !isSelected1;
//                
//            }
//            if ([currentCell.textLabel.text isEqualToString:@"投标记录"])
//            {
//                     NSLog(@"第3组第2行");
//                    if (isSelected2 == NO)
//                    {
//                        NSLog(@"第3组第0行");
//                        //NSString *str = @"aaaaa";
//                        [dataArray3 insertObject:showview atIndex:indexPath.row+1];
//                        [detailTableview insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//                    }
//                    else
//                    {
//                        [dataArray3 removeObjectAtIndex:indexPath.row+1];
//                        [detailTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//                    }
//                    isSelected2 = !isSelected2;
//                
        }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end