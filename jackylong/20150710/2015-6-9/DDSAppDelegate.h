//
//  HelloWorldAppDelegate.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "WeiboSDK.h"


@interface DDSAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate,UIAlertViewDelegate>
{
    NSString *_lastVersion;//最新版本号Å
    NSString *_trackName;//应用名称
    NSString *_trackViewUrl;//
    NSString *_appID;//应用ID
}

@property (strong, nonatomic) UIWindow *window;

-(void)exitApplication;

@end
