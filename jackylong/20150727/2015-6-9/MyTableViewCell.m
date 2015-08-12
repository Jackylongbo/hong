//
//  MyTableViewCell.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MyTableViewCell.h"
#import "CellButton.h"
#import "ProgressBarView.h"

@implementation MyTableViewCell
{
    UILabel *Bname;//标的名称
    UILabel *profictRate;//年化利率
    UILabel *InvestAccount;//投资金额
    UILabel *Baddress;//投标人地址
    UILabel *InvestPeriod;//投标期限
    UILabel *LowestStart;//投标最低起点
    ProgressBarView *progressView;//
    UILabel *progressLabel;
    CGFloat BidProgress;
}

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
    //
    Bname = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.contentView.bounds.size.width/2, 25)];
    Bname.font = [UIFont systemFontOfSize:16.0f];
    
    profictRate = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 50, 25)];
    profictRate.textColor = [UIColor redColor];
    profictRate.font = [UIFont systemFontOfSize:12.0f];
    
    InvestPeriod = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 50, 25)];
    InvestPeriod.font = [UIFont systemFontOfSize:14.0f];
    //InvestPeriod.textColor =[UIColor lightTextColor];
    
    Baddress = [[UILabel alloc] initWithFrame:CGRectMake(5, 65, 80, 25)];
    Baddress.font = [UIFont systemFontOfSize:12.0f];
    
    InvestAccount = [[UILabel alloc] initWithFrame:CGRectMake(180, 35, 60, 25)];
    InvestAccount.font = [UIFont systemFontOfSize:11.0f];
    
    LowestStart = [[UILabel alloc] initWithFrame:CGRectMake(180, 65, 60, 25)];
    LowestStart.font = [UIFont systemFontOfSize:12.0f];
    
    progressView = [[ProgressBarView alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width-80, 20, 70, 70)];
    //progressView.progressBarArcWidth = 3.0f;
    progressView.progressBarColor = [UIColor blueColor];
    [progressView setBackgroundColor:[UIColor clearColor]];
    progressView.progressBarArcWidth = 2.0f;
    progressView.progressBarShadowOpacity = .1f;
    progressView.delegate=self;
    progressView.wrapperColor = [UIColor colorWithRed: 240.0 / 255.0 green:240.0 / 255.0 blue: 240.0 / 255.0 alpha: .5];
    progressView.progressBarShadowOpacity = .1f;
    progressView.duration = 0.0001f;//调整动画的播放速度
    progressView.currentProgress = 0.0f;
    //[progressView run:0.0f];
    
    progressLabel = [[UILabel alloc] initWithFrame:CGRectMake((progressView.bounds.size.width-55)/2, (progressView.bounds.size.height-20)/2, 60, 20)];
    progressLabel.numberOfLines =1;
    progressLabel.text=@"0%";
    progressLabel.textAlignment =NSTextAlignmentCenter;
    progressLabel.font = [progressLabel.font fontWithSize:14];
    //progressLabel.center = progressView.center;
    [progressView addSubview:progressLabel];
    
    [self.contentView addSubview:Bname];
    [self.contentView addSubview:Baddress];
    [self.contentView addSubview:profictRate];
    [self.contentView addSubview:InvestAccount];
    [self.contentView addSubview:InvestPeriod];
    [self.contentView addSubview:progressView];
    [self.contentView addSubview:LowestStart];
    
    self.contentView.userInteractionEnabled = YES;
}

//刷新cell的数据
-(void)loadCellData:(NSDictionary *)dictionary
{
    Bname.text = [dictionary objectForKey:@"Bname"];
    profictRate.text = [dictionary objectForKey:@"profictRate"];
    Baddress.text = [dictionary objectForKey:@"Baddress"];
    InvestAccount.text = [dictionary objectForKey:@"InvestAccount"];
    InvestPeriod.text = [dictionary objectForKey:@"InvestPeriod"];
    LowestStart.text = [dictionary objectForKey:@"LowestStart"];
//    [progressView stopAtProgress:0.5];//在固定的位置停
   
    //BidProgress = [[dictionary objectForKey:@"" ] floatValue];
    progressView.currentProgress=0.54f;
    NSString *stringFloat = [NSString stringWithFormat:@"%f", round(progressView.currentProgress * 100)];
    BidProgress=[stringFloat floatValue];
    progressLabel.text = [NSString stringWithFormat:@"%2.2f%@", BidProgress, @"%"];
    
    if (progressView.currentProgress==1.0f) {
        NSLog(@"%f",progressView.currentProgress);
        //progressLabel.text = @"";
        progressLabel.text = @"标满";
        progressView.progressBarColor = [UIColor grayColor];
    }
}

//- (void)animationDidStop:(CAAnimation *)processAnimation finished:(BOOL)flag {
//    
//    NSString *stringFloat = [NSString stringWithFormat:@"%f", round(progressView.currentProgress * 100)];
//    NSInteger stringInt=[stringFloat intValue];
//    if (progressView.currentProgress < 1.0) {
//        progressLabel.text = [NSString stringWithFormat:@"%d%@", stringInt, @"%"];
//        
//        [progressView run:progressView.currentProgress];
//        [progressView stopAtProgress:1.0f];//在固定的位置停
//        if (progressView.currentProgress==1.0f) {
//            NSLog(@"%f",progressView.currentProgress);
//            //progressLabel.text = @"";
//            progressLabel.text = @"标满";
//        }
//    } else {
//        //[progressView stopAtProgress:1];//在固定的位置停
//       
//        [progressView run: 0.0f];
//        if (progressView.currentProgress==1.0f) {
//            NSLog(@"%f",progressView.currentProgress);
//            progressLabel.text = @"";
//            progressLabel.text = @"标满";
//        }
//    }
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
