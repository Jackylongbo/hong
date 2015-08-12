//
//  ThirdViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyCommbox.h"
#import "loginOrRegisterViewController.h"



@interface ThirdViewController ()
{
    NSString *getString;//
    NSMutableString *changeString;
    NSArray *changeArray;
    MyCommbox *commbox_id;//证件选择
    MyCommbox *commbox_choose;//赎当或者续当
    NSArray *arr;//用来存放下拉列表的数据
    
    UIView *showView;//用做蒙版的view
    BOOL ConfirmOk;//验证是否正确,用来判断登录是否成功
    UIVisualEffectView *effectview;
}
@end

@implementation ThirdViewController


@synthesize yanzhengma;//
@synthesize yanCode;//生成验证码
@synthesize btn_confirm;//登录提交按钮
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 初始化一个蒙版，蒙版上有一个view
 提示登录
 
 */
-(void)initFirstLoginView
{
    showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    showView.backgroundColor = [UIColor whiteColor];
    showView.alpha = 1;
    //添加毛玻璃效果
    UIBlurEffect *blur= [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    effectview.alpha = 1;
    
    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 40)];
    warning.text = @"查看资料前请先登录";
    warning.textAlignment = NSTextAlignmentCenter;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, 180, 40)];
    [btn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor greenColor];
    
    
    [showView addSubview:warning];
    [showView addSubview:btn];
    [effectview addSubview:showView];
    showView.center = effectview.center;
    
    [self.view addSubview: effectview];
}
//登录按钮绑定事件
-(void)btnClicked:(UIButton*)sender
{
    loginOrRegisterViewController *login= [[loginOrRegisterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}



//视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"典金所";
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.view.userInteractionEnabled=YES;
    //self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    //
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,00, self.view.bounds.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.sectionFooterHeight=10.0f;
    tableview.sectionHeaderHeight = 0.0f;
    //tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    //
    UIView *HeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    HeaderView.backgroundColor = [UIColor grayColor];
    
    [tableview setTableHeaderView:HeaderView];
    
   
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}
//手势响应事件
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.view endEditing:YES];
}

//键盘回弹
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat offset=self.view.frame.size.height-(textField.frame.origin.y+textField.frame.size.height+216+50);
    
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame=self.view.frame;
            frame.origin.y=offset;
            self.view.frame=frame;
        }];
    }
    
    return YES;
    
}
//生成验证码
-(void)MakeCode
{
    changeArray=[[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    for(NSInteger i = 0; i < 4; i++) //得到四个随机字符，取四次，可自己设长度
    {
        NSInteger index = arc4random() % ([changeArray count] - 1);  //得到数组中随机数的下标
        //printf("%ld\n",index);
        getString = [changeArray objectAtIndex:index];  //得到数组中随机数，赋给getString
        //NSLog(@"%@",getString);
        
        changeString = (NSMutableString *)[changeString stringByAppendingString:getString]; //把随机字符加到可变string后面，循环四次后取
        
    }
    yanCode.text=changeString;
    //NSLog(@"%@",changeString);
    //return changeString;
}


#pragma mark --
#pragma mark -tableview delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusecellID = @"useid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusecellID];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusecellID];
    }
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"icon1.png"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                cell.textLabel.text = @"自动投标";
            }
            break;
        case 1:
            if (indexPath.row==0) {
                cell.selected=NO;
                cell.textLabel.text = @"设置(退出当前账号)";
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }else if (indexPath.row==1)
            {
                cell.textLabel.text = @"我要充值";
            
            }else if (indexPath.row==2)
            {
                cell.textLabel.text=@"我要提现";
            }else if (indexPath.row==3)
            {
                cell.textLabel.text = @"充值提现记录";
            }
            break;
        case 2:
            if (indexPath.row==0) {
                cell.selected=NO;
                cell.textLabel.text = @"最近投标";
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }else if (indexPath.row==1)
            {
                cell.textLabel.text = @"待收明细";
                
            }else if (indexPath.row==2)
            {
                cell.textLabel.text=@"我地银行卡";
            }else if (indexPath.row==3)
            {
                cell.textLabel.text = @"债权转让";
            }
            else if (indexPath.row==4)
            {
                cell.textLabel.text = @"以收明细";
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
            
            return 1;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 5;
            break;
            
        default:
            
            return 0;
            break;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"row:%ld",(long)indexPath.row);
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"index row:%d",indexPath.row);
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString *uname = [user objectForKey: @"userName"];
                    NSString *upass = [user objectForKey: @"userPass"];
                    NSLog(@"%@,%@",uname,upass);
                    [user setObject:NULL forKey:@"userName"];
                    [user setObject:NULL forKey:@"userPass"];
                    self.tabBarController.selectedIndex= 0;
                }
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            
            break;
        default:
            break;
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[showView removeFromSuperview];
}
-(void)viewDidDisappear:(BOOL)animated
{

    [super viewDidDisappear:animated];
    [effectview removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uname = [user objectForKey: @"userName"];
    NSString *upass = [user objectForKey: @"userPass"];
    if (uname==NULL||upass==NULL) {
        [self initFirstLoginView];
        NSLog(@"还没有登录，请先登录好吗?");
    }else
    {
        NSLog(@"you have logined in");
        [effectview removeFromSuperview];
    }
    //[self viewDidLoad];
}
////开始编辑输入框的时候，软键盘出现，执行此事件
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"开始输入");
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height-offset);
//    
//    [UIView commitAnimations];
//}
////输入框编辑完成以后，将视图恢复到原始状态
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
