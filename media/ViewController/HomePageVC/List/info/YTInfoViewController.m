//
//  YTInfoViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//
#define kWinSize [UIScreen mainScreen].bounds.size
#import "YTInfoViewController.h"
#import "YTCommentsViewController.h"
#import "YTshoucang.h"
#import "YcKeyBoardView.h"
@interface YTInfoViewController ()<YcKeyBoardViewDelegate>

@end

@implementation YTInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setFanhui];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleBordered target:self action:@selector(shoucangMethond)];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //点击进入评论列表
    //UITapGestureRecognizer *tapToComments = [[UITapGestureRecognizer alloc]initWithTarget:self //action:@selector(tapToComments)];
    //[self.commentsShow addGestureRecognizer:tapToComments];

    //给sendTextView添加轻击手势
//    UITapGestureRecognizer *tapToText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToText)];
//    [self.sendButton addGestureRecognizer:tapToText];
    
    [self setCascTitle:self.titleForNav];
    //传递评论数
    //self.lblCommentCount.text = self.listObj.discussnum;
    //评论框转换
    [self addDiscuss];
}

-(void)viewWillAppear:(BOOL)animated
{
[self.navigationController setNavigationBarHidden:NO];[self loadRequest];
    [self isShoucang];
}

- (void)viewDidLayoutSubviews
{
    //int height = [ [ UIScreen mainScreen ] bounds ].size.height - 44;
    //self.contentWebView.frame = CGRectMake(0,IS_IOS7?0:0, 320, IS_IPHONE_5?568:480-64);
    //self.contentWebView.frame = CGRectMake(0,64, 320, IS_IPHONE_5?568:480-64-44);
    //[super viewDidLayoutSubviews];

}
- (void)viewWillLayoutSubviews
{
    //[super viewWillLayoutSubviews];
}
//判断是否收藏
-(void)isShoucang
{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"shoucang.txt"];
    NSMutableArray * arr = [NSMutableArray new];
    arr =[NSMutableArray  arrayWithContentsOfFile:filePath];

    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:self.listObj.smallImgByTrue forKey:@"imageurl"];
    [dic setValue:self.listObj.titleLabel forKey:@"title"];
    [dic setValue:self.listObj.contentByTrue forKey:@"content"];
    [dic setValue:self.listObj.date forKey:@"time"];
    
    NSInteger i = 0;
    for (NSDictionary * dic1 in arr) {
        if ( [[dic1 objectForKey:@"title"] isEqualToString:[dic objectForKey:@"title"]]) {
            //已收藏
            self.navigationItem.rightBarButtonItem.title = @"取消收藏";
        }else {
            i++;
        }
    }
    if (i == [YTshoucang share].shoucangArr.count) {
        //没收藏
        self.navigationItem.rightBarButtonItem.title = @"收藏";

    }
}

-(void)loadRequest
{

    [[YTDataManger shareDataManger] getDetailInformationUrlAndTocken:@"" idcode:@"" itemid:self.itemid destView:self.contentWebView Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"getDetailInformationUrl error");
        } else {
            if (posts) {
                [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[posts objectForKey:@"result"] objectForKey:@"infourl"]]]];
            }
        }
    }];
}

-(void)shoucangMethond
{
    self.listObj.date= [NSDate date];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:self.listObj.smallImgByTrue forKey:@"imageurl"];
    [dic setValue:self.listObj.titleLabel forKey:@"title"];
    [dic setValue:self.listObj.contentByTrue forKey:@"content"];
    [dic setValue:self.listObj.date forKey:@"time"];
    [dic setValue:self.listObj.itemId forKey:@"itemid"];
   
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"收藏"]) {
        self.navigationItem.rightBarButtonItem.title = @"取消收藏";
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        NSString *filePahth = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"shoucang.txt"];
        
         NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:filePahth]) {
            
            [fileManager createFileAtPath:filePahth contents:nil attributes:nil];
            
        }else {
            arr1 =[[NSMutableArray  arrayWithContentsOfFile:filePahth] mutableCopy];
        }
        [arr1 insertObject:dic atIndex:0];
        [arr1 writeToFile:filePahth atomically:YES];
        [self mub:@"收藏成功"];
        return;
    }
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"取消收藏"]) {
        NSString *filePahth = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"shoucang.txt"];
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        arr2 =[NSMutableArray  arrayWithContentsOfFile:filePahth];
        
        for (NSDictionary *dic1 in arr2) {
            if ([[dic1 objectForKey:@"title"] isEqualToString:[dic objectForKey:@"title"]]) {
                
                self.navigationItem.rightBarButtonItem.title = @"收藏";
                [arr2 removeObject:dic1];
                [arr2 writeToFile:filePahth atomically:YES];
                
                [self mub:@"取消成功"];
                break;
            }else {
                [self mub:@"取消失败"];
            }
        }
        return;
    }
}

-(void)mub:(NSString *)label
{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = label;
    HUD.color = [UIColor whiteColor];
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示评论列表
- (void)tapToComments
{
    int num = [self.key.lblCommentCount.text intValue] ;
    NSLog(@"num=%d", num);
    if ([self.key.lblCommentCount.text intValue] > 0) {
        YTCommentsViewController *commentVC = [[YTCommentsViewController alloc]init];
        commentVC.listObj = self.listObj;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}
//在下部增加评论框
-(void) addDiscuss
{
    NSLog(@"addDiscuss...");
    //给文本框加
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }
    self.key.delegate=self;

    [self.key becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    
    int num = [self.key.lblCommentCount.text intValue] ;
    NSLog(@"num=%d",num);
    [self.view addSubview:self.key];
    self.key.lblCommentCount.text = self.listObj.discussnum;
    
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.textView.text = @"";
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    NSLog(@"keyboardHide");
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"我来说两句...";
        //[self.key removeFromSuperview];
    }];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    //接口请求
    NSString *content = contentView.text;
    
    [[YTDataManger shareDataManger] addItemDiscussAndTocken:@"" idcode:@"" itemid:self.itemid loginname:@"" content:content destView:self.contentWebView Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"addItemDiscussAndTocken error");
        } else {
            NSLog(@"addItemDiscussAndTocken succeed");
//            if (posts) {
//                [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[posts objectForKey:@"result"] objectForKey:@"infourl"]]]];
//            }
        }
    }];
    NSLog(@"keyBoardViewHide");
}

@end
