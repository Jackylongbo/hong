//
//  dataStatus.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//


/*
 用来存放从服务器获取到的数据
 
 */

#import <Foundation/Foundation.h>

@interface dataStatus : NSObject
/*
 
 Bname;//标的名称
 profictRate;//年化利率
 InvestAccount;//投资金额
 Baddress;//投标人地址
 InvestPeriod;//投标期限
 LowestStart;//投标最低起点
 BuyProcess;//购买进度
*/

@property (nonatomic)NSString *Bname;
@property (nonatomic)NSString *profictRate;
@property (nonatomic)NSString *InvestAccount;
@property (nonatomic)NSString *InvestPeriod;
@property (nonatomic)CGFloat *BuyProcess;

@end
