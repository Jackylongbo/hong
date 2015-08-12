//
//  ValuatingViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-12.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
{
    UIActivityIndicatorView *activity;
    UIView *view;
}
@end

@implementation AboutUsViewController

@synthesize aboutUsWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    aboutUsWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backup)];
    aboutUsWebView.delegate = self;
    [aboutUsWebView setScalesPageToFit:YES];
    //活动指示器
    activity =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    activity.center=self.view.center;
    [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];

    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.4];

    
    [self.view addSubview:aboutUsWebView];
    [self GetRequestFromWeb];
}

#pragma mark ===
#pragma  mark LeftBarButtonItem sender action
-(void)backup
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---
#pragma mark ===webview delegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [view addSubview: activity];
    [self.view addSubview:view];
    [activity startAnimating];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
    [view removeFromSuperview];
}

-(void)GetRequestFromWeb
{
    NSString *strUrl = @"http://www.dianjinsuo.com/capitalEnsure.do?typeId=18";
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [aboutUsWebView loadRequest:request];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
