//
//  FirstViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(strong,nonatomic)UITableView *mytableview;
@property(strong,nonatomic)UIImageView *m_imageView;
@property(strong,nonatomic)UIImageView* m_imageview1;
@property(strong,nonatomic)UISwipeGestureRecognizer*m_gesture;
@property(strong,nonatomic)UIPanGestureRecognizer*pan_gesture;
@end
