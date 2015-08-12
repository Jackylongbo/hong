//
//  IMRowView.m
//  dianjinsuo
//
//  Created by 典盟金融 on 15-7-13.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "IMRowView.h"

@implementation IMRowView
@synthesize isopen = _isopen;
@synthesize item = _item;
@synthesize IMrowtype = _IMrowtype;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _titlelabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titlelabel.backgroundColor = [UIColor whiteColor];
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    //_titlelabel.textColor = [UIColor redColor];
    _IMrowtype = self.IMrowtype;
    [self addSubview:_titlelabel];
    return self;
}

-(void)setIsopen:(BOOL)isopen
{
    _isopen = isopen;
    if (_isopen) {
        if (_subView==nil) {
            _subView = [[UIView alloc] initWithFrame:CGRectMake(0, IMRowHeight, self.bounds.size.width, IMRowSubHeight)];
            
            if (_IMrowtype == IMRowViewTypeOne) {
                NSLog(@"IMRowTypeOne");
                _subView.backgroundColor = [UIColor lightGrayColor];
                self.CarType = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 30)];
                //self.CarType.backgroundColor = [UIColor grayColor];
                self.CarType.text= @"车辆型号";
                [_subView addSubview:self.CarType];
                
                self.CarNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 80, 30)];
                //self.CarNumber.backgroundColor = [UIColor grayColor];
                self.CarNumber.text = @"车牌号";
                [_subView addSubview:self.CarNumber];
                
                self.MilesToRun = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 80, 30)];
                //self.MilesToRun.backgroundColor = [UIColor grayColor];
                self.MilesToRun.text = @"行驶公里";
                [_subView addSubview:self.MilesToRun];
                
                self.CarValue = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, 80, 30)];
                //self.CarValue.backgroundColor = [UIColor grayColor];
                self.CarValue.text = @"车辆估价";
                [_subView addSubview:self.CarValue];
            }
            else if(_IMrowtype == IMRowViewTypeTwo)
            {
                _subView.backgroundColor = [UIColor lightGrayColor];
                NSLog(@"Two");
                self.PeopleName = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 80, 30)];
                self.PeopleName.text = @"姓名";
                [_subView addSubview:self.PeopleName];
                
                self.PeopleSex = [[UILabel alloc] initWithFrame:CGRectMake(10, 55, 80, 30)];
                self.PeopleSex.text = @"性别";
                [_subView addSubview:self.PeopleSex];
                
                self.BirthPlace = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 80, 30)];
                self.BirthPlace.text = @"出生地";
                [_subView addSubview:self.BirthPlace];
                
                self.OwningCar = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, 80, 30)];
                self.OwningCar.text = @"是否有车";
                [_subView addSubview:self.OwningCar];
                
            
            }
            else if(_IMrowtype == IMRowViewTypeThree)
            {
                _subView.backgroundColor = [UIColor lightGrayColor];
                NSLog(@"three");
            }
                
           // _subtitlelabel.textColor = [UIColor purpleColor];
           // _subtitlelabel.textAlignment =NSTextAlignmentNatural;
            //_subtitlelabel.font = [UIFont systemFontOfSize:40];
        }
        _titlelabel.frame = CGRectMake(0, 0, self.bounds.size.width, IMRowHeight);
        if (_subView.superview==nil) {
            self.CarType = nil;
            self.CarValue = nil;
            self.CarNumber = nil;
            self.MilesToRun = nil;
            
            self.PeopleName = nil;
            self.PeopleSex =nil;
            self.BirthPlace =nil;
            self.OwningCar =nil;
            [self addSubview:_subView];
        }
    }
    else{
        
        _titlelabel.frame = self.bounds;
        if (_subView.superview) {
            [_subView removeFromSuperview];
        }
    }
}
-(void)setItem:(MYItem *)item
{
    _item = item;
    self.isopen = item.isopen;
    _titlelabel.text = item.title;
    //_subtitlelabel.text = item.subtitle;
}


@end
