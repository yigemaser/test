//
//  CommentsViewController.h
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//  评论列表

#import <UIKit/UIKit.h>
#import "MQLCustomViewController.h"
#import "YTModel.h"
#import "YTListObj.h"
#import "PullTableView.h"
@interface YTCommentsViewController : MQLCustomViewController <UITableViewDataSource,UITableViewDelegate,
    PullTableViewDelegate>
@property (readwrite, assign)   NSInteger numPage;
@property (nonatomic,strong)  NSMutableArray * commentArray;
@property (nonatomic,strong)  NSDictionary * resultDic;
@property (nonatomic, strong) YTListObj *listObj;//单元引用
//@property (nonatomic, strong) IBOutlet UITableView *tableView;
//@property (nonatomic, assign) BOOL isLoadData; // 是否成功加载过数据
@property (nonatomic, strong) IBOutlet PullTableView *tableViewList;
//@property (nonatomic, strong) PullTableView *tableViewList;
@property (nonatomic, assign) BOOL isLoadData; // 是否成功加载过数据
@end
