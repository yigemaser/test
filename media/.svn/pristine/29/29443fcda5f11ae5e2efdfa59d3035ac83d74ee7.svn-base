//
//  MQLCustomViewController.m
//  Casc
//
//  Created by uustock1 on 14-6-18.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "MQLCustomViewController.h"
#import "LeveyTabBarController.h"
@interface MQLCustomViewController ()

@end

@implementation MQLCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)setCascTitle:(NSString*)title{
    
    NSArray*titleArray=[title componentsSeparatedByString:@""];
    if (titleArray.count) {
        UIView*vc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 44)];
        vc.backgroundColor=[UIColor clearColor];
        
        UILabel *upLabel=[[UILabel alloc]initWithFrame:CGRectMake(-5, 10, 220, 20)];
        upLabel.textColor= [[YTUserHelper share] colorFromHexRGB:@"666666"];
        upLabel.font=[UIFont boldSystemFontOfSize:19];
        upLabel.backgroundColor=[UIColor clearColor];
        upLabel.textColor = [UIColor blackColor];
        upLabel.textAlignment=NSTextAlignmentCenter;
        [vc addSubview:upLabel];
        upLabel.text=[titleArray objectAtIndex:0];
        self.navigationItem.titleView=vc;
    }
}
-(void) setFanhui
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
    [leftBtn setCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
}
-(void)fanhuiBtn
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_top@2x.png"] forBarMetrics:UIBarMetricsDefault];

   
    self.view.backgroundColor = [[YTUserHelper share] colorFromHexRGB:@"F0F0F0"];
//    self.leveyTabBarController.delegate = (id)self;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}
- (void)viewWillLayoutSubviews
{
    if (!IS_IOS7) {
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, 320, 44);
        self.view.frame = CGRectMake(0, -20, 320, 568);
    }
    
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    self.view.frame = CGRectMake(0, -20, 320, 568);
//
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
