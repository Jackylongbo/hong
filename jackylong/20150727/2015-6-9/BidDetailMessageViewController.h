//
//  BidDetailMessageViewController.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BidDetailMessageViewController : UIViewController

@property (strong,nonatomic)UILabel *BnameLabel;//标名称
@property (strong,nonatomic)UILabel *BlastedLabel;//剩余可投
@property (strong,nonatomic)UILabel *BLastContentLabel;//剩余可投的内容

@property (strong,nonatomic)UILabel *InvestMoneyLabel;//项目金额
@property (strong,nonatomic)UILabel *InvestMoney;//项目金额数目
@property (strong,nonatomic)UILabel *ProfictRateLabel;//年利率
@property (strong,nonatomic)UILabel *profictRate;//年化利率数值
@property (strong,nonatomic)UILabel *InvestPeriodLabel;//理财期限
@property (strong,nonatomic)UILabel *InvestPeriod;//理财期限数值

@property (nonatomic)NSString *bname;
@property (nonatomic)NSString *brate;
@property (nonatomic)NSString *bmoney;
@property (nonatomic)NSString *bperiod;

@property (nonatomic)NSDictionary *dic;

-(void)GetDataFrom:(NSDictionary*)dictionary;

@end
