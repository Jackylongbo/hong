//
//  loginOrRegisterViewController.m
//  融资典当
//
//  Created by 典盟金融 on 15-7-8.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "loginOrRegisterViewController.h"
#import "DDSAppDelegate.h"

#import "ChangePWViewController.h"

@interface loginOrRegisterViewController ()
{
    CGSize selfViewSize;

}
@end

@implementation loginOrRegisterViewController

@synthesize NameLabel;
@synthesize nameField;
@synthesize PassLabel;
@synthesize passField;
@synthesize loginBtn;
@synthesize freeRegister;
@synthesize ForgetPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dissmissView)];
    self.navigationItem.title = @"用户登录";
    
    selfViewSize = self.view.bounds.size;
    /////
    NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, selfViewSize.height/6.0f, 60, 30)];
    NameLabel.text=@"用户名";
    
    nameField =[[UITextField alloc] initWithFrame:CGRectMake(85, selfViewSize.height/6.0f, selfViewSize.width-105, 30)];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.placeholder = @"手机/邮箱";
    
    PassLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, selfViewSize.height/6.0f+35, 60, 30)];
    PassLabel.text = @"密    码";
    passField =[[UITextField alloc] initWithFrame:CGRectMake(85, selfViewSize.height/6.0f+35, selfViewSize.width-105, 30)];
    passField.borderStyle = UITextBorderStyleRoundedRect;
    passField.placeholder = @"输入密码(6-16)";
    passField.secureTextEntry = YES;
    
    ForgetPass = [[UIButton alloc] initWithFrame:CGRectMake(200, selfViewSize.height/3-20, 100, 30)];
    [ForgetPass setTitle:@"忘记密码?" forState:UIControlStateNormal];
    ForgetPass.tintColor = [UIColor greenColor];
    ForgetPass.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    //ForgetPass.titleLabel.textColor=[UIColor redColor];
    ForgetPass.alpha=0.5;
    ForgetPass.backgroundColor = [UIColor lightGrayColor];
    [ForgetPass addTarget:self action:@selector(forgetPassBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ForgetPass];
    
    [self.view addSubview:NameLabel];
    [self.view addSubview:nameField];
    [self.view addSubview:PassLabel];
    [self.view addSubview:passField];
    
    CGFloat Ypoint = selfViewSize.height/3.0f+80;
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, Ypoint, selfViewSize.width-40, 40)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [loginBtn addTarget:self action:@selector(loginBtn_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    freeRegister =[[UIButton alloc] initWithFrame:CGRectMake(20, Ypoint+60, selfViewSize.width-40, 40)];
    [freeRegister setTitle:@"免费注册" forState:UIControlStateNormal];
    freeRegister.backgroundColor =[UIColor lightGrayColor];
    freeRegister.titleLabel.textColor = [UIColor blueColor];
    [freeRegister addTarget:self action:@selector(freeRegister_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:freeRegister];
    
    //为页面添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
//取消按钮点击
-(void)dissmissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//忘记密码点击事件
-(void)forgetPassBtnAction:(UIButton*)sender
{

    NSLog(@"忘记密码了吗?");
    //进入修改密码页面
    ChangePWViewController *changePw = [ChangePWViewController new];
    [self.navigationController pushViewController:changePw animated:NO];

}
//添加手势的事件
-(void)dismissKeyboard
{
    [self.view endEditing:YES];

}

//登录按钮被点击
-(void)loginBtn_clicked:(UIButton*)sender
{
    NSLog(@"登录按钮被点击");
    //将用户登录信息保存到本地
    if (nameField.text==nil || passField.text==nil || [nameField.text  isEqual:@""] || [passField.text isEqual:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if([nameField.text length]<12&&[passField.text length]<=16)
    {
        NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:nameField.text forKey:@"userName"];
        [userdefault setObject:passField.text forKey:@"userPass"];
        [userdefault synchronize];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //DDSAppDelegate *appdelegate = (DDSAppDelegate*)[[UIApplication sharedApplication] delegate];
    
}

//注册按钮被点击
-(void)freeRegister_clicked:(UIButton*)sender
{
    NSLog(@"注册按钮被点击");

}

-(void)viewDidAppear:(BOOL)animated
{


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