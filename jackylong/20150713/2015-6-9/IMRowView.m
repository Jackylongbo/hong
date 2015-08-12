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

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _titlelabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titlelabel.backgroundColor = [UIColor whiteColor];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    _titlelabel.textColor = [UIColor redColor];
    [self addSubview:_titlelabel];
    return self;
}

-(void)setIsopen:(BOOL)isopen
{
    _isopen = isopen;
    if (_isopen) {
        if (_subtitlelabel==nil) {
            _subtitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, IMRowHeight, self.bounds.size.width, IMRowSubHeight)];
            _subtitlelabel.backgroundColor = [UIColor lightGrayColor];
            _subtitlelabel.textColor = [UIColor purpleColor];
            _subtitlelabel.textAlignment =NSTextAlignmentCenter;
            _subtitlelabel.font = [UIFont systemFontOfSize:40];
        }
        _titlelabel.frame = CGRectMake(0, 0, self.bounds.size.width, IMRowHeight);
        if (_subtitlelabel.superview==nil) {
            [self addSubview:_subtitlelabel];
        }
    }
    else{
        
        _titlelabel.frame = self.bounds;
        if (_subtitlelabel.superview) {
            [_subtitlelabel removeFromSuperview];
        }
    }
}
-(void)setItem:(MYItem *)item
{
    _item = item;
    self.isopen = item.isopen;
    _titlelabel.text = item.title;
    _subtitlelabel.text = item.subtitle;
}


@end
