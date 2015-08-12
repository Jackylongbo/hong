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
	// Do any additional setup after loading the view.
    FirstViewController *first=[FirstViewController new];
    [self setDetailViewController:first title:@"首页" withImage:@"tabbar_home.png" andSelectedImage:@"tabbar_home_selected.png"];
    //[first setTitle:@"恒通典当行"];
    SecondViewController *second=[SecondViewController new];
    [self setDetailViewController:second title:@"借钱" withImage:@"tabbar_discover.png" andSelectedImage:@"tabbar_discover_selected.png"];
    //[self setDetailViewController:profile title:@"我" withImage:@"tabbar_profile.png" andSelectedImage:@"tabbar_profile_selected.png"];
    ThirdViewController *third=[ThirdViewController new];
    [self setDetailViewController:third title:@"还钱" withImage:@"tabbar_profile.png" andSelectedImage:@"tabbar_profile_selected.png"];
    ForthViewController *forth=[ForthViewController new];
    [self setDetailViewController:forth title:@"赚钱" withImage:@"tabbar_message_center.png" andSelectedImage:@"tabbar_message_center_selected.png"];
    MoreViewController *more=[MoreViewController new];
    [self setDetailViewController:more title:@"更多" withImage:@"tabbar_more.png" andSelectedImage:@"tabbar_more_selected.png"];
    
    MyTabBar *myTabBar=[[MyTabBar alloc]init];
    myTabBar.mydelegate=self;
    myTabBar.barTintColor=[UIColor blackColor];
    [self setValue:myTabBar forKeyPath:@"tabBar"];
//    MyTabBarViewController *myTabbarControll=[[MyTabBarViewController alloc] init];
//    myTabbarControll.viewControllers=@[first,second,third,forth,more];
    self.delegate=self;
    
}
-(void)setDetailViewController:(UIViewController*)childController title:(NSString*)title withImage:(NSString*)withImage andSelectedImage:(NSString*)andSelectedImage
{
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childController];
    [self addChildViewController:nav];
    childController.tabBarItem.image=[UIImage imageNamed:withImage];
    childController.title=title;
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                 
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav.navigationBar.barTintColor=[UIColor orangeColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     
//  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
//    
//    NSForegroundColorAttributeName:[UIColor redColor]}];
    //注意，此写法可以消除渲染，不写的话就是蓝色
    childController.tabBarItem.selectedImage=[[UIImage imageNamed:andSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //修改tabbaritem上的文字颜色 键－NSForegroundColorAttributeName
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil];
    [childController.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
}
//协议方法，也可以实现父类方法
-(void)clickPlusButton:(MyTabBar *)tabBar
{
    NSLog(@"点击了加号");
    /*
     //弹出一个控制器，导航控制器（因为有导航栏）
     sendWeiboViewController *Vc=[[sendWeiboViewController alloc]init];
     UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:Vc];
     //[self addChildViewController:nav];
     [Vc changeTitle:@"发微博"];
     [Vc  addInputView:@"分享新鲜事..."];
     [self presentViewController:nav animated:YES completion:nil];
     */
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
    
//    [self viewDidAppear:YES];
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",viewController.title);
    [self.navigationController pushViewController:viewController animated:YES];
//    [self viewDidAppear:YES];

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
