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


@interface IMRowView : UIView
{
    UILabel *_titlelabel;
    UILabel *_subtitlelabel;
    BOOL _isopen;
    MYItem *_item;
}
@property (nonatomic ,assign)BOOL isopen;
@property (nonatomic ,strong)MYItem *item;

@end
