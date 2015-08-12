//
//  BidModal.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-27.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BidModal : NSManagedObject

@property (nonatomic, retain) NSNumber * b_id;
@property (nonatomic, retain) NSString * borrowTitle;
@property (nonatomic, retain) NSString * borrowInfo;
@property (nonatomic, retain) NSDecimalNumber * annualRate;
@property (nonatomic, retain) NSNumber * borrowStatu;
@property (nonatomic, retain) NSNumber * deadline;
@property (nonatomic, retain) NSDecimalNumber * hasInvestAmout;
@property (nonatomic, retain) NSNumber * borrowWay;
@property (nonatomic, retain) NSString * detail;

@end
