//
//  YTAppDelegate.h
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyTabBarController.h"
#import "YTqidongtuViewController.h"
@interface YTAppDelegate : UIResponder <UIApplicationDelegate,retHomeDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) LeveyTabBarController *leveyTabBarController;

@end
