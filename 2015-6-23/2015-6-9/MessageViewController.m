//
//  MessageViewController.m
//  融资典当
//
//  Created by 典盟金融 on 15-6-24.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "MessageViewController.h"


@interface MessageViewController ()
{
    UITextField *message_original;//默认信息
    UIButton *shareTo;//分享按钮
    UIAlertView *mfAlertview;
}
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"短信分享";
    message_original =[[UITextField alloc] initWithFrame:CGRectMake(5, 80, self.view.bounds.size.width-10, 100)];
    message_original.text=@"核力量";
    message_original.borderStyle=UITextBorderStyleBezel;
    shareTo=[[UIButton alloc] initWithFrame:CGRectMake(10, 185, self.view.bounds.size.width-20, 35)];
    [shareTo setTitle:@"分享给好友" forState:UIControlStateNormal];
    [shareTo setBackgroundColor:[UIColor orangeColor]];
    [shareTo addTarget:self action:@selector(showMessageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:message_original];
    [self.view addSubview:shareTo];
    
    
}

-(void)showMessageView
{
    //Class messageClass=(NSClassFromString(@"MFMessageComposeViewController"));
    //if (messageClass!=nil)
    //{
        BOOL canSendSMS=[MFMessageComposeViewController canSendText];
    NSLog(@"%d",canSendSMS);
        if (canSendSMS)
        {
            MFMessageComposeViewController *messageCtrl=[[MFMessageComposeViewController alloc] init];
            messageCtrl.messageComposeDelegate=self;
            messageCtrl.body=message_original.text;
            [self presentViewController:messageCtrl animated:YES completion:nil];
            //修改短信界面标题
            [[[[messageCtrl viewControllers] lastObject] navigationItem] setTitle:@"发送短信"];
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"抱歉" message:@"短信功能不可用!" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [alert show];
        }
    //}
    
}
//短信发送成功后的回调
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    switch (result)
    {
        case MessageComposeResultCancelled:
        {
            //用户取消发送
        }
            break;
        case MessageComposeResultFailed://发送短信失败
        {
            mfAlertview=[[UIAlertView alloc]initWithTitle:@"抱歉" message:@"短信发送失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil ,nil];
            
            [mfAlertview show];
            
        }
            break;
        case MessageComposeResultSent:
        {
            mfAlertview=[[UIAlertView alloc]initWithTitle:@"恭喜" message:@"短信发送成功!" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil ,nil];
            
            [mfAlertview show];
            
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
