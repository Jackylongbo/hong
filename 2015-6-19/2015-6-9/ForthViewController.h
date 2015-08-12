//
//  ForthViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForthViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic)UIScrollView *scrollVoew;
@property (strong,nonatomic)UIImageView *z_moneyimageView;
@property (strong,nonatomic)UILabel *brief_label;//简介
@property (strong,nonatomic)UIImageView *process_imageview;//流程图
@property (strong,nonatomic)UILabel *appoint_phone;//预约电话标签
@property (strong,nonatomic)UILabel *appoint_remind;//预约提醒
@property (strong,nonatomic)UIButton *submit_button;//提交按钮


@end
