//
//  MoreViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MoreViewController.h"
#import "DDSAppDelegate.h"
#import "BusinessIntrodutionViewController.h"
#import "EnvironDisplayViewController.h"
#import "FirstViewController.h"
#import "MyTabBarViewController.h"
#import "MessageViewController.h"
#import <Social/Social.h>
#import "ForthViewController.h"
#import "AboutUsViewController.h"

@interface MoreViewController ()
{
    NSMutableArray *titleArray;//tableview标题分组,下面将一个tableview分成3个组
    NSMutableArray *dataArray1;
    NSMutableArray *dataArray2;
    NSMutableArray *dataArray3;
    CGSize m_size;
    
    UIScrollView *m_scrollView;
    UIPageControl *pageCtrl;
    
    //
    UIImage *shareImage;
    NSString *shareText;
    
}
@end

@implementation MoreViewController
@synthesize  more_tableview;
@synthesize imageArray;//店面图片介绍
@synthesize titleArr;//图片标题

#pragma mark --
#pragma mark -微信请求和回应
-(void)onReq:(BaseReq *)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }


}
-(void)onResp:(BaseResp *)resp
{

    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg;//= [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        if (resp.errCode==0) {
            strMsg = @"成功";
        }
        else if(resp.errCode==-2)
        {
            strMsg = @"失败";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark----
#pragma mark ----视图加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    m_size=self.view.bounds.size;

    
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen ].bounds];
    UIImage *backgroundImage=[UIImage imageNamed:@"bg.jpg"];
    UIColor *backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    [self.view setBackgroundColor:backgroundColor];
    [self.navigationItem setTitle:@"更多内容"];
    
    more_tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStyleGrouped];
    more_tableview.delegate=self;
    more_tableview.dataSource=self;
    more_tableview.sectionFooterHeight=2.0f;
    
   //从文件中读取图片信息和标题信息
    NSString *path=[[NSBundle mainBundle] pathForResource:@"environmentDisplay" ofType:@"plist"];
    NSDictionary *ditionary=[NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* image=[ditionary objectForKey:@"image"];
   // NSLog(@"%@",image);
    imageArray =[[NSMutableArray alloc] init];
    for (NSMutableString *str in image)
    {
       NSMutableString*string= [NSMutableString stringWithFormat:@"%@.jpg",str];
       [imageArray addObject:string];
       // NSLog(@"%@",str);
    }
    //NSLog(@"%@",imageArray);
    dataArray1 =[[NSMutableArray alloc] initWithArray: [ditionary objectForKey:@"data1"]];
    dataArray2=[[NSMutableArray alloc] initWithArray:[ditionary objectForKey:@"data2"]];
    dataArray3=[[NSMutableArray alloc] initWithArray: [ditionary objectForKey:@"data3"]];
    titleArray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    [self.view addSubview:more_tableview];
    
    
    shareImage = [UIImage imageNamed:@"MyLaunchImage.png"];
    shareText = @"Hello world";
}
//

#pragma mark - tableView 代理方法实现
//指定每个分区中有多少行，默认为1
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return  [dataArray1 count];//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            break;
        case 1:
            return  [dataArray2 count];
            break;
        case 2:
            return [dataArray3 count];
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"moreCellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor=[UIColor orangeColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.separatorInset = UIEdgeInse;
    cell.imageView.image = [UIImage imageNamed:@"icon1.png"];
    switch (indexPath.section) {
        case 0:
            [[cell textLabel] setText:[dataArray1 objectAtIndex:indexPath.row]];
            break;
        case 1:
            [[cell textLabel] setText:[dataArray2 objectAtIndex:indexPath.row]];
            
            break;
        case 2:
            [[cell textLabel] setText:[dataArray3 objectAtIndex:indexPath.row]];
            if (indexPath.row==0) {
//                NSLog(@"推送.........");
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                UISwitch *swith=[[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-60, 5, 40, 25)];
                NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                swith.tag = 20000;
                swith.on = [userdefault boolForKey:@"tuisongshezhi"];
                [swith addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
                cell.accessoryType=UITableViewCellAccessoryNone;
                [cell addSubview:swith];
                
            }
            break;
        default:
            [[cell textLabel] setText:@"Unknown"];
            break;
    }
    return cell;
}

//switch绑定的事件
-(void)switchValueChanged:(UISwitch*)sender
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setBool:sender.on forKey:@"tuisongshezhi"];
    [userdefault synchronize];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/14;
}
//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [titleArray count];//返回标题数组中元素的个数来确定分区的个数
    
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
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 8.0 ;
}
//选中每一行的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先判断是在哪个分组，然后判断是哪一行
    switch (indexPath.section) {
        case 0:
            //NSLog(@"第一组");
            switch (indexPath.row) {
                case 0:
                    NSLog(@"业务介绍");
                    [self BusinessIntrodution];
                    break;
                case 1:
                    NSLog(@"典当流程");
                    [self PawnProcess];
                    break;
                case 2:
                    NSLog(@"优惠活动");
                    [self Preferentialactivity];
                    break;
                case 3:
                    NSLog(@"环境展示");
                    [self Environmentaldisplay];
                    break;
                case 4:
                    NSLog(@"关于我们");
                    
                    [self AboutUs];
                    break;
                case 5:
                    NSLog(@"地址导航");
                    [self Addressnavigation];
                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                    NSLog(@"短信分享给好友");
                    [self MessageSharedToFriends];
                    break;
                case 2:
                    NSLog(@"分享到新浪微博");
                    [self shareToSinaWeibo];
                    break;
                case 3:
                    NSLog(@"分享到腾讯微博");
                    [self shareToTencentWeibo];
                    break;
                case 0:
                {
                    NSLog(@"分享到微信");
                    [self shareToWeixin];
                }
                    break;
                default:
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"推送设置");
                    [self PushMessageTo];
                    break;
                case 1:
                    NSLog(@"关于应用");
                    [self AboutApp];
                    break;
                case 2:
                {
                    NSLog(@"退出应用");
                    DDSAppDelegate *exit=[DDSAppDelegate new];
                    [exit exitApplication];
                }
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }

}


#pragma mark - 业务介绍
-(void)BusinessIntrodution
{
    //[more_tableview removeFromSuperview];
    BusinessIntrodutionViewController *business=[BusinessIntrodutionViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:business];
    [nav setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:nav animated:YES completion:nil];
    //网络请求 进入官网首页
}
#pragma mark - 典当流程
-(void)PawnProcess
{
    //[self.navigationItem setTitle:[dataArray1 objectAtIndex:1]];
}
#pragma mark - 优惠活动
-(void)Preferentialactivity
{
    //[self.navigationItem setTitle:[dataArray1 objectAtIndex:2]];

}

#pragma mark - 环境展示
-(void)Environmentaldisplay
{
    //[self.navigationItem setTitle:[dataArray1 objectAtIndex:3]];
    EnvironDisplayViewController *environDisplay=[EnvironDisplayViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:environDisplay];
    [self presentViewController:nav animated:YES completion:nil];
}
-(UIScrollView*)create_scrollView
{
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height)];
    scrollview.backgroundColor=[UIColor blackColor];
    //
    scrollview.contentSize=CGSizeMake(m_size.width*[imageArray count], 0);
    scrollview.pagingEnabled=YES;//过屏幕一半自动跳转
    scrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动指示符
    scrollview.delegate=self;//滑动完毕一个width以后需要pageControl跟进，所以需要实现这个方法(scrollViewDidScroll)
    
    for (int i=0; i<[imageArray count]; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(m_size.width*i, 0, m_size.width, m_size.height)];
        NSString *imageName=[imageArray objectAtIndex:i];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.clipsToBounds=YES;
        
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.image=[UIImage imageNamed:imageName];
        [scrollview addSubview:imageView];
    }
    
    return scrollview;
}
-(UIPageControl*)create_pageControl
{
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(85, m_size.height*0.90, 150, 30)];
    pageControl.numberOfPages=[imageArray count];
    
    UIImage *checkedPointImage=[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:checkedPointImage];
    
    UIImage *pointImage=[UIImage imageNamed:@"new_feature_pagecontrol_point.png"];
    pageControl.pageIndicatorTintColor=[UIColor colorWithPatternImage:pointImage];
    
    return pageControl;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    more_tableview.contentSize=CGSizeMake(0, self.view.bounds.size.height+60);
    pageCtrl.currentPage=scrollView.contentOffset.x/m_size.width;
}
#pragma mark -关于我们
-(void)AboutUs
{
    //[self.navigationItem setTitle:[dataArray1 objectAtIndex:4]];
    AboutUsViewController *aboutUs =[[AboutUsViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:aboutUs];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - 地址导航
-(void)Addressnavigation
{
    //[self.navigationItem setTitle:[dataArray1 objectAtIndex:5]];
}
/*==========================================================*/
//短信分享给好友
-(void)MessageSharedToFriends
{
    MessageViewController *messageView=[MessageViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:messageView];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *msg = [NSString stringWithFormat:@"响应状态:%d\n响应Userinfo数据:%@\n原请求数据:%@",(int)response.statusCode ,response.userInfo,response.requestUserInfo];
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        UIAlertView *alret = [[UIAlertView alloc] initWithTitle:@"返回结果" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alret show];
    }
}

-(WBMessageObject*)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = @"这个是测试";
    
    WBImageObject *image = [WBImageObject object];
    
    NSString *strurl = @"";//图片的URL
    NSURL *Url = [NSURL URLWithString:strurl];
    image.imageData = [NSData dataWithContentsOfURL:Url];
    message.imageObject = image;
    return message;
}

//分享到新浪微博
-(void)shareToSinaWeibo
{
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
//    request.userInfo = @{};
//    
//    BOOL results = [WeiboSDK sendRequest:request];
//    NSLog(@"发送请求results = %d",results);
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        NSLog(@"successfully to send");
        SLComposeViewController *socailView=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        SLComposeViewControllerCompletionHandler my_block=^(SLComposeViewControllerResult result)
        {
            if(result ==SLComposeViewControllerResultCancelled)
            {
                //是取消
                NSLog(@"分享取消");
            }
            else if(result ==SLComposeViewControllerResultDone)
            {
                NSLog(@"分享成功");
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"分享" message:@"分享成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
            }
            else
            {
                NSLog(@"分享失败");
            }
        };
        socailView.completionHandler = my_block;
        UIImage *image = shareImage;
        //        UIImage *image = [UIImage imageWithContentsOfFile:_postImage.text];
        NSURL *url = [NSURL URLWithString:@"www.sina.weibo.com/"];
        [socailView setInitialText:shareText];
        [socailView addImage:image];
        [socailView addURL:url];
        
        [self presentViewController:socailView animated:YES completion:nil];
    }
    else
    {
        NSLog(@"failed to do that");
    }
}
//分享到腾讯微博
-(void)shareToTencentWeibo
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTencentWeibo])
    {
        NSLog(@"可以分享到腾讯微博");
        SLComposeViewController *tencentView=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
        SLComposeViewControllerCompletionHandler Tencent_block=^(SLComposeViewControllerResult result)
        {
            if(result ==SLComposeViewControllerResultCancelled)
            {
                //是取消
                NSLog(@"分享取消");
            }
            else if(result ==SLComposeViewControllerResultDone)
            {
                NSLog(@"分享成功");
            }
            else
            {
                NSLog(@"分享失败");
            }
        };
        tencentView.completionHandler=Tencent_block;
        UIImage *image = shareImage;
        //        UIImage *image = [UIImage imageWithContentsOfFile:_postImage.text];
        NSURL *url = [NSURL URLWithString:@"www.baidu.com/"];
        [tencentView setInitialText:shareText];
        [tencentView addImage:image];
        [tencentView addURL:url];
        
        [self presentViewController:tencentView animated:YES completion:nil];
    }
    else
    {
        NSLog(@"不能分享到腾讯微博");
    }
}
//分享到微信
-(void)shareToWeixin
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"微信分享" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"到好友",@"到朋友圈", nil];
    [alert show];

//    GetMessageFromWXResp *resp = [[GetMessageFromWXResp alloc] init];
//    resp.text= @"天气真好";
//    resp.bText = YES;
//    
//    [WXApi sendResp:resp];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            NSLog(@"分享给好友");
            _scene = WXSceneSession;
            break;
        case 2:
            NSLog(@"分享到朋友圈");
            _scene = WXSceneTimeline;
            break;
        default:
            break;
    }
    if (buttonIndex==0) {
        
    }else
    {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.text = @"今天天气真好,爽歪歪";
        req.bText = YES;
        req.scene = _scene;
        [WXApi sendReq:req];
    }
}

/*==========================================================*/
//推送设置
-(void)PushMessageTo
{
    NSLog(@"消息推送设置");
    UISwitch *swith = (UISwitch*)[self.view viewWithTag:20000];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    swith.on = [user boolForKey:@"tuisongshezhi"];
    if (swith.on)
    {
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            //IOS8
            //创建UIUserNotificationSettings，并设置消息的显示类类型
            UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
            
            [application registerUserNotificationSettings:notiSettings];
            //UIApplication *app = [UIApplication sharedApplication];
            // 应用程序右上角数字
            //app.applicationIconBadgeNumber = 0;
        } else{ // ios7
            [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
        }
    }
    
}
//关于应用
-(void)AboutApp
{
    ForthViewController *forthView = [[ForthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:forthView];
    [nav setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:nav animated:YES completion:nil];

}
//退出应用

/*==========================================================*/
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//
//{
//    
//    // Return YES for supported orientations
//    
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//刷新页面的数据
- (void)viewDidAppear:(BOOL)animated{
    
    if ([self isBeingDismissed]) {
        return;
    }
    [self viewDidLoad];
    
}
@end
