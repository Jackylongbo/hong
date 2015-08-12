//
//  TransferTableViewCell.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-14.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "TransferTableViewCell.h"

@implementation TransferTableViewCell
/*
 @property (nonatomic ,strong)UILabel* TransferPriceLabel;
 @property (nonatomic ,strong)UILabel* TransferTimeLabel;
 @property (nonatomic ,strong)UILabel* MoneyTolastLabel;
 @property (nonatomic ,strong)UILabel* PeriodTolastLabel;
 ///
 @property (nonatomic ,strong)UILabel* TransferPrice;//转让价格
 @property (nonatomic ,strong)UILabel* TransferTime;//承接事件
 @property (nonatomic ,strong)UILabel* MoneyToLast;//剩余本金
 @property (nonatomic ,strong)UILabel* PeriodToLast;//剩余期数
 
 */
@synthesize BName;//标名称
@synthesize TransferPriceLabel;
@synthesize TransferPrice;//承接价格
@synthesize TransferTimeLabel;
@synthesize TransferTime;//承接时间
@synthesize MoneyTolastLabel;
@synthesize MoneyToLast;//剩余本金
@synthesize PeriodTolastLabel;
@synthesize PeriodToLast;//剩余期数
@synthesize TransFerBtn;//承接

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createCellStyle];
    }
    return self;

}

-(void)createCellStyle
{
    CGSize cellSize = self.contentView.bounds.size;
    BName = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, cellSize.width/2, 20)];
    BName.font = [UIFont systemFontOfSize:16.0f];
    BName.text = @"这个设计喔ooooo";
    //
    TransFerBtn = [[UIButton alloc] initWithFrame:CGRectMake(cellSize.width-60, 5, 50, 25)];
    TransFerBtn.backgroundColor = [UIColor blueColor];
    [TransFerBtn setTitle:@"承接" forState:UIControlStateNormal];
    
    //转让价格
    TransferPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, cellSize.width/4-10,20)];
    TransferPriceLabel.text = @"转让价格:";
    TransferPriceLabel.font = [UIFont systemFontOfSize:14.f];
    TransferPriceLabel.textColor = [UIColor lightGrayColor];
    TransferPrice = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width/4, 30, cellSize.width/4-10, 20)];
    TransferPrice.textColor = [UIColor redColor];
    TransferPrice.font = [UIFont systemFontOfSize:14.0f];
    TransferPrice.text = @"40000";
    //转让本金
    MoneyTolastLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width/2, 30, cellSize.width/4-10, 20)];
    MoneyTolastLabel.text = @"剩余本金:";
    MoneyTolastLabel.textColor = [UIColor lightGrayColor];
    MoneyTolastLabel.font = [UIFont systemFontOfSize:14.0f];
    MoneyToLast = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width-80, 30, cellSize.width/4-10, 20)];
    MoneyToLast.textColor = [UIColor redColor];
    MoneyToLast.font = [UIFont systemFontOfSize:14.0f];
    MoneyToLast.text = @"3330";
    //承接时间
    TransferTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, cellSize.width/4-10, 20)];
    TransferTimeLabel.text = @"承接时间:";
    TransferTimeLabel.font = [UIFont systemFontOfSize:14.f];
    TransferTimeLabel.textColor = [UIColor lightGrayColor];
    TransferTime = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width/4, 60, cellSize.width/4-10, 20)];
    TransferTime.textColor = [UIColor redColor];
    TransferTime.font = [UIFont systemFontOfSize:14.f];
    TransferTime.text = @"13/7/2015";
    //剩余期数
    PeriodTolastLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width/2, 60,cellSize.width/4-10,20 )];
    PeriodTolastLabel.text = @"剩余期数:";
    PeriodTolastLabel.font = [UIFont systemFontOfSize:14.f];
    PeriodTolastLabel.textColor = [UIColor lightGrayColor];
    PeriodToLast = [[UILabel alloc] initWithFrame:CGRectMake(cellSize.width-80, 60, cellSize.width/4-10, 20)];
    PeriodToLast.textColor = [UIColor redColor];
    PeriodToLast.font = [UIFont systemFontOfSize:14.f];
    PeriodToLast.text = @"3个月";
    
    [self.contentView addSubview:BName];
    [self.contentView addSubview:TransferPriceLabel];
    [self.contentView addSubview:TransferPrice];
    [self.contentView addSubview:TransferTimeLabel];
    [self.contentView addSubview:TransferTime];
    [self.contentView addSubview:TransFerBtn];
    [self.contentView addSubview:MoneyToLast];
    [self.contentView addSubview:MoneyTolastLabel];
    [self.contentView addSubview:PeriodToLast];
    [self.contentView addSubview:PeriodTolastLabel];

}






- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
