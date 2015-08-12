//
//  ThirdViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController<UITextFieldDelegate>
//
@property (strong,nonatomic)UILabel *yanzhengma;
@property (strong,nonatomic)UILabel *yanCode;//随机生成的验证码
@property (strong,nonatomic)UITextField *textField1;
@property (strong,nonatomic)UITextField *textField2;
@property (strong,nonatomic)UITextField *textField3;
@property (strong,nonatomic)UITextField *textField4;
//下拉选项


//一个提交按钮
@property (strong,nonatomic)UIButton *btn_confirm;
//
-(void)MakeCode;
@end
