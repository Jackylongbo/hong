//
//  MyButton.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.imageView.center=self.center;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    float width,height,x,y;
    x=contentRect.size.width/4-10;
    y=0;
    width=contentRect.size.width*3/4;
    height=contentRect.size.height*3/4;
    CGRect rect=CGRectMake(x, y,width, height);
    return rect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    float x,y,width,height;
    x=0;
    y=contentRect.size.height- contentRect.size.height*1/4;
    width=contentRect.size.width;
    height=contentRect.size.height*1/4;
    CGRect rect=CGRectMake(x, y,width, height);
    
    return rect;
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
