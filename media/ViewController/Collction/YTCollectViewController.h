//
//  YTCollectViewController.h
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "MQLCustomViewController.h"
#import "YTshoucang.h"
#import "YTListObj.h"
@interface YTCollectViewController : MQLCustomViewController <UITableViewDataSource ,UITableViewDelegate>

@property(weak, nonatomic) IBOutlet UITableView * pMainTableView;
@property(strong, nonatomic) NSArray * pListArr;

@end
