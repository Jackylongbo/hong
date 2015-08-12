//
//  loginOrRegisterViewController.h
//  融资典当
//
//  Created by 典盟金融 on 15-7-8.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDSAppDelegate.h"

@interface loginOrRegisterViewController : UIViewController<UIGestureRecognizerDelegate>


@property (strong , nonatomic)UILabel *NameLabel;
@property (strong , nonatomic)UILabel *PassLabel;
@property (strong , nonatomic)UITextField *nameField;
@property (strong , nonatomic)UITextField *passField;
@property (strong , nonatomic)UIButton *loginBtn;
@property (strong ,nonatomic)UIButton *freeRegister;
@property (strong , nonatomic)UIButton *ForgetPass;

@end
