//
//  CellButton.m
//  融资典当
//
//  Created by yinhaibo on 15-6-17.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "CellButton.h"

@implementation CellButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView.backgroundColor=[UIColor yellowColor];
        self.titleLabel.textColor=[UIColor redColor];
        self.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    float width,height,x,y;
    x=0;
    y=0;
    width=contentRect.size.width;
    height=contentRect.size.height*3/4;
    CGRect rect=CGRectMake(x, y,width, height);
    return rect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    float x,y,width,height;
    x=0;
    y=contentRect.size.height*3/4;
    width=contentRect.size.width;
    height=contentRect.size.height*1/4;
    CGRect rect=CGRectMake(x, y,width, height); 
    return rect;
}

@end
