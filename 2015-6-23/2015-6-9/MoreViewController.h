//
//  MoreViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic ,strong)UITableView *more_tableview;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSArray *titleArr;

@end
