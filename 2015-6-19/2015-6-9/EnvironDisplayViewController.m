//
//  EnvironDisplayViewController.m
//  融资典当
//
//  Created by 典盟金融 on 15-6-19.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "EnvironDisplayViewController.h"


@interface EnvironDisplayViewController ()
{
    CGSize m_size;
    NSMutableArray *imageArray;
}
@end

@implementation EnvironDisplayViewController

@synthesize m_scrollView,pageCtrl;

//获得数据存放的路径
- (NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"Contacts.sqlite"];
}
//打开数据库的方法
- (void)openDB{
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"数据库打开失败。");
    }
}
//创建一张用户表
-(void)createTable{
    NSString *ceateSQL = @"CREATE TABLE IF NOT EXISTS PERSIONINFO(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER, SEX TEXT, WEIGHT INTEGER, ADDRESS TEXT)";

    char *ERROR;

    if (sqlite3_exec(db, [ceateSQL UTF8String], NULL, NULL, &ERROR)!=SQLITE_OK){
    sqlite3_close(db);
    NSAssert(0, @"ceate table faild!");
    NSLog(@"表创建失败");
    }
}


//插入数据方法
- (void)insertRecordIntoTableName:(NSString *)tableName
                       withField1:(NSString *)field1 field1Value:(NSString *)field1Value
                        andField2:(NSString *)field2 field2Value:(NSString *)field2Value
                        andField3:(NSString *)field3 field3Value:(NSString *)field3Value{
    /*方法1：经典方法
     NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES('%@', '%@', '%@')", tableName, field1, field2, field3, field1Value, field2Value, field3Value];
     char *err;
     if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
     sqlite3_close(db);
     NSAssert(0, @"插入数据错误！");
     }
     */
    //方法2：变量的绑定方法
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' ('%@', '%@', '%@') VALUES (?, ?, ?)",tableName, field1, field2, field3];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1,NULL);
        sqlite3_bind_text(statement, 3, [field3Value UTF8String], -1,NULL);
    }
    if (sqlite3_step(statement) != SQLITE_DONE) {
        NSAssert(0, @"插入数据失败！");
        sqlite3_finalize(statement);
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    [self openDB];
    //NSLog(@"%@",paths);
    self.view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.view.backgroundColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(getBack)];
    //
    m_size=self.view.bounds.size;
    //从文件中读取图片信息和标题信息
    NSString *path=[[NSBundle mainBundle] pathForResource:@"environmentDisplay" ofType:@"plist"];
    NSDictionary *ditionary=[NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* image=[ditionary objectForKey:@"image"];
    // NSLog(@"%@",image);
    imageArray =[[NSMutableArray alloc] init];
    for (NSMutableString *str in image)
    {
        NSMutableString*string= [NSMutableString stringWithFormat:@"%@.jpg",str];
        [imageArray addObject:string];
        // NSLog(@"%@",str);
    }
    NSLog(@"%@",imageArray);
    
    m_scrollView=[self create_scrollView];
    pageCtrl=[self create_pageControl];
    [self.view addSubview:m_scrollView];
    [self.view addSubview:pageCtrl];
    
    
    
}
-(void)getBack
{
    [self.navigationController popViewControllerAnimated:YES];
}




-(UIScrollView*)create_scrollView
{
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, m_size.width, m_size.height)];
    scrollview.backgroundColor=[UIColor blackColor];
    //
    scrollview.contentSize=CGSizeMake(m_size.width*[imageArray count], 0);
    scrollview.pagingEnabled=YES;//过屏幕一半自动跳转
    scrollview.showsHorizontalScrollIndicator=NO;//不显示水平滑动指示符
    scrollview.delegate=self;//滑动完毕一个width以后需要pageControl跟进，所以需要实现这个方法(scrollViewDidScroll)
    
    for (int i=0; i<[imageArray count]; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(m_size.width*i, 0, m_size.width, m_size.height/2-20)];
        NSString *imageName=[imageArray objectAtIndex:i];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.clipsToBounds=YES;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.image=[UIImage imageNamed:imageName];
        //添加边框
        CALayer * layer = [imageView layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 5.0f;
        [scrollview addSubview:imageView];
        
    }
    
    return scrollview;
}
-(UIPageControl*)create_pageControl
{
    UIPageControl* pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(85, m_size.height*0.90, 150, 30)];
    pageControl.numberOfPages=[imageArray count];
    
    UIImage *checkedPointImage=[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"];
    pageControl.currentPageIndicatorTintColor=[UIColor colorWithPatternImage:checkedPointImage];
    
    UIImage *pointImage=[UIImage imageNamed:@"new_feature_pagecontrol_point.png"];
    pageControl.pageIndicatorTintColor=[UIColor colorWithPatternImage:pointImage];
    
    return pageControl;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //more_tableview.contentSize=CGSizeMake(0, self.view.bounds.size.height+60);
    pageCtrl.currentPage=scrollView.contentOffset.x/m_size.width;
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
