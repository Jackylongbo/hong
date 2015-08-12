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
    
    UIView *showView;
    BOOL ConfirmOk;//验证是否正确,用来判断登录是否成功
    
}
@end

@implementation ThirdViewController


@synthesize yanzhengma;//
@synthesize yanCode;//生成验证码
@synthesize btn_confirm;//登录提交按钮

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
    showView = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
    showView.backgroundColor = [UIColor clearColor];
    showView.alpha = 0.5;
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 120)];
    centerView.center = showView.center;
    centerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *warning = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 40)];
    warning.text = @"查看资料前请先登录";
    warning.textAlignment = NSTextAlignmentCenter;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 60, 180, 40)];
    [btn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    
    [centerView addSubview:warning];
    [centerView addSubview:btn];
    centerView.alpha = 0.7;
    
    [showView addSubview:centerView];
    [self.view addSubview: showView];
}

-(void)btnClicked:(UIButton*)sender
{
    NSLog(@"dddddddd");
    loginOrRegisterViewController *login= [[loginOrRegisterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    [self presentModalViewController:nav animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.view.userInteractionEnabled=YES;
    //从本地读取用户信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *username = [user objectForKey:@"userName"];
    NSString *userpass = [user objectForKey:@"userPass"];
    
    
    NSLog(@"%@",username);
    NSLog(@"%@",userpass);
    
    if (username==NULL|| userpass==NULL) {
        [self initFirstLoginView];
    }
    else
    {
        
    }
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}
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
//提交事件
-(void)confirm_clicked:(id)sender
{
    NSLog(@"开始提交");//将填好的信息提交给服务器，存放到服务器的数据库中
}
//自动刷新页面数据的函数
- (void)viewDidAppear:(BOOL)animated{
    if (!self) {
        [self viewDidLoad];
    }
    
    
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
