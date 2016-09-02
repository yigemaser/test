//
//  YTHomePageViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTHomePageViewController.h"
#import "YTCategory.h"
#import "YTInfoViewController.h"
#import "YTisLeafListViewController.h"

@interface YTHomePageViewController () <secdelegte>

@end

@implementation YTHomePageViewController
{
    NSString * strIsleaf;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.VCarr = [[NSMutableArray alloc] init];
        self.categoryNameArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self firstRequest];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}


-(void)checkVersion {
    NSString * verNum = [[YTConfig shareConfig].configDic objectForKey:@"versionnum"];
    [[YTDataManger shareDataManger] checkVesionTocken:@"" versionnum:verNum   block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"checkVersion error");
            return ;
        }
        if (posts) {

            [YTConfig shareConfig].needUpdate = [[NSString stringWithFormat:@"%@",[posts objectForKey:@"needupdate"]] boolValue];
            [YTConfig shareConfig].VersionUrl11 = [NSString stringWithFormat:@"%@",[posts objectForKey:@"applejailbreakdownloadurl"]];
            [YTConfig shareConfig].contentUpdate = [NSString stringWithFormat:@"%@",[posts objectForKey:@"updatecontent"]];
            [self.slideSwitchView buildUI];
        }
    }];
}

-(void)firstRequest
{
    [[YTDataManger shareDataManger] getcategoryAndTocken:@"" idcode:@"" parent_id:@"0" page:@"1" size:@"10" status:@"0" destView:self.view Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"getcategory error");
            return ;
        }
        if (posts) {
            NSDictionary * dic = posts;
            [YTCategory categoryFromDictionary:[dic objectForKey:@"result"]];
            [self loadConfigByConfig:[dic objectForKey:@"result"]];

        }
    }];
}

-(void)loadConfigByConfig:(NSArray *)arr
{
    //获取项目版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    //客户端操作系统版本号
    [[YTDataManger shareDataManger] getCongifAndTocken:@"" idcode:@"" aver:[[UIDevice currentDevice] systemVersion] cver:version destView:nil Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"get Congif error");
        } else {
            if (posts) {
                
                NSDictionary * dic = [posts objectForKey:@"result"];
                [YTConfig shareConfig].logourl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"logourl"]];
                [YTConfig shareConfig].version = [NSString stringWithFormat:@"%@",[dic objectForKey:@"version"]];
                [YTConfig shareConfig].shopqrcode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shopqrcode"]];
                [YTConfig shareConfig].email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
                [YTConfig shareConfig].telephone =[NSString stringWithFormat:@"%@",[ dic objectForKey:@"telephone"]];
                [YTConfig shareConfig].status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                [YTConfig shareConfig].servicetel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"servicetel"]];
                [YTConfig shareConfig].advsArr = [dic objectForKey:@"advs"];
                [self createScroolForTap:arr];
                
            }
        }
    }];
}
-(void)createScroolForTap:(NSArray*)cateArray
{
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"666666"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"2b64c0"];
    
    
    //图片不可拉伸区域
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"nav_bg.png"]
                                            stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    self.slideSwitchView.shadowImage = [UIImage imageNamed:@"nav_bg.png"];

    if(cateArray.count == 0)
    {
        return;
    }
    for (int i = 0; i <cateArray.count; i ++)
    {
        SUNListViewController *vc = [[SUNListViewController alloc] init];
        vc.secdelegate = self;
        NSString *titleStr = [[cateArray objectAtIndex:i] objectForKey:@"categoryname"];
        vc.title = titleStr;
        vc.resultDic = [cateArray objectAtIndex:i];
        vc.advs = [[YTConfig shareConfig] isAdvs:[[cateArray objectAtIndex:i] objectForKey:@"categoryid"]];
        vc.isLoadData = NO;
        [self.VCarr addObject:vc];
    }
    [self checkVersion];
    
}

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return self.VCarr.count;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return [self.VCarr objectAtIndex:number];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    SUNListViewController *vc = nil;
    vc = [self.VCarr objectAtIndex:number];
    vc.advs = [[YTConfig shareConfig] isAdvs:[vc.resultDic objectForKey:@"id"]];
    [vc viewDidCurrentView];
}

-(void) shownextVC:(YTListObj *)aDic
{
    NSString * str =[NSString stringWithFormat:@"%@",aDic.supIsleaf];
    if ([str isEqualToString:@"(null)"]) {
        str = @"1";
    }
    if ([str isEqualToString:@"1"]) {
        YTInfoViewController * infoVC = [[YTInfoViewController alloc] initWithNibName:@"YTInfoViewController" bundle:nil];
        infoVC.titleForNav = aDic.titleLabel;
        infoVC.itemid = [NSString stringWithFormat:@"%@",aDic.itemId];
        infoVC.infourl = aDic.infourl;
        infoVC.listObj = aDic;
        [self.navigationController pushViewController:infoVC animated:YES];
    } else {
        YTisLeafListViewController * vc = [[YTisLeafListViewController alloc] initWithNibName:@"YTisLeafListViewController" bundle:nil];
        vc.titleForNav = aDic.titleLabel;
        vc.listId = [NSString stringWithFormat:@"%@",aDic.itemId];
        vc.isleaf = [NSString stringWithFormat:@"%@",aDic.isleaf];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
