//
//  MyTableViewCell.h
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
-(void)refreshData:(NSDictionary*)dic;


@property(nonatomic,strong)UIImageView *imageView;//

@property(nonatomic,strong)UILabel *goodsName;//商品名
@property(nonatomic,strong)UILabel *goodsPrice;//商品价格


@end