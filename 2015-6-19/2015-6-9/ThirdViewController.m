//
//  ThirdViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "ThirdViewController.h"
#import "MyCommbox.h"

@interface ThirdViewController ()
{
    NSString *getString;//
    NSMutableString *changeString;
    NSArray *changeArray;
    MyCommbox *commbox_id;//证件选择
    MyCommbox *commbox_choose;//赎当或者续当
    NSArray *arr;//用来存放下拉列表的数据
}
@end

@implementation ThirdViewController

@synthesize textField1;//验证码输入框
@synthesize textField2;//典当票号输入
@synthesize textField3;//电话号码输入框
@synthesize textField4;//姓名输入框
@synthesize yanzhengma;//
@synthesize yanCode;//生成验证码
@synthesize btn_confirm;//提交按钮

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
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.view.userInteractionEnabled=YES;
        //自动生成验证码
    changeString=[NSMutableString new];
    yanzhengma=[[UILabel alloc] initWithFrame:CGRectMake(5, self.view.bounds.size.height/12+20, 55, 30)];
    yanzhengma.text=@"验证码";
    yanzhengma.backgroundColor=[UIColor grayColor];
    yanCode=[[UILabel alloc] initWithFrame:CGRectMake(70, self.view.bounds.size.height/12+20, 60, 30)];
    yanCode.backgroundColor=[UIColor orangeColor];
    
    //yanCode.text=[NSString stringWithFormat:@"%@",[self MakeCode]];
    [self MakeCode];
    //生成4个textField
    //输入验证码
    textField1=[[UITextField alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/12+60, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    textField1.delegate=self;
    textField1.placeholder=@"请输入验证码:";
    textField1.borderStyle=UITextBorderStyleRoundedRect;
    //输入典当票号
    textField2=[[UITextField alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/12+self.view.bounds.size.height/12+60, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    textField2.delegate=self;
    textField2.borderStyle=UITextBorderStyleRoundedRect;
    textField2.placeholder=@"请输入典当票号:";
    //输入电话号码
    textField3=[[UITextField alloc] initWithFrame:CGRectMake(0, 3*self.view.bounds.size.height/12+60, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    textField3.delegate=self;
    textField3.placeholder=@"请输入电话号码:";
    textField3.borderStyle=UITextBorderStyleRoundedRect;
    //输入姓名
    textField4=[[UITextField alloc] initWithFrame:CGRectMake(0, 4*self.view.bounds.size.height/12+60, self.view.bounds.size.width, self.view.bounds.size.height/13)];
    textField4.delegate=self;
    textField4.placeholder=@"请输入姓名:";
    textField4.borderStyle=UITextBorderStyleRoundedRect;
    //一个提交按钮
    btn_confirm=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4, 8*self.view.bounds.size.height/12+60, self.view.bounds.size.width/2, self.view.bounds.size.height/13)];
    btn_confirm.backgroundColor=[UIColor orangeColor];
    [btn_confirm setTitle:@"确认提交" forState:UIControlStateNormal];
    btn_confirm.titleLabel.center=btn_confirm.center;
    
    [btn_confirm addTarget:self action:@selector(confirm_clicked:) forControlEvents:UIControlEventTouchUpInside];//为提交按钮添加点击事件
    
    /*证件选择*/
    NSArray *id_arr=[NSArray arrayWithObjects:@"身份证",@"组织机构代码证",@"护照",@"其他证件",@"驾照",@"营业执照", nil];
    commbox_id=[[MyCommbox alloc] initWithFrame:CGRectMake(0, 5*self.view.bounds.size.height/12+60, self.view.bounds.size.width, self.view.bounds.size.height/12)];
    commbox_id.userInteractionEnabled=YES;
    commbox_id.tableArray = id_arr;
    commbox_id.textField.text=[commbox_id.tableArray objectAtIndex:0];
    
    /*续当选择*/
    NSArray *chose_arr=[NSArray arrayWithObjects:@"我想赎当",@"续当原当期",@"续当一个月",@"续当两个月",@"续当三个月", nil];
    commbox_choose=[[MyCommbox alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2+65, self.view.bounds.size.width, self.view.bounds.size.height/12)];
    commbox_choose.textField.placeholder=@"请选择续当或赎当";
    commbox_choose.tableArray=chose_arr;
    commbox_choose.userInteractionEnabled=YES;
    //
    if (commbox_choose.tv.hidden==NO) {
        commbox_id.tv.hidden=YES;
        
    }
    else
    {
        commbox_id.tv.hidden=NO;
    }
    
    //将这些控件添加到视图上
    [self.view addSubview:yanzhengma];
    [self.view addSubview:yanCode];
    [self.view addSubview:textField1];
    [self.view addSubview:textField2];
    [self.view addSubview:textField3];
    [self.view addSubview:textField4];
    [self.view addSubview:btn_confirm];
    [self.view addSubview:commbox_id];
    [self.view addSubview:commbox_choose];
    
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
    
//    if (self.popoverPresentationController) {
//        return;
//    }
//    else
    [self viewDidLoad];
    
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
