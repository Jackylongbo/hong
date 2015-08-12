//
//  mapViewController.h
//  融资典当
//
//  Created by 典盟金融 on 15-6-23.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>



#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)//用来获取手机的系统，判断系统是多少


@interface mapViewController : UIViewController<MKMapViewDelegate>

@property (strong,nonatomic)UIView *mainView;
@end
