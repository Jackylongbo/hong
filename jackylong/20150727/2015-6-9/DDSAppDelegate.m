//
//  HelloWorldAppDelegate.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "DDSAppDelegate.h"
#import "MyTabBarViewController.h"


@implementation DDSAppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    //监测版本升级
//    _appID = @"";
//    NSError *error = nil;
//    NSString *strURL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",_appID];
//    NSURL *url = [NSURL URLWithString:strURL];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSData *requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableLeaves error:&error];
//    NSArray *resultsArray = [appInfoDic objectForKey:@"results"];
//    NSDictionary *infodic = [resultsArray objectAtIndex:0];
//    _lastVersion = [infodic objectForKey:@"version"];
//    _trackViewUrl = [infodic objectForKey:@"trackViewUrl"];
//    _trackName = [infodic objectForKey:@"trackName"];
//    //获取当前版本号
//    NSDictionary *CurrentInfoDic = [[NSBundle mainBundle]infoDictionary];
//    NSString *currentVersion = [CurrentInfoDic objectForKey:@"CFBundleVersion"];
//    //=======================================
//    double doubleCurrentVersion = [currentVersion doubleValue];
//    double doubleUpdateVersion = [_lastVersion doubleValue];
//    
//    if (doubleCurrentVersion<doubleUpdateVersion) {
//        NSString *titleStr = [NSString stringWithFormat:@"检查更新:%@",_trackName];
//        NSString *message = [NSString stringWithFormat:@"发现新版本(%@)",_lastVersion];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
//        [alert show];
//    }
//    else
//    {
//        
//    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    MyTabBarViewController *tabbar=[[MyTabBarViewController alloc] init];
    self.window.rootViewController=tabbar;
    
    //[NSThread sleepForTimeInterval:3.0f];
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:@"wxd930ea5d5a258f4f"];
    BOOL results = [WeiboSDK registerApp:@"wb204543436852"];
    NSLog(@"注册results = %d",results);
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_trackViewUrl]];
            break;
            
        default:
            break;
    }
    
}

//-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    NSString *msg = [NSString stringWithFormat:@"响应状态:%d\n响应Userinfo数据:%@\n原请求数据:%@",(int)response.statusCode ,response.userInfo,response.requestUserInfo];
//    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
//        UIAlertView *alret = [[UIAlertView alloc] initWithTitle:@"返回结果" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alret show];
//    }
//}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self]||[WeiboSDK handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    return [WXApi handleOpenURL:url delegate:self]||[WeiboSDK handleOpenURL:url delegate:self];

}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)pToken{
    NSLog(@"---Token--%@", pToken);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"userInfo == %@",userInfo);
    NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil, nil];
    
    [alert show];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSLog(@"Regist fail%@",error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    self.window.bounds = CGRectMake(0, 0, 0, 0);
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    [UIView commitAnimations];
    
}
//禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}

@end
