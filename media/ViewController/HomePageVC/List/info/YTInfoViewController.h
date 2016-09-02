//
//  YTInfoViewController.h
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "MQLCustomViewController.h"
#import "YTListObj.h"
#import "YcKeyBoardView.h"
@interface YTInfoViewController : MQLCustomViewController
//@property (weak, nonatomic) IBOutlet UIWebView *infoWebView;

@property(strong, nonatomic) NSString * titleForNav;
@property(strong, nonatomic) NSString * itemid;
@property(strong, nonatomic) NSString * infourl; //详情url
@property(strong, nonatomic) YTListObj * listObj;
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,strong)YcKeyBoardView *key;


@end
