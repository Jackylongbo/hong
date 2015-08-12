//
//  SecondViewController.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface SecondViewController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshTableHeaderView;
    EGORefreshTableHeaderView *_refreshTransferHeadrView;
    BOOL _reloading;

}

@property (nonatomic,strong)UIImagePickerController *picker;
@property (nonatomic,strong)NSString *filePath;
@property (nonatomic,strong)NSTimer *timer;

//
@property (nonatomic,strong)NSDictionary *dataDictionary;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *AllBidTableView;
@property (nonatomic,strong)UITableView *TransferBidTableView;
/*
 UITableView *AllBidTableView;//全部标
 UITableView *TransferBidTableView;//转让标的
 
 */

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
