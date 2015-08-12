//
//  FirstViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "GetCheapViewController.h"
#import "MyTableViewCell.h"
#import "MyButton.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize mytableview;
@synthesize m_imageView;
@synthesize m_imageview1;
@synthesize m_gesture;
@synthesize pan_gesture;
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
    //if( ([[[UIDevicecurrentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
   // }
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //self.view.userInteractionEnabled=YES;
    [self.view setBackgroundColor:[UIColor grayColor]];
    m_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    m_imageView.image=[UIImage imageNamed:@"tp1.jpg"];
    m_imageView.userInteractionEnabled=YES;
    mytableview.delegate=self;
    mytableview.dataSource=self;
    mytableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    mytableview.allowsSelection=NO;
    
    m_imageview1=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    m_imageview1.image= [UIImage imageNamed:@"bg.jpg"];
    m_imageview1.userInteractionEnabled=YES;
    //
    [self.navigationItem setTitle:@"恒通典当行"];

    MyButton *button_1=[[MyButton alloc] initWithFrame:CGRectMake(0, 40, m_imageview1.bounds.size.width/5, m_imageview1.bounds.size.height/6+20)];
    button_1.userInteractionEnabled=YES;
    [button_1 setTitle:@"借钱" forState:UIControlStateNormal];
    [button_1 setImage:[UIImage imageNamed:@"button_1.png"] forState:UIControlStateNormal];
    //[button_1 setImage:[UIImage imageNamed:@"tabbar_discover_selected.png"] forState:UIControlStateHighlighted];
    button_1.tag=1;
    //创建一个还钱的按钮
    MyButton *button_2=[[MyButton alloc] initWithFrame:CGRectMake(0+m_imageview1.bounds.size.width/4, 40, m_imageview1.bounds.size.width/5, m_imageview1.bounds.size.height/6+20)];
    [button_2 setTitle:@"还钱" forState:UIControlStateNormal];
    button_2.userInteractionEnabled=YES;
    [button_2 setImage:[UIImage imageNamed:@"button_2.png"] forState:UIControlStateNormal];
    //[button_2 setImage:[UIImage imageNamed:@"tabbar_profile_selected.png"] forState:UIControlStateHighlighted];
    button_2.tag=2;
    //创建一个赚钱的按钮
    MyButton *button_3=[[MyButton alloc] initWithFrame:CGRectMake(0+m_imageview1.bounds.size.width*2/4, 40, m_imageview1.bounds.size.width/5, m_imageview1.bounds.size.height/6+20)];
    [button_3 setTitle:@"赚钱" forState:UIControlStateNormal];
    [button_3 setImage:[UIImage imageNamed:@"button_3.png"] forState:UIControlStateNormal];
    //[button_3 setImage:[UIImage imageNamed:@"tabbar_message_center_selected.png"] forState:UIControlStateHighlighted];
    button_3.userInteractionEnabled=YES;
    button_3.tag=3;
    //创建一个捡便宜的按钮
    MyButton *button_4=[[MyButton alloc] initWithFrame:CGRectMake(0+m_imageview1.bounds.size.width*3/4,40, m_imageview1.bounds.size.width/5, m_imageview1.bounds.size.height/6+20)];
    [button_4 setTitle:@"捡便宜" forState:UIControlStateNormal];
    [button_4 setImage:[UIImage imageNamed:@"button_4.png"] forState:UIControlStateNormal];
    //[button_4 setImage:[UIImage imageNamed:@"tabbar_more_selected.png"] forState:UIControlStateHighlighted];
    button_4.tag=4;
    [m_imageview1 addSubview:button_1];
    
    [m_imageview1 addSubview:button_2];
   
    [m_imageview1 addSubview:button_3];
   
    [m_imageview1 addSubview:button_4];
    //为每个按钮添加点击事件
    [button_1 addTarget:self action:@selector(btn1_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [button_2 addTarget:self action:@selector(btn2_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [button_3 addTarget:self action:@selector(btn3_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [button_4 addTarget:self action:@selector(btn4_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //[self tapPan];
    [self.view addSubview:m_imageView];
    [self.view addSubview:m_imageview1];
    //[self.view addSubview:mytableview];
}
-(void)tapSwipe
{
     m_gesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(my_gesture:)];
    m_gesture.delegate=self;
    [m_gesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [m_gesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [m_imageView addGestureRecognizer:m_gesture];
}
//滑动手势
-(void)tapPan
{
    pan_gesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan_gesture.delegate=self;
    [self.view addGestureRecognizer:pan_gesture];
}
-(void)panGesture:(UIPanGestureRecognizer*)rec
{
    NSLog(@"xxoo---xxoo---xxoo");
    CGPoint point = [rec translationInView:self.m_imageView];
    NSLog(@"%f,%f",point.x,point.y);
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.m_imageView];
}

-(void)my_gesture:(UISwipeGestureRecognizer*)sender
{
    //下滑手势，页面跟着下滑
    //[self.m_imageView resignFirstResponder];
    UISwipeGestureRecognizerDirection direct=[(UISwipeGestureRecognizer*)sender direction];
    switch (direct) {
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"up");
            [self.m_imageView resignFirstResponder];
            break;
            case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"down");
            [self.m_imageView resignFirstResponder];
            break;
        default:
            break;
    }
}


#pragma mark -buttonClickedEvent
-(void)btn1_clicked:(UIButton*)sender//进入借钱页面
{
    SecondViewController *second_new=[SecondViewController new];
    UIButton* btn=(UIButton*)[self.view viewWithTag:sender.tag];
    second_new.title=btn.titleLabel.text;
    [self.navigationController pushViewController:second_new animated:NO];
    
}
//进入还钱页面
-(void)btn2_clicked:(UIButton*)sender
{
    
    ThirdViewController *third_new=[ThirdViewController new];
    UIButton* btn=(UIButton*)[self.view viewWithTag:sender.tag];
    third_new.title=btn.titleLabel.text;
    [self.navigationController pushViewController:third_new animated:NO];
}
//进入赚钱页面
-(void)btn3_clicked:(UIButton*)sender
{
    ForthViewController *forth_new=[ForthViewController new];
    UIButton* btn=(UIButton*)[self.view viewWithTag:sender.tag];
    forth_new.title=btn.titleLabel.text;
    [self.navigationController pushViewController:forth_new animated:NO];
    
}
//进入捡便宜页面
-(void)btn4_clicked:(UIButton*)sender
{
    GetCheapViewController *getCheap_new=[GetCheapViewController new];
    UIButton* btn=(UIButton*)[self.view viewWithTag:sender.tag];
    getCheap_new.title=btn.titleLabel.text;
    [self.navigationController pushViewController:getCheap_new animated:NO];

}

#pragma mark -tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellid=@"cellId";
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil)
    {
        cell=[[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid] ;
    }
//    if (indexPath.row==1) {
//        MyButton *giveMoney=[[MyButton alloc] init];
//        [giveMoney setFrame:CGRectMake(10, 20,cell.bounds.size.width/4, cell.bounds.size.height)];
//        giveMoney.tag=1;
//        giveMoney.imageView.image=[UIImage imageNamed:@""];
//        giveMoney.titleLabel.text=@"借钱";
//        giveMoney.userInteractionEnabled=YES;
//        [cell.imageView addSubview:giveMoney];
    
  //  }
    
    
   // [self FreshData:indexPath.row Cell:cell];
    return cell;
}
-(void)FreshData:(NSInteger)index Cell:(UITableViewCell*)cell
{
    if (index==0) {
        UIImageView *imagview=[[UIImageView alloc] init];
        imagview.center=cell.center;
        imagview=m_imageView;
        cell.selected=NO;
        [cell.contentView addSubview:imagview];
    }
    if (index==1) {
        for (int i=0; i<4; i++) {
            MyButton *btn=[[MyButton alloc] initWithFrame:CGRectMake(i*(cell.bounds.size.width/4)+10, 5, cell.bounds.size.width/4, cell.bounds.size.height)];
            btn.titleLabel.text=@"bbbbb";
            btn.tag=i;
            btn.backgroundColor=[UIColor grayColor];
            btn.alpha=0.5;
            btn.imageView.image=[UIImage imageNamed:@""];
            btn.userInteractionEnabled=YES;
            cell.backgroundColor=[UIColor yellowColor];
            [cell.contentView addSubview:btn];
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.window.bounds.size.width/2+26;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewDidAppear:(BOOL)animated{
//    
//    [self viewDidLoad];
//    
//}
@end
