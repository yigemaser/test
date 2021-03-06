//
//  YTAppDelegate.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTAppDelegate.h"
#import "YTHomePageViewController.h"
#import "CustomNavViewController.h"
#import "YTMoreViewController.h"
#import "YTCollectViewController.h"
#import "YTConfig.h"
#import "YTweijihuoViewController.h"

@implementation YTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    [self loadConfigByConfig:nil];
    
    return YES;
}

- (void)retHome
{
    [self createTabbar];
}

-(void)createTabbar
{
    if ([[YTConfig shareConfig].status isEqualToString:@"1"]) {
        YTHomePageViewController * homePageVC = [[YTHomePageViewController alloc] initWithNibName:@"YTHomePageViewController" bundle:nil];
        CustomNavViewController * nav = [[CustomNavViewController alloc] initWithRootViewController:homePageVC];
        YTCollectViewController * personVC = [[YTCollectViewController alloc] initWithNibName:@"YTCollectViewController" bundle:nil];
        CustomNavViewController * personNav = [[CustomNavViewController alloc] initWithRootViewController:personVC];
        
        YTMoreViewController * moreVC = [[YTMoreViewController alloc] initWithNibName:@"YTMoreViewController" bundle:nil];
        CustomNavViewController * moreNav = [[CustomNavViewController alloc] initWithRootViewController:moreVC];
        NSArray *ctrlArr = [NSArray arrayWithObjects:nav,personNav,moreNav, nil];
        
        NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic setObject:[UIImage imageNamed:@"shouye@2x.png"] forKey:@"Default"];
        [imgDic setObject:[UIImage imageNamed:@"shouye_press@2x.png"] forKey:@"Seleted"];
        
        NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic2 setObject:[UIImage imageNamed:@"shoucang@2x.png"] forKey:@"Default"];
        [imgDic2 setObject:[UIImage imageNamed:@"shoucang_press@2x.png"] forKey:@"Seleted"];
        
        NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:3];
        [imgDic4 setObject:[UIImage imageNamed:@"gengduo@2x.png"] forKey:@"Default"];
        [imgDic4 setObject:[UIImage imageNamed:@"gengduo_press@2x.png"] forKey:@"Seleted"];
        
        NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic2,imgDic4,nil];
        
        self.leveyTabBarController = [[LeveyTabBarController alloc] initWithViewControllers:ctrlArr imageArray:imgArr];
        self.leveyTabBarController.logindelegate = (id)self;
        
        self.leveyTabBarController.view.frame = CGRectMake(0, 0, 320, (IS_IPHONE_5 ? 568:480));
        [self.leveyTabBarController setTabBarTransparent:YES];

        self.window.rootViewController = self.leveyTabBarController;
        
    }else {
        YTweijihuoViewController * weijihuoVC = [[YTweijihuoViewController alloc] initWithNibName:@"YTweijihuoViewController" bundle:nil];
        if ([[YTConfig shareConfig].status isEqualToString:@"2"]) {
            weijihuoVC.status = @"您的商店处于审查中";
        }else {
            weijihuoVC.status = @"您的商店处于禁用状态";
        }
        self.window.rootViewController = weijihuoVC;
    }
}

//加载本地html配置文件
-(void)loadLocalConfig{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSString *str = [[NSString alloc] initWithData:
                     [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!error) {
        NSString *res = [jsonData objectForKey:@"resultCode"];
        if ([res isEqualToString:@"0"]) {
            [YTConfig shareConfig].configDic = [jsonData objectForKey:@"result"];
        }else{
        }
    }else{
        
    }
}

-(void)loadConfigByConfig:(NSArray *)arr
{
    //获取项目版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    //客户端操作系统版本号
    [[YTDataManger shareDataManger] getCongifAndTocken:@"" idcode:@"" aver:[[UIDevice currentDevice] systemVersion] cver:version destView:nil Block:^(id posts, NSError *error) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 250, 100)];
        label.font = [UIFont systemFontOfSize:13.0f];
        if (error) {
            self.window.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refrshMethond)];
            [self.window addGestureRecognizer:tap];
            label.text = @"加载配置文件失败，点击重新加载";
            label.hidden = NO;
            [self.window addSubview:label];
        } else {
            if (posts) {
                label.hidden = YES;
                NSDictionary * dic = [posts objectForKey:@"result"];
                [YTConfig shareConfig].logourl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"logourl"]];
                [YTConfig shareConfig].version = [NSString stringWithFormat:@"%@",[dic objectForKey:@"version"]];
                [YTConfig shareConfig].shopqrcode = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shopqrcode"]];
                [YTConfig shareConfig].email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
                [YTConfig shareConfig].telephone =[NSString stringWithFormat:@"%@",[ dic objectForKey:@"telephone"]];
                [YTConfig shareConfig].status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                [YTConfig shareConfig].servicetel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"servicetel"]];
                [YTConfig shareConfig].advsArr = [dic objectForKey:@"advs"];
                [YTConfig shareConfig].lat = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lat"]];
                [YTConfig shareConfig].lng = [NSString stringWithFormat:@"%@",[dic objectForKey:@"lng"]];
                [YTConfig shareConfig].startupimageUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"startupimage"]];
                [YTConfig shareConfig].address = [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
//                [self createTabbar];
                [YTConfig shareConfig].shopTitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shoptitle"]];
                YTqidongtuViewController * vcQidong = [YTqidongtuViewController new];
                vcQidong.delegate = self;
                self.window.rootViewController = vcQidong;

            }
            
        }
    }];
}

-(void)refrshMethond
{
    [self loadConfigByConfig:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
