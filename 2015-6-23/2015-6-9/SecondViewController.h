//
//  SecondViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIImagePickerController *picker;
@property (nonatomic,strong)NSString *filePath;
@property (nonatomic,strong)NSTimer *timer;

//
@property (nonatomic,strong)NSDictionary *dataDictionary;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end
