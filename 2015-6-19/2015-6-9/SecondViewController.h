//
//  SecondViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIImageView *second_image;
@property (nonatomic,strong)UICollectionView *mycollectionView;
@property (nonatomic,strong)UIScrollView* popView;//点击每个图片按钮都回弹出这个窗口出来
//
@property (nonatomic,strong)NSMutableArray* dataArr;
@property (nonatomic,strong)UITextField *name_textField;//姓名
@property (nonatomic,strong)UITextField *phone_textField;//电话
@property (nonatomic,strong)UITextView* goods_desField;//详细描述
@property (nonatomic,strong)UITextField *goods_facText;//存放物品正面图片路径
@property (nonatomic,strong)UITextField *goods_backText;//存放物品反面图片路径
@property (nonatomic,strong)UITextField *goods_aspectText;//存放物品侧面图片路径
@property (nonatomic,strong)UITextField *goods_precisionText;//存放物品精部图片路径
@property (nonatomic,strong)UIImagePickerController *picker;
@property (nonatomic,strong)NSString *filePath;
@property (nonatomic,strong)NSTimer *timer;
//初始化弹窗
-(void)initPopview;
@end
