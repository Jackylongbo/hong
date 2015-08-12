//
//  ForthViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "ForthViewController.h"
#import "CDPDatePicker.h"
@interface ForthViewController ()<CDPDatePickerDelegate>

{
    CDPDatePicker *datePicker;
}

- (void)dismissKeyboard;

@end

@implementation ForthViewController
{
    UISegmentedControl *segmentControl;
    
    UITextField *date_field;
    UITextField *name_field;
    UITextField *phone_field;
    UITextField *peple_field;
    UITextView *other_field;
    NSString *destDateString;

}
@synthesize scrollVoew;
@synthesize z_moneyimageView;
@synthesize process_imageview;
@synthesize brief_label;
@synthesize appoint_phone;
@synthesize appoint_remind;
@synthesize submit_button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    segmentControl.selectedSegmentIndex=0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor grayColor]];
    //
    scrollVoew=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollVoew setContentSize:CGSizeMake(0, self.view.bounds.size.height+80)];
    UIImage *backgroundImage=[UIImage imageNamed:@"bg.jpg"];
    UIColor *backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    [scrollVoew setBackgroundColor:backgroundColor];
    [self.view addSubview:scrollVoew];
    scrollVoew.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    
    [name_field setDelegate:self];
    [phone_field setDelegate:self];
    [peple_field setDelegate:self];
    //[other_field setDelegate: self];
    
    [scrollVoew endEditing:YES];
    //添加segmentcontrol控件
    NSArray *array=@[@"简介",@"流程",@"预约"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    // segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, 60, self.view.bounds.size.width, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置背景色
    segmentControl.tintColor=[UIColor orangeColor];
    //设置北京颜色
    segmentControl.backgroundColor=[UIColor blackColor];
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [scrollVoew addSubview:segmentControl];
    if (segmentControl.selectedSegmentIndex==0) {
        z_moneyimageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, scrollVoew.bounds.size.width, scrollVoew.bounds.size.height)];
        z_moneyimageView.image=[UIImage imageNamed:@""];
        z_moneyimageView.backgroundColor=[UIColor whiteColor];
        UIImageView *money_image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollVoew.bounds.size.width, z_moneyimageView.bounds.size.height/4+30)];
        money_image.image=[UIImage imageNamed:@"z_money.jpg"];
        [scrollVoew addSubview:money_image];
        brief_label =[[UILabel alloc] initWithFrame:CGRectMake(0, money_image.bounds.size.height, self.view.bounds.size.width, scrollVoew.bounds.size.height-money_image.bounds.size.height)];
        brief_label.backgroundColor=[UIColor brownColor];
        brief_label.textColor=[UIColor whiteColor];
        brief_label.text=@"\t为了感谢新老客户对本公司信任及支持!即日起凡介绍新客户来本公司借款的，按放贷额的1%返佣给介绍人。即借十万返1000元！100元起返，上不封顶!\n\n\t您只需要带客户前来洽谈，并填写确认单、提供账号及证件即可轻松赚钱!\n\n每月5日对账，10日汇款！赶快来试试吧！";
        //brief_label.text=@"hhhhhh";
        brief_label.lineBreakMode=NSLineBreakByWordWrapping;
        brief_label.numberOfLines=0;
        [z_moneyimageView addSubview:money_image];
        [z_moneyimageView addSubview:brief_label];
        [scrollVoew addSubview:z_moneyimageView];
    }
    
    //添加手势
    UITapGestureRecognizer *recognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:recognizer];
}
//最上面的segmentedcontrol视图
-(void)change:(UISegmentedControl *)segmentcontrol
{
    //NSLog(@"segmentControl %ld",segmentControl.selectedSegmentIndex);
    if (segmentcontrol.selectedSegmentIndex==0) {
        [process_imageview removeFromSuperview];
        
        z_moneyimageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, scrollVoew.bounds.size.width, scrollVoew.bounds.size.height)];
        z_moneyimageView.image=[UIImage imageNamed:@""];
        z_moneyimageView.backgroundColor=[UIColor whiteColor];
        UIImageView *money_image=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollVoew.bounds.size.width, z_moneyimageView.bounds.size.height/4+30)];
        money_image.image=[UIImage imageNamed:@"z_money.jpg"];
        [scrollVoew addSubview:money_image];
        brief_label =[[UILabel alloc] initWithFrame:CGRectMake(0, money_image.bounds.size.height, self.view.bounds.size.width, scrollVoew.bounds.size.height-money_image.bounds.size.height)];
        brief_label.backgroundColor=[UIColor brownColor];
        brief_label.textColor=[UIColor whiteColor];
        brief_label.text=@"\t为了感谢新老客户对本公司信任及支持!即日起凡介绍新客户来本公司借款的，按放贷额的1%返佣给介绍人。即借十万返1000元！100元起返，上不封顶!\n\n\t您只需要带客户前来洽谈，并填写确认单、提供账号及证件即可轻松赚钱!\n\n每月5日对账，10日汇款！赶快来试试吧！";
        //brief_label.text=@"hhhhhh";
        brief_label.lineBreakMode=NSLineBreakByWordWrapping;
        brief_label.numberOfLines=0;
        [z_moneyimageView addSubview:money_image];
        [z_moneyimageView addSubview:brief_label];
        [scrollVoew addSubview:z_moneyimageView];
    }
    else if (segmentcontrol.selectedSegmentIndex==1)//选中流程
    {
        [z_moneyimageView removeFromSuperview];
        
        process_imageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, scrollVoew.bounds.size.width, scrollVoew.bounds.size.height-60)];
        process_imageview.image=[UIImage imageNamed:@"z_process.jpg"];
        [scrollVoew addSubview:process_imageview];
    }
    else if (segmentcontrol.selectedSegmentIndex==2)//选中预约
    {
        [z_moneyimageView removeFromSuperview];
        [process_imageview removeFromSuperview];
        appoint_phone=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/7+25, scrollVoew.bounds.size.width-20, scrollVoew.bounds.size.height/14)];
        appoint_phone.text=@"预约电话:000-00000000";
        appoint_phone.font=[UIFont systemFontOfSize:24.0f ];
        appoint_phone.backgroundColor=[UIColor orangeColor];
        appoint_phone.textAlignment=NSTextAlignmentCenter;
        //
        appoint_remind=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/6+50, scrollVoew.bounds.size.width-20, scrollVoew.bounds.size.height/14)];
        appoint_remind.text=@"请输入以下预约内容,我们期待您的光临:";
        appoint_remind.textColor=[UIColor orangeColor];
        appoint_remind.lineBreakMode=NSLineBreakByWordWrapping;
        appoint_remind.numberOfLines=0;
        [scrollVoew addSubview:appoint_remind];
        [scrollVoew addSubview:appoint_phone];
        /*=========================日期=========================*/
        UILabel *_date=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/6+50+scrollVoew.bounds.size.height/14, 80, scrollVoew.bounds.size.height/14)];
        _date.text=@"预约日期:";
        date_field=[[UITextField alloc ] initWithFrame:CGRectMake(85, scrollVoew.bounds.size.height/6+50+scrollVoew.bounds.size.height/14, scrollVoew.bounds.size.width-100, scrollVoew.bounds.size.height/14)];
        UIButton *date_btn=[[UIButton alloc] initWithFrame:date_field.bounds];
        NSDate *appoint_date=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        NSString *locationTime=[dateformatter stringFromDate:appoint_date];
        //NSLog(@"locationTime:%@",locationTime);
        date_field.borderStyle=UITextBorderStyleRoundedRect;
        date_field.text=locationTime;
        //日期按钮点击
        datePicker=[[CDPDatePicker alloc] initWithSelectTitle:nil viewOfDelegate:self.view delegate:self];//
        [date_btn addTarget:self action:@selector(date_btn_clicked:) forControlEvents:UIControlEventTouchUpInside];
        date_btn.userInteractionEnabled=YES;
        [date_field addSubview:date_btn];
        [scrollVoew addSubview: _date];
        [scrollVoew addSubview:date_field];
        
        /*=========================姓名=========================*/
        name_field=[[UITextField alloc] initWithFrame:CGRectMake(85, scrollVoew.bounds.size.height/3+40, scrollVoew.bounds.size.width-100, scrollVoew.bounds.size.height/14)];
        UILabel *_name=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/3+40, 80, scrollVoew.bounds.size.height/14)];
        _name.text=@"您的姓名:";
        name_field.placeholder=@"必填";
        name_field.borderStyle=UITextBorderStyleRoundedRect;
        [scrollVoew addSubview: _name];
        [scrollVoew addSubview:name_field];
        
        /*=========================号码=========================*/
        UILabel *_phone=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/3+45+scrollVoew.bounds.size.height/14, 80, scrollVoew.bounds.size.height/14)];
        _phone.text=@"手机号码:";
        phone_field=[[UITextField alloc] initWithFrame:CGRectMake(85, scrollVoew.bounds.size.height/3+45+scrollVoew.bounds.size.height/14, scrollVoew.bounds.size.width-100, scrollVoew.bounds.size.height/14)];
        phone_field.placeholder=@"必填";
        phone_field.borderStyle=UITextBorderStyleRoundedRect;
        [scrollVoew addSubview:_phone];
        [scrollVoew addSubview:phone_field];
        /*=========================人数=========================*/
        UILabel *_people=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/3+50+scrollVoew.bounds.size.height/7, 80, scrollVoew.bounds.size.height/14)];
        _people.text=@"人     数:";
        _people.textAlignment=NSTextAlignmentCenter;
        peple_field=[[UITextField alloc] initWithFrame:CGRectMake(85, scrollVoew.bounds.size.height/3+50+scrollVoew.bounds.size.height/7, scrollVoew.bounds.size.width-100, scrollVoew.bounds.size.height/14)];
        peple_field.placeholder=@"选填";
        peple_field.borderStyle=UITextBorderStyleRoundedRect;
        [scrollVoew addSubview:peple_field];
        [scrollVoew addSubview:_people];
        
        /*=========================其他描述=========================*/
        UILabel* _otherDes=[[UILabel alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/3+50+3*scrollVoew.bounds.size.height/14, 80, scrollVoew.bounds.size.height/14)];
        _otherDes.text=@"其他描述:";
        other_field=[[UITextView alloc] initWithFrame:CGRectMake(85, scrollVoew.bounds.size.height/3+55+3*scrollVoew.bounds.size.height/14, scrollVoew.bounds.size.width-100, scrollVoew.bounds.size.height/14+100)];
        //other_field.borderStyle=UITextBorderStyleRoundedRect;
        [scrollVoew addSubview:_otherDes];
        [scrollVoew addSubview:other_field];
        
        /*=========================提交=========================*/
        submit_button=[[UIButton alloc] initWithFrame:CGRectMake(10, scrollVoew.bounds.size.height/3+4*scrollVoew.bounds.size.height/7, scrollVoew.bounds.size.width-20, scrollVoew.bounds.size.height/14)];
        submit_button.backgroundColor=[UIColor orangeColor];
        [submit_button setTitle:@"提交" forState:UIControlStateNormal];
        [submit_button addTarget:self action:@selector(submit_clicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollVoew addSubview:submit_button];
    }
}
#pragma mark - 手势
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

#pragma mark - button 提交点击事件
-(void)submit_clicked:(id)sender
{
    NSLog(@"提交");
}
//日期按钮被点击
-(void)date_btn_clicked:(UIButton*)sender
{
    [datePicker pushDatePicker];
}
//回调，字符串可自行进行截取
-(void)CDPDatePickerDidConfirm:(NSString *)confirmString
{
    date_field.text=confirmString;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [datePicker popDatePicker];
    [name_field resignFirstResponder];
    [phone_field resignFirstResponder];
    [peple_field resignFirstResponder];
    [other_field resignFirstResponder];
}
-(void)dateChanged:(id)sender
{
    
}
#pragma mark - textfield 代理方法实现
//开始编辑输入框的时候，软键盘出现，执行此事件
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"开始输入");
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
          //上移n个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-130,width,height);
    self.view.frame=rect;
    
    [UIView commitAnimations];
    return YES;
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollVoew.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    
    [self viewDidLoad];
    
}
@end
