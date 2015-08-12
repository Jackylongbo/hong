//
//  mapViewController.m
//  融资典当
//
//  Created by 典盟金融 on 15-6-23.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "mapViewController.h"

@interface mapViewController ()

@end

@implementation mapViewController
@synthesize mapview;
@synthesize mainView;
@synthesize _mapManager;


-(void)loadView
{
//    //地图管理器
//    _mapManager=[[BMKMapManager alloc] init];
//    BOOL ret=[_mapManager start:@"QvDqAG6l90KiFG0RR4nDsY52" generalDelegate:nil];
//    if (ret==0) {
//        NSLog(@"manager start failed");
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(getback)];
//    mainView =[[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60)];
//    mapview=[[BMKMapView alloc] initWithFrame:mainView.bounds];
//    //mapview.delegate=self;
//    [mainView addSubview:mapview];
//    
//    
//    
//    
//    [self.mapview setShowsUserLocation:YES];
//    
//    [self.view addSubview:mainView];
    //[self Getmap];
}
//
-(void)getback
{
    [self.navigationController popViewControllerAnimated:YES];
}
//进入地图导航
-(void)Getmap
{
//    CLLocationCoordinate2D startCoor=self.mapview.userLocation.location.coordinate;
//    CLLocationCoordinate2D endCoor=CLLocationCoordinate2DMake(startCoor.latitude+0.01, startCoor.longitude+0.01);
    
    //if (SYSTEM_VERSION_LESS_THAN(@"5.0"))
    //{ // ios5以下，调用google map
//        
//        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude];
//        //@"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude
//        urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *aURL = [NSURL URLWithString:urlString];
//        [[UIApplication sharedApplication] openURL:aURL];
    //}
//    else
//    { // 直接调用ios自己带的apple map
//        
//        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
//        toLocation.name = @"to name";
//        
//        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
//                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
//        
//    }
}

//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //CLLocationCoordinate2D loc = [userLocation coordinate];
    //放大地图到自身的经纬度位置。
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    //[self.mapview setRegion:region animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
