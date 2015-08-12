//
//  IMRowView.h
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-13.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYItem.h"
#define IMRowHeight 44
#define IMRowSubHeight 180

typedef NS_ENUM(NSInteger, IMRowViewType) {
    IMRowViewTypeOne,//第一种格式的rowView
    IMRowViewTypeTwo,//第二种格式的rowView
    IMRowViewTypeThree,//
    IMRowViewTypeForth//
};


@interface IMRowView : UIView
{
    UILabel *_titlelabel;
    UIView *_subView;
    BOOL _isopen;
    MYItem *_item;
    IMRowViewType _IMrowtype;
    
    
}
@property (nonatomic ,assign)BOOL isopen;
@property (nonatomic ,strong)MYItem *item;
@property (nonatomic ,assign)IMRowViewType IMrowtype;
//IMRowViewTypeOne
@property (nonatomic ,strong)UILabel *CarType;//车辆品牌
@property (nonatomic ,strong)UILabel *CarNumber;//车牌号
@property (nonatomic ,strong)UILabel *MilesToRun;//行驶公里数
@property (nonatomic ,strong)UILabel *CarValue;//车辆价值
@property (nonatomic )NSString *CType;//
@property (nonatomic )NSString *CNumber;//
@property (nonatomic )NSString *CValue;//
@property (nonatomic )NSString *CMiles;//车辆已行驶公里数
//IMRowViewTypeTwo
@property (nonatomic ,strong)UILabel *PeopleName;
@property (nonatomic ,strong)UILabel *PeopleSex;
@property (nonatomic ,strong)UILabel *BirthPlace;
@property (nonatomic ,strong)UILabel *OwningCar;
@property (nonatomic )NSString *PName;
@property (nonatomic )NSString *PSex;
@property (nonatomic )NSString *PBirthPlace;
@property (nonatomic )NSString *POwning;

@end
