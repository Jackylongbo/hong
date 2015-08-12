//
//  SecondViewController.m
//  2015-6-9
//
//  Created by 陈 晓晓 on 15-6-9.
//  Copyright (c) 2015年 rohool. All rights reserved.
//

#import "SecondViewController.h"
#import "MyButton.h"
#import "MyCollectionViewCell.h"
#import "DDCollectionViewFlowLayout.h"
#import "FirstViewController.h"
#import "ValuatingViewController.h"
#import "mapViewController.h"
@implementation SecondViewController
{
    UILabel *textLabel;
    UIView *showView;
    CGSize m_size;
    UISegmentedControl *segmentControl;
    UIButton* btn1;//图片按钮
    UIButton* btn2;
    UIButton* btn3;
    UIButton* btn4;
    UIButton* btn5;
    UIButton* btn6;
//    
//    @property (nonatomic,strong)UITextField *name_textField;//姓名
//    @property (nonatomic,strong)UITextField *phone_textField;//电话
//    @property (nonatomic,strong)UITextView* goods_desField;//详细描述
//    @property (nonatomic,strong)UITextField *goods_facText;//存放物品正面图片路径
//    @property (nonatomic,strong)UITextField *goods_backText;//存放物品反面图片路径
//    @property (nonatomic,strong)UITextField *goods_aspectText;//存放物品侧面图片路径
//    @property (nonatomic,strong)UITextField *goods_precisionText;//存放物品精部图片路径
    UIButton *submit_btn;//提交按钮
    NSInteger viewTag;//用来获取当前页面的控件tag
    
}
@synthesize second_image;
@synthesize mycollectionView;
@synthesize dataArr;
@synthesize popView;
@synthesize picker;
@synthesize filePath;
@synthesize timer;
@synthesize name_textField,phone_textField,goods_aspectText,goods_backText,goods_desField,goods_facText,goods_precisionText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[self navigationController]navigationBar].
	// Do any additional setup after loading the view.
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    popView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [popView setContentSize:CGSizeMake(0, self.view.bounds.size.height+100)];
    UIBarButtonItem *leftbarItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(getBack:)];
    self.navigationItem.leftBarButtonItem=leftbarItem;
    
    second_image=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    second_image.backgroundColor=[UIColor whiteColor];
    /*============================页面6个按钮==================================*/
    btn1=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+40, self.view.bounds.origin.y+100, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn1 setImage:[UIImage imageNamed:@"jq1.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    btn2=[[UIButton alloc] initWithFrame:CGRectMake(btn1.bounds.size.width+60, self.view.bounds.origin.y+100, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn2 setImage:[UIImage imageNamed:@"jq2.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    btn3=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+40, self.view.bounds.origin.y+self.view.bounds.size.height/3+30, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn3 setImage:[UIImage imageNamed:@"jq3.png"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    btn4=[[UIButton alloc] initWithFrame:CGRectMake(btn1.bounds.size.width+70, self.view.bounds.origin.y+self.view.bounds.size.height/3+10, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn4 setImage:[UIImage imageNamed:@"jq4.png"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    btn5=[[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x+40, 2*btn1.bounds.size.height, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn5 setImage:[UIImage imageNamed:@"jq5.png"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    //
    btn6=[[UIButton alloc]initWithFrame:CGRectMake(btn5.bounds.size.width+80, btn5.bounds.size.height*2, self.view.bounds.size.width/3, self.view.bounds.size.height/3-20)];
    [btn6 setImage:[UIImage imageNamed:@"jq6.png"] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(button_clicked:) forControlEvents:UIControlEventTouchUpInside];
    /*============================页面6个按钮==================================*/
    second_image.userInteractionEnabled=YES;
    [second_image addSubview:btn1];
    [second_image addSubview:btn2];
    [second_image addSubview:btn3];
    [second_image addSubview:btn4];
    [second_image addSubview:btn5];
    [second_image addSubview:btn6];
    btn1.tag=11;
    btn2.tag=12;
    btn3.tag=13;
    btn4.tag=14;
    btn5.tag=15;
    btn6.tag=16;
    
    [self.view addSubview:second_image];
    /*创建一个collectionView*/
    
    NSArray *array=@[@"在线估价",@"估价回复",@"地图导航"];
    segmentControl=[[UISegmentedControl alloc]initWithItems:array];
   // segmentControl.segmentedControlStyle=UISegmentedControlStyleBordered;
    //设置位置 大小
    segmentControl.frame=CGRectMake(0, 60, self.view.bounds.size.width, 40);
    //默认选择
    //segmentControl.selectedSegmentIndex=1;
    //设置背景色
    segmentControl.tintColor=[UIColor orangeColor];
    //设置
    segmentControl.backgroundColor=[UIColor blackColor];
    //设置监听事件
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
    //页面添加手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    //
    self.navigationController.navigationBar.backgroundColor=[UIColor blackColor];
    
}
//键盘隐藏事件
-(void)dismissKeyboard
{
    [self.view endEditing:YES];

}
//为每个button添加点击事件
-(void)button_clicked:(UIButton*)btn
{
//    ValuatingViewController *valuat_ctrl=[ValuatingViewController new];
//    [self.navigationController pushViewController:valuat_ctrl animated:NO];
    if (popView.window==nil) {
        [self initPopview];
        segmentControl.selectedSegmentIndex=0;
    }}

//最上面的segmentedcontrol视图
-(void)change:(UISegmentedControl *)segmentcontrol{
   // NSLog(@"segmentControl %ld",segmentcontrol.selectedSegmentIndex);
    if (segmentcontrol.selectedSegmentIndex==0) {
        if (popView.window==nil) {
            //在线估价
            [self initPopview];
            segmentControl.selectedSegmentIndex=0;
        }
    }
    else if (segmentControl.selectedSegmentIndex==1) {
        [popView removeFromSuperview];
        //估价回复
        /*================网络请求===================*/
        
        
    }
    else
    {
        [popView removeFromSuperview];
        //地图导航
        /*================请求地图api接口===============*/
//        UIView *mapView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, m_size.width, m_size.height)];
//        UIImage *backgroundImage=[UIImage imageNamed:@"bg.jpg"];
//        UIColor *backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
//        [mapView setBackgroundColor:backgroundColor];
//        [self.second_image addSubview:mapView];
        
        mapViewController *map=[mapViewController new];
        [self.navigationController pushViewController:map animated:YES];
    }
}

//点击弹回提示框
-(void)popText:(NSString*)text sec:(NSInteger)seconds
{
    textLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    textLabel.center=self.view.center;
    textLabel.text=text;
    textLabel.backgroundColor=[UIColor clearColor];
    showView=[[UIView alloc] init];
    showView.backgroundColor=[UIColor blackColor];
    showView.frame=CGRectMake(0, 3/4*self.view.bounds.size.height, 80, 30);
    
    timer=[NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(removeAll) userInfo:nil repeats:NO];
    [showView addSubview:textLabel];
    [self.view addSubview:showView];
    [timer invalidate];
}
//估价页面
-(void)initPopview
{
//    popView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
//    [popView setContentSize:CGSizeMake(0, self.view.bounds.size.height+100)];
    popView.backgroundColor=[UIColor grayColor];
    popView.userInteractionEnabled=YES;
    popView.contentMode=UIViewContentModeScaleAspectFill;
    CGSize my_size=self.popView.bounds.size;//屏幕的大小

    //popView.editable=NO;
    //定义一个label
    UILabel *Advisory_phone=[[UILabel alloc] initWithFrame:CGRectMake(5, my_size.height/7+30, popView.bounds.size.width-10, 40)];
    //Advisory_phone.center=popView.center;
    Advisory_phone.text=@"咨询电话：000-00000000";//固定的电话
    Advisory_phone.tintColor=[UIColor orangeColor];
    Advisory_phone.backgroundColor=[UIColor orangeColor];
    Advisory_phone.font=[UIFont systemFontOfSize:26.0f];
    Advisory_phone.textColor=[UIColor brownColor];
    UILabel *textlabel=[[UILabel alloc] initWithFrame:CGRectMake(5, my_size.height/7+70, popView.bounds.size.width-10, 50)];
    textlabel.text=@"请在这里提供物品的详细描述，我们将尽快为您估价，谢谢！";
    textlabel.lineBreakMode=NSLineBreakByCharWrapping;
    textlabel.numberOfLines=0;
    textlabel.textColor=[UIColor brownColor];
    textlabel.backgroundColor=[UIColor orangeColor];//
    
    //从这里开始设置自适应的布局
    name_textField=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+120, my_size.width-90, 30)];
    UILabel *name_label=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+120, 80, 30)];
    name_label.text=@"您的姓名:";
    name_textField.borderStyle=UITextBorderStyleBezel;
    name_textField.placeholder=@"必填";
    //手机号码
    UILabel *phone_label=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+150, 80, 30)];
    phone_label.text=@"手机号码:";
    phone_textField=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+150, my_size.width-90, 30)];
    phone_textField.placeholder=@"必填";
    phone_textField.borderStyle=UITextBorderStyleBezel;
    //
    UILabel *goods_des=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+180, 80, 30)];
    goods_des.text=@"物品描述:";
    goods_desField=[[UITextView alloc] initWithFrame:CGRectMake(82, my_size.height/7+180, my_size.width-90, 50)];
    //goods_desField.text=@"必填";
    goods_desField.font=[UIFont systemFontOfSize:15.0f];
    goods_desField.selectable=YES;
    goods_desField.layer.borderColor=UIColor.grayColor.CGColor;
    goods_desField.layer.borderWidth=1;
    
    UILabel *m_label=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+235, my_size.width-10, 50)];
    m_label.text=@"最多支持四张图片上传,上传完成后,请点击提交按钮保存估价信息.";
    m_label.lineBreakMode=NSLineBreakByCharWrapping;
    m_label.numberOfLines=0;
    m_label.backgroundColor=[UIColor orangeColor];
    //添加四个
    /*
        添加四个label
     goods_facText.tag=20;
     goods_backText.tag=21;//用来添加点击事件时用的到
     goods_aspectText.tag=22;
     goods_precisionText.tag=23;
    */
    //UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choose_photo:)];
    popView.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    /*==========================物品正面============================*/
    UILabel *goods_facade=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+285, 80, 30)];
    goods_facade.text=@"物品正面:";
    goods_facText=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+285, my_size.width-90, 30)];
    goods_facText.placeholder=@"选填/拍照或选择图片";
    goods_facText.borderStyle=UITextBorderStyleBezel;
    goods_facText.tag=20;
    /*==========================物品正面按钮选中============================*/
    UIButton *good_facbtn=[[UIButton alloc] initWithFrame:CGRectMake(82, my_size.height/7+285, my_size.width-90, 30)];
    [good_facbtn addTarget:self action:@selector(choose_photo:) forControlEvents:UIControlEventTouchUpInside];
    good_facbtn.tag=31;
    //goods_facText.enabled=NO;
    //goods_facText.userInteractionEnabled=YES;
    /*==========================物品反面============================*/
    UILabel *goods_back=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+320, 80, 30)];
    goods_back.text=@"物品反面:";
    goods_backText=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+320, my_size.width-90, 30)];
    goods_backText.placeholder=@"选填/拍照或选择图片";
    goods_backText.borderStyle=UITextBorderStyleBezel;
    goods_backText.tag=21;
    /*==========================物品反面按钮选中============================*/
    UIButton *good_backbtn=[[UIButton alloc] initWithFrame:CGRectMake(82, my_size.height/7+320, self.popView.bounds.size.width-90, 30)];
    [good_backbtn addTarget:self action:@selector(choose_photo:) forControlEvents:UIControlEventTouchUpInside];
    good_backbtn.tag=32;
    /*==========================物品侧面============================*/
    UILabel *goods_aspect=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+355, 80, 30)];
    goods_aspect.text=@"物品侧面:";
    goods_aspectText=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+355, my_size.width-90, 30)];
    goods_aspectText.placeholder=@"选填/拍照或选择图片";
    goods_aspectText.borderStyle=UITextBorderStyleBezel;
    goods_aspectText.tag=22;
    /*==========================物品侧面按钮选中============================*/
    UIButton *good_aspectbtn=[[UIButton alloc] initWithFrame:CGRectMake(82, my_size.height/7+355, my_size.width-90, 30)];
    [good_aspectbtn addTarget:self action:@selector(choose_photo:) forControlEvents:UIControlEventTouchUpInside];
    good_aspectbtn.tag=33;
    /*===========================物品精部===========================*/
    UILabel *goods_precision=[[UILabel alloc] initWithFrame:CGRectMake(2, my_size.height/7+390, 80, 30)];
    goods_precision.text=@"物品精部:";
    goods_precisionText=[[UITextField alloc] initWithFrame:CGRectMake(82, my_size.height/7+390, self.popView.bounds.size.width-90, 30)];
    goods_precisionText.placeholder=@"选填/拍照或选择图片";
    goods_precisionText.borderStyle=UITextBorderStyleBezel;
    goods_precisionText.tag=23;
    /*==========================物品精部按钮选中============================*/
    UIButton *good_precisiontbtn=[[UIButton alloc] initWithFrame:CGRectMake(82, my_size.height/7+390, my_size.width-90, 50)];
    [good_precisiontbtn addTarget:self action:@selector(choose_photo:)
                  forControlEvents:UIControlEventTouchUpInside];
    good_precisiontbtn.tag=34;
    /*===========================添加一个提交button===========================*/
    submit_btn=[[UIButton alloc] initWithFrame:CGRectMake(5, my_size.height/7+440, self.popView.bounds.size.width-10, 40)];
    submit_btn.backgroundColor=[UIColor orangeColor];
    [submit_btn setTitle:@"提     交" forState:UIControlStateNormal];
    submit_btn.userInteractionEnabled=YES;
    [submit_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit_btn addTarget:self action:@selector(submit_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.popView addSubview: submit_btn];
    [self.popView addSubview:name_textField];
    [self.popView addSubview:name_label];
    
    [self.popView addSubview:phone_label];
    [self.popView addSubview:phone_textField];
    
    [self.popView addSubview:goods_desField];
    [self.popView addSubview:goods_des];
    
    [self.popView addSubview:m_label];
    [self.popView addSubview:goods_facade];
    [self.popView addSubview:goods_back];
    [self.popView addSubview:goods_aspect];
    [self.popView addSubview:goods_precision];
    [self.popView addSubview:goods_facText];
    [self.popView addSubview:goods_backText];
    [self.popView addSubview:goods_aspectText];
    [self.popView addSubview:goods_precisionText];
    [self.popView addSubview:good_facbtn];
    [self.popView addSubview:good_backbtn];
    [self.popView addSubview:good_aspectbtn];
    [self.popView addSubview:good_precisiontbtn];
    
    [popView addSubview:Advisory_phone];
    [popView addSubview:textlabel];
    [second_image addSubview:popView];
}
//navigationitem leftitem
-(void)getBack:(id)sender
{
    [popView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];

}
//提交按钮事件
-(void)submit_clicked:(id)sender
{
    NSLog(@"提交");
    if ([name_textField.text isEqualToString:@""]||[phone_textField.text isEqualToString: @""]||[goods_desField.text isEqualToString:@""]) {
        UIView *push=[[UIView alloc] initWithFrame:CGRectMake(10, 150, self.view.bounds.size.width-40, 30)];
        push.tag=88;
        UILabel *p_label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        [push addSubview:p_label];
        
        p_label.center=push.center;
        p_label.backgroundColor=[UIColor blackColor];
        p_label.textColor=[UIColor whiteColor];
        p_label.text=@"姓名/手机号码/物品描述 不能为空";
        [self.popView addSubview:push];
        timer=[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(removeFrom:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    else
    {
        //提交给后台服务器,需要连接服务器
    }
}
-(void)removeFrom:(id)sender
{
    UIView *view=[self.popView viewWithTag:88];
    [view removeFromSuperview];
    
    //[timer invalidate];
}

//选择照片事件
-(void)choose_photo:(UIButton*)sender
{
    UIActionSheet *chose_sheet=[[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册图片上传" otherButtonTitles:@"拍照上传", nil];
    [chose_sheet showInView:self.popView];
    viewTag=sender.tag;
}

#pragma mark -actionSheet protocol method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"1,相册图片上传");
       if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
       {
           picker=[[UIImagePickerController alloc] init];
           picker.delegate = self;
           //picker.allowsImageEditing = YES;
           picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSLog(@"111,相册图片上传");
           [self presentViewController:picker animated:YES completion:nil];
           
       }
        
    }else if (buttonIndex == 1) {
        NSLog(@"2,拍照上传");
    }else if(buttonIndex == 2) {
        NSLog(@"3,取消");
    }
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
#pragma mark -UIImagePickerController
// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - 相册文件选取相关
// 相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark - 拍照按钮事件

//- (void)ClickControlAction:(id)sender{
//    // 判断有摄像头，并且支持拍照功能
//    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]){
//        // 初始化图片选择控制器
//        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
//        
//        
//        // 设置所支持的类型，设置只能拍照，或则只能录像，或者两者都可以
//        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
//        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
//        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
//        [controller setMediaTypes:arrMediaTypes];
//        
//        // 设置录制视频的质量
//        [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
//        //设置最长摄像时间
//        [controller setVideoMaximumDuration:10.f];
//        
//        
//        [controller setAllowsEditing:YES];// 设置是否可以管理已经存在的图片或者视频
//        controller.delegate= self;// 设置代理
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    } else {
//        NSLog(@"Camera is not available.");
//    }
//}

//图片路径选择
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"图片路径");
    static int i=0;
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image)==nil) {
            data=UIImageJPEGRepresentation(image,1.0);
        }
        else{
            data=UIImagePNGRepresentation(image);
        }
        //图片保存的路径,将图片放在沙盒的documents 文件夹中
        NSString*doucmentsPath=[NSHomeDirectory() stringByAppendingString:@"/Documents"];
        NSFileManager *filemanager=[NSFileManager defaultManager];
        [filemanager createDirectoryAtPath:doucmentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [filemanager createFileAtPath:[doucmentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        filePath=[[NSString alloc] initWithFormat:@"%@/self%d_%@",doucmentsPath,i++ ,@"image.png"];
        [self dismissViewControllerAnimated:YES completion:nil];
        //选中图片后直接将图片的路径放入textfield
        [self sendDirectToTextField:viewTag path:filePath];
   
    }
    
}
//将图片的路径送给textField的text
-(void)sendDirectToTextField:(NSInteger)tag path:(NSString*)filepath
{
    if (31==tag) {
        goods_facText.text=filepath;
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(32==tag)
    {
        goods_backText.text=filepath;
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(33==tag)
    {
        goods_aspectText.text=filepath;
        NSLog(@"%@",filepath);
        filepath=nil;
    }
    if(34==tag)
    {
        goods_precisionText.text=filepath;
        NSLog(@"%@",filepath);
        filepath=nil;
    }
}

-(void)removeAll
{
    [textLabel removeFromSuperview];
    [showView removeFromSuperview];
}
- (void)viewDidAppear:(BOOL)animated{
    
    [self viewDidLoad];
    
}

#pragma mark -keyboard return
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
