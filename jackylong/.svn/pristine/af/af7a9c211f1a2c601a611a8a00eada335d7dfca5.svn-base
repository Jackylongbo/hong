//
//  MyTabBarViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "MoreViewController.h"
@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//设置tabbar的颜色
    
    
    
    
    /*进入精品推荐页面*/
    FirstViewController *first=[FirstViewController new];
    [self setDetailViewController:first title:@"精品推荐" withImage:@"star1.png" andSelectedImage:@"star0.png"];
    
    /*理财产品页面*/
    SecondViewController *second=[SecondViewController new];
    [self setDetailViewController:second title:@"理财产品" withImage:@"tabbar_discover.png" andSelectedImage:@"tabbar_discover_selected.png"];
    
    /*我的资产页面*/
    ThirdViewController *third=[ThirdViewController new];
    [self setDetailViewController:third title:@"我的资产" withImage:@"tabbar_profile.png" andSelectedImage:@"tabbar_profile_selected.png"];
//    ForthViewController *forth=[ForthViewController new];
//    [self setDetailViewController:forth title:@"赚钱" withImage:@"tabbar_message_center.png" andSelectedImage:@"tabbar_message_center_selected.png"];
    
    /*进入更多介绍页面*/
    MoreViewController *more=[MoreViewController new];
    [self setDetailViewController:more title:@"更多" withImage:@"tabbar_more.png" andSelectedImage:@"tabbar_more_selected.png"];
    
    self.delegate=self;
    
}
-(void)setDetailViewController:(UIViewController*)childController title:(NSString*)title withImage:(NSString*)withImage andSelectedImage:(NSString*)andSelectedImage
{
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
    childController.tabBarItem.image=[UIImage imageNamed:withImage];
    childController.title=title;
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                 
                                                 NSForegroundColorAttributeName:[UIColor brownColor]}];
    //设置导航栏的颜色
    nav.navigationBar.barTintColor=[UIColor whiteColor];

    //注意，此写法可以消除渲染，不写的话就是蓝色
    childController.tabBarItem.selectedImage=[[UIImage imageNamed:andSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //修改tabbaritem上的文字颜色 键－NSForegroundColorAttributeName
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil];
    [childController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
}

-(void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    if (changed) {
        NSLog(@"changed!");
    }else{
        NSLog(@"not changed");
    }
    for (UIViewController *vcs in viewControllers) {
        NSLog(@"%@",vcs.title);
    }
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"\n%@ clicked",viewController.title);
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController.title);
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [self viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
