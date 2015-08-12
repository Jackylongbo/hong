//
//  BusinessIntrodutionViewController.m
//  融资典当
//
//  Created by 典盟金融 on 15-6-19.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "BusinessIntrodutionViewController.h"


@interface BusinessIntrodutionViewController ()<UIWebViewDelegate>
{
    UIWebView *Datatext;
    NSURLSession *session;
    UIActivityIndicatorView *activity;
    UIView *backgroundView;
}

@end

@implementation BusinessIntrodutionViewController
@synthesize datas;
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self=[super initWithStyle:style];
    if (self) {
        self.navigationItem.title=@"业务介绍";
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(getBack)];
    Datatext=[[UIWebView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-100)];
    Datatext.delegate = self;
    [Datatext setScalesPageToFit:YES];
    //活动指示器
    activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    activity.center=self.view.center;
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    
    //Datatext.textColor=[UIColor redColor];
    //Datatext.editable=NO;
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [backgroundView setBackgroundColor:[UIColor blackColor]];
    [backgroundView setAlpha:0.4];

    [self.view addSubview:Datatext];
    
    [self GetRequest];
}
-(void)getBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ====
#pragma mark WebVeiw delegate method
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载网页");
    
    [backgroundView addSubview:activity];
    [self.view addSubview:backgroundView];
    [activity startAnimating];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
    [backgroundView removeFromSuperview];
    NSLog(@"加载网页完毕");
}

#pragma mark - 网络请求
-(void)GetRequest
{
    
    //NSString *str=@"https://bookapi.bignerdranch.com/courses.json";
    NSString *baidu=@"http://www.dianjinsuo.com/finance.do?m=1";
    NSURL *urlstring=[NSURL URLWithString:baidu];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:urlstring cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"]; 
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response,NSData* data,NSError *geterror)
     {
         if ([data length]>0&&geterror==nil&&[(NSHTTPURLResponse*)response statusCode]==200) {
             //NSString *str1=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             //Datatext=str;
             [Datatext loadRequest:request];
             
         }
         else if([data length]==0||geterror!=nil)
         {
             NSLog(@"请求失败");
             NSLog(@"%lu",(unsigned long)[data length]);
             NSLog(@"%@",geterror);
         }
     }];
   
    
}
#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [datas appendData:data];
    
    //NSString *stringData=[[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
    
    //Datatext.text=stringData;
}
-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    NSLog(@"%@",[error localizedDescription]);
}
- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成…");
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [[challenge sender]useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge: challenge];
    }
}
//https认证要求
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred=[NSURLCredential credentialWithUser:@"BigNerdRanch" password:@"AchieveNerdvana" persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
    
}

//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([self isBeingDismissed]) {
        return;
    }
    [self viewDidLoad];
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