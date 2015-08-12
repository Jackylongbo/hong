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
@synthesize appoint_view;

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backup)];
    //
    scrollVoew=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height)];
    [scrollVoew setContentSize:CGSizeMake(0, self.view.bounds.size.height+80)];
    UIImage *backgroundImage=[UIImage imageNamed:@"bg.jpg"];
    UIColor *backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    [scrollVoew setBackgroundColor:backgroundColor];
    [self.view addSubview:scrollVoew];
    scrollVoew.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    
    [scrollVoew endEditing:YES];
    //添加segmentcontrol控件
    NSArray *array=@[@"简介",@"流程"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
    // segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, 0, self.view.bounds.size.width, 40);
    //默认选择
    segmentControl.selectedSegmentIndex=0;
    //设置背景色
    segmentControl.tintColor=[UIColor orangeColor];
    //设置北京颜色
    segmentControl.backgroundColor=[UIColor blackColor];
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [scrollVoew addSubview:segmentControl];//添加segmentedcontrol
    //添加手势
    UITapGestureRecognizer *recognizer =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:recognizer];
}

-(void)backup
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
//最上面的segmentedcontrol视图
-(void)change:(UISegmentedControl *)segmentcontrol
{
    //NSLog(@"segmentControl %ld",segmentControl.selectedSegmentIndex);
    if (segmentcontrol.selectedSegmentIndex==0) {
        
    }
    else if (segmentcontrol.selectedSegmentIndex==1)//选中流程
    {
    
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
