//
//  YTMoreViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTMoreViewController.h"
#import "map/YTMapViewController.h"
#import "YTAboutViewController.h"
@interface YTMoreViewController ()
@property (nonatomic,strong)IBOutlet UIView * viewBG;
@end

@implementation YTMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setCascTitle:@"  更多"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    self.viewBG.frame = CGRectMake(10, IS_IOS7?64:0, 300, 174);
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}



- (IBAction)clearCache:(id)sender {
}
- (IBAction)hotLines:(id)sender {
    NSString * str = [NSString stringWithFormat:@"秀mi媒体竭诚为您服务\n%@",[YTConfig shareConfig].servicetel];
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 100;
    
//    UIView * additonBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alert.frame.size.width-30, alert.frame.size.height-20)];
//    additonBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loveChina.png"]];
//    
//#if TARGET_IPHONE_SIMULATOR
//    [alert insertSubview:additonBackgroundView atIndex:1];
//#else
//    [alert insertSubview:additonBackgroundView atIndex:0];
//#endif
    [alert show];
    
}
- (void)willPresentAlertView:(UIAlertView *)alertView {
    
    // 遍历 UIAlertView 所包含的所有控件
    
    for (UIView *tempView in alertView.subviews) {
        

        if ([tempView isKindOfClass:[UILabel class]]) {
            
            // 当该控件为一个 UILabel 时
            
            UILabel *tempLabel = (UILabel *) tempView;
            

            if ([tempLabel.text isEqualToString:alertView.message]) {
                
                // 调整对齐方式
                
//                tempLabel.textAlignment = UITextAlignmentLeft;
//                
//                // 调整字体大小
//                
//                [tempLabel setFont:[UIFont systemFontOfSize:15.0]];
                tempLabel.textColor = [UIColor whiteColor];
                
            }
        }
        if ([tempView isKindOfClass:[UIImage class]]) {
            
        }
        
    }
    
}

- (IBAction)map:(id)sender {
    if ([[YTConfig shareConfig].lat isEqualToString:@""] || [[YTConfig shareConfig].lng isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无相关商店地理位置信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    YTMapViewController * mapVC = [[YTMapViewController alloc] initWithNibName:@"YTMapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (IBAction)about:(id)sender {
    YTAboutViewController * aboutVC = [[YTAboutViewController alloc] initWithNibName:@"YTAboutViewController" bundle:nil];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

#pragma mark
#pragma mark UIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 100 && buttonIndex == 1) {
        NSString * strTel = [NSString stringWithFormat:@"tel://%@",[YTConfig shareConfig].servicetel];
//        UIWebView*callWebview =[[UIWebView alloc] init];
//        
//        NSURL *telURL =[NSURL URLWithString:strTel];// 貌似tel:// 或者 tel: 都行
//        
//        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
//        
//        //记得添加到view上
//        
//        
//        
//        [self.view addSubview:callWebview];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strTel]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
