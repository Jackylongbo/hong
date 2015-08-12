//
//  ThirdViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
//
@property (strong,nonatomic)UILabel *yanzhengma;
@property (strong,nonatomic)UILabel *yanCode;//随机生成的验证码
@property (strong,nonatomic)UITableView *tableview;
//下拉选项


//一个登录按钮
@property (strong,nonatomic)UIButton *btn_confirm;
//
-(void)MakeCode;
@end
