//
//  EnvironDisplayViewController.h
//  融资典当
//
//  Created by 典盟金融 on 15-6-19.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface EnvironDisplayViewController : UIViewController<UIScrollViewDelegate>
{
    sqlite3 *db;
}
-(NSString *)filePath;
@property (nonatomic,strong)UIScrollView *m_scrollView;
@property (nonatomic,strong)UIPageControl *pageCtrl;

@end
