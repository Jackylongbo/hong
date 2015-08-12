//
//  MyTabBar.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MyTabBar.h"
@interface MyTabBar()
@property(nonatomic,weak)UIButton *plusButton;
@end

@implementation MyTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        //这里可以添加一个按钮
//        UIButton *Btn=[[UIButton alloc]init];
//        [Btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateNormal];
//        
//        [Btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateHighlighted];
//        
//        Btn.bounds = CGRectMake(0, 0, Btn.currentBackgroundImage.size.width, Btn.currentBackgroundImage.size.height);
//        self.plusButton=Btn;
//        [Btn addTarget:self action:@selector(btn_clicked) forControlEvents:UIControlEventTouchUpInside];//按钮点击要做的事情交给控制器
//        [self addSubview:Btn];
//        self.backgroundColor=[UIColor whiteColor];//设置一个白色的颜色，不然看起来会透明
    }
    return self;
    
}

-(void)btn_clicked
{
    [self.mydelegate clickPlusButton:self];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
