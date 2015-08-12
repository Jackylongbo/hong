//
//  MyTableViewCell.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MyTableViewCell.h"
#import "CellButton.h"
@implementation MyTableViewCell
{
    CGSize btn_size;//一个按钮的size
    CellButton *btn1;
    CellButton *btn2;
}
@synthesize imageView;

@synthesize goodsName;//商品名字
@synthesize goodsPrice;//商品价格

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self InitCell];
    }
    return self;
}
//定义每个cell的格式
-(void)InitCell
{
    //一个cell里有一个两个cellbutton
    btn_size=self.contentView.bounds.size;
   // for (int i=0; i<2; i++) {
    btn1=[[CellButton alloc] initWithFrame:CGRectMake(5, 5, 150, 150)];
    btn1.titleLabel.text=[goodsName.text stringByAppendingString:goodsPrice.text];
    [btn1 setTitle:@"" forState:UIControlStateNormal];
    btn1.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    btn1.titleLabel.numberOfLines=0;
    btn1.titleLabel.backgroundColor=[UIColor redColor];
    btn1.tag=50;
    btn1.backgroundColor=[UIColor grayColor];
    [btn1 addTarget:self action:@selector(ShowDetailMessage:) forControlEvents:UIControlEventTouchUpInside];
    /*===============按钮2初始化-================*/
    btn2=[[CellButton alloc] initWithFrame:CGRectMake(165, 5, 150, 150)];
    btn2.titleLabel.text=[goodsName.text stringByAppendingString:goodsPrice.text];
    [btn2 setTitle:@"" forState:UIControlStateNormal];
    btn2.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
    btn2.titleLabel.numberOfLines=0;
    btn2.titleLabel.backgroundColor=[UIColor redColor];
    btn2.tag=51;
    btn2.backgroundColor=[UIColor blackColor];
    [btn2 addTarget:self action:@selector(ShowDetailMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn1];
    [self.contentView addSubview:btn2];
    //}
}
//点击显示详细信息
-(void)ShowDetailMessage:(id)sender
{
    NSLog(@"detail");

}
//刷新cell的数据
-(void)refreshData:(NSDictionary*)dic
{
    //int i;
    NSLog(@"字典%ld",dic.count);
    for (int i=0; i<2; i++)
    {
        CellButton *button=[CellButton new];
        button=(CellButton*)[self.contentView viewWithTag:i+50];
        NSArray *imageArr=[dic objectForKey:@"image"];
        NSLog(@"%@",imageArr);
        [button setImage:[UIImage imageNamed:[imageArr objectAtIndex:i]] forState:UIControlStateNormal];
        //button.imageView.image=[UIImage imageNamed:[imageArr objectAtIndex:i]];
        NSLog(@"%@",button.imageView.image);
        //button.titleLabel.text=@"融资典当";
        [button setTitle:@"融资典当" forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
