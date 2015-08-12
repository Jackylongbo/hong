//
//  GetCheapViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCheapViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate>

@property(strong,nonatomic)UITableView *m_tableView;
@property(strong,nonatomic)NSMutableData* datas;
@property(strong,nonatomic)NSMutableArray* arr;
@property(strong,nonatomic)UISegmentedControl* segmentedControl;
//
@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)NSMutableArray *nameArray;
@property(strong,nonatomic)NSMutableArray *priceArray;
@property(strong,nonatomic)NSMutableDictionary *dictionary;
-(void)GetRequest;
//-(void)reloadView:(NSDictionary*)res;
@end
