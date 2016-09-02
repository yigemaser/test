//
//  SUNListViewController.h
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-5.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"

#import "PullTableView.h"
#import "YTListObj.h"
#import "YTModel.h"
@protocol secdelegte <NSObject>

-(void) shownextVC:(YTListObj *)aDic;

@end

@interface SUNListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,PullTableViewDelegate>
{
//    PullTableView *_tableViewList;
    SUNSlideSwitchView *_slideSwitchView;
}

@property (nonatomic, strong) IBOutlet PullTableView *tableViewList;
@property (assign, nonatomic) id<secdelegte> secdelegate;
@property (nonatomic,strong)  NSMutableArray * pListArray;
@property (nonatomic,strong)  NSDictionary * resultDic;
@property (nonatomic, strong) NSString * isleaf;
@property (nonatomic, assign) BOOL advs;
@property (nonatomic, assign) BOOL isLoadData; // 是否成功加载过数据

- (void)viewDidCurrentView;

@end
