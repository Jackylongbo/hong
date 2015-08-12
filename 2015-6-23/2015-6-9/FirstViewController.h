//
//  FirstViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property(strong ,nonatomic)UIScrollView *VerticalScrollView;//纵向的
@property(strong ,nonatomic)UIScrollView *HorizonScrollView;//横向的
@property(strong ,nonatomic)UITableView *tableview;

@end
