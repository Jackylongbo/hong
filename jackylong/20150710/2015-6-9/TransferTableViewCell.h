//
//  TransferTableViewCell.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-14.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferTableViewCell : UITableViewCell
///
@property (nonatomic ,strong)UILabel* BName;
@property (nonatomic ,strong)UILabel* TransferPriceLabel;
@property (nonatomic ,strong)UILabel* TransferTimeLabel;
@property (nonatomic ,strong)UILabel* MoneyTolastLabel;
@property (nonatomic ,strong)UILabel* PeriodTolastLabel;
@property (nonatomic ,strong)UIButton* TransFerBtn;//承接按钮
///
@property (nonatomic ,strong)UILabel* TransferPrice;//转让价格
@property (nonatomic ,strong)UILabel* TransferTime;//承接事件
@property (nonatomic ,strong)UILabel* MoneyToLast;//剩余本金
@property (nonatomic ,strong)UILabel* PeriodToLast;//剩余期数

@end
