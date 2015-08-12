//
//  MyTabBar.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;

@protocol MyTabBarDelegate <NSObject,UITabBarDelegate>
@optional
-(void)clickPlusButton:(MyTabBar *)tabBar;//点击回调
@end

@interface MyTabBar : UITabBar
@property(nonatomic,weak)id<MyTabBarDelegate>mydelegate;
@end
