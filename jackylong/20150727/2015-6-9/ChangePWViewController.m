//
//  ChangePWViewController.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-10.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "ChangePWViewController.h"

@interface ChangePWViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *tableview;
    UIView *imageView;
    NSArray *cellLabelText;
    
    UITextField *PhoneNum;
    UITextField *Name;
    UITextField *IDcard;
}
@end

@implementation ChangePWViewController


-(void)loadView
{
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor grayColor];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backUp)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_profile.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backUp)];
    self.navigationItem.title = @"找回密码";
    
    
    cellLabelText = [[NSArray alloc] initWithObjects:@"手机号",@"姓名",@"身份证", nil];
    
    imageView = [[UIView alloc]initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width-20, 80)];
    imageView.backgroundColor = [UIColor redColor];
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 190, self.view.bounds.size.width, 400)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.allowsSelection = NO;
    tableview.userInteractionEnabled = YES;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:imageView];
    [self.view addSubview: tableview];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}
-(void)backUp
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark -tableview delegate method
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseCellId = @"cellidentity";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellId];
        cell.separatorInset = UIEdgeInsetsZero;
        
    }
    cell.textLabel.text = [cellLabelText objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        PhoneNum = [[UITextField alloc] init];
        PhoneNum.frame = CGRectMake(80, 0, cell.contentView.bounds.size.width-90, cell.contentView.bounds.size.height);
        PhoneNum.delegate = self;
        PhoneNum.placeholder = @"请输入注册时的手机号码";
        PhoneNum.keyboardType = UIKeyboardTypeNumberPad;
        [cell.contentView addSubview:PhoneNum];
    }
    if (indexPath.row==1) {
        Name = [[UITextField alloc] init];
        [Name setFrame:CGRectMake(80, 0, cell.contentView.bounds.size.width-90, cell.contentView.bounds.size.height)];
        Name.delegate = self;
        Name.placeholder = @"输入身份证对应的姓名";
        [cell.contentView addSubview:Name];
    }
    if (indexPath.row==2) {
        IDcard = [[UITextField alloc] init];
        IDcard.frame = CGRectMake(80, 0, cell.contentView.bounds.size.width-90, cell.contentView.bounds.size.height);
        IDcard.delegate = self;
        IDcard.placeholder = @"输入身份证号";
        IDcard.keyboardType = UIKeyboardTypeDefault;
        [cell.contentView addSubview:IDcard];
    }
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [cellLabelText count];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y+32-(self.view.frame.size.height-216);
    //NSTimeInterval animationDuration = 0.3f;
    //[UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    //[UIView setAnimationDuration:animationDuration];
    if (offset>0) {
        self.view.frame = CGRectMake(0.0f, offset, self.view.bounds.size.width, 400);
        //[UIView commitAnimations];
    }
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
