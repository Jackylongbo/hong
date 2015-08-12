//
//  FirstViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface FirstViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshTableHeaderView;
    BOOL _reloading;
}

@property(strong ,nonatomic)UIScrollView *VerticalScrollView;//纵向的
@property(strong ,nonatomic)UIScrollView *HorizonScrollView;//横向的
@property(strong ,nonatomic)UITableView *tableview;
@property(retain ,nonatomic)NSMutableArray *imageArrary;
@property(strong ,nonatomic)UIPageControl *pageControl;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

