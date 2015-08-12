//
//  BidCaculatorViewController.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-23.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "BidCaculatorViewController.h"

@interface BidCaculatorViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tableview;
    UISegmentedControl *segmentedControl;
    UILabel *BidAccount;//投资金额
    UILabel *BidProfile;//投资金额
    UILabel *BidPeriod;//借款期限
    UILabel *WayToRepay;//还款方式
    
    UITextField *Accout;//投资金额
    UITextField *Profile;//投资金额
    UITextField *Period;//借款期限
    //UITextField *WayRepay;//还款方式
    
    UIView *footerView;//tableview的footerview
    UILabel *productProfile;//产品收益
    UILabel *Product;//
    UILabel *warningLabel;//提示信息
    
    CGSize mysize;
}
@end

@implementation BidCaculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mysize = self.view.bounds.size;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(GEtBack)];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mysize.width, mysize.height)];
    [tableview setSeparatorInset:UIEdgeInsetsZero];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableview.bounds.size.width, 90)];
    Product = [[UILabel alloc] initWithFrame:CGRectMake(mysize.width-180, 10, 80, 25)];
    Product.font = [UIFont systemFontOfSize:15.0f];
    Product.text = @"产品收益:";
    productProfile = [[UILabel alloc] initWithFrame:CGRectMake(mysize.width-110, 10, 100, 25)];
    productProfile.font = [UIFont systemFontOfSize:14.f];
    productProfile.textColor = [UIColor blueColor];
    productProfile.text = [NSString stringWithFormat:@"￥%.2f",0.0];// @"￥0";
    [footerView addSubview:Product];
    [footerView addSubview:productProfile];
    
    warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(mysize.width-140, 65, 130, 20)];
    warningLabel.textColor = [UIColor lightGrayColor];
    [footerView addSubview:warningLabel];
    
    
    [tableview setTableFooterView:footerView];
    
    
    BidAccount = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    BidAccount.text = @"投资金额:";
    
    Accout = [[UITextField alloc] initWithFrame:CGRectMake(115, 0, mysize.width-125, 44)];
    Accout.keyboardType = UIKeyboardTypeNumberPad;
    Accout.textAlignment = NSTextAlignmentRight;
    Accout.placeholder = @"请输入金额";
    Accout.delegate = self;
    //[Accout addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventValueChanged];
    BidProfile = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    BidProfile.text = @"年利率:";
    Profile = [[UITextField alloc] initWithFrame:CGRectMake(175, 0, mysize.width-190, 44)];
    Profile.enabled = NO;
    Profile.text = @"0.135";
    Profile.textAlignment = NSTextAlignmentRight;
    
    BidPeriod = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 120, 44)];
    BidPeriod.text = @"借款期限(月):";
    Period  =[[UITextField alloc] initWithFrame:CGRectMake(175, 0, mysize.width-190, 44)];
    Period.textAlignment = NSTextAlignmentRight;
    Period.enabled = NO;
    Period.text = @"1";
    
    WayToRepay = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    WayToRepay.text = @"还款方式:";
    segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"月还息到期还本",@"等额本息"]];
    segmentedControl.frame = CGRectMake(115, 10, mysize.width-120, 25);
    [segmentedControl addTarget:self action:@selector(ValueChanged) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 1;
}


#pragma mark--====
#pragma mark - tableview delegate method

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"reuseIdentifier";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        [cell.contentView addSubview:BidAccount];
        [cell.contentView addSubview:Accout];
    }
    else if(indexPath.row==1)
    {
        [cell.contentView addSubview:BidProfile];
        [cell.contentView addSubview:Profile];
    }
    else if (indexPath.row==2)
    {
        [cell.contentView addSubview:BidPeriod];
        [cell.contentView addSubview:Period];
    }else if(indexPath.row==3)
    {
        [cell.contentView addSubview:WayToRepay];
        [cell.contentView addSubview:segmentedControl];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}
////segmentedControl
-(void)ValueChanged
{
    //productProfile.text = [NSString stringWithFormat:@"￥%.2f",0.0];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //Accout.text = str;
    
    productProfile.text = [NSString stringWithFormat:@"￥%.2f",([Profile.text floatValue])*([str intValue])*([Period.text intValue])/12];
    
    return YES;
}
///
-(void)GEtBack
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
