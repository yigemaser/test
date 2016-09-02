//
//  SUNListViewController.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-5.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNListViewController.h"
#import "YTCategory.h"
#import "YTListTableViewCell.h"
#import "YTInfoViewController.h"
#import "PullTableView.h"

#define xuanchunzuHeight 170
static NSArray * arr;

@interface SUNListViewController ()
{
    NSMutableArray *xuanArray;
    NSString * versionUrl;

}
@property (strong, nonatomic) UIScrollView *imageScrollView;
@property (strong, nonatomic) UILabel *content;
@property (strong, nonatomic) UIPageControl *pagecontrol;
@end

@implementation SUNListViewController
{
    NSInteger numPage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      self.pListArray = [NSMutableArray arrayWithCapacity:20];
        xuanArray = [[NSMutableArray alloc] init];
         [_tableViewList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableViewList.backgroundColor = [[YTUserHelper share] colorFromHexRGB:@"f0f0f0"];


}

- (void)viewDidCurrentView
{
    self.isleaf = [NSString stringWithFormat:@"%@",[self.resultDic objectForKey:@"isleaf"]];

    _tableViewList.tableFooterView = [UIView new];
   
    numPage = 1;
    
    self.tableViewList.backgroundView = nil;
    self.tableViewList.pullBackgroundColor = [UIColor clearColor];
    self.tableViewList.pullTextColor = [UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0];
  
//    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollTimer1) userInfo:nil repeats:YES];
    
    if (!self.isLoadData) {
         [self loadListData];
        if (self.advs) {
            [self getPromotionByGroupid];
        }
    }
        [self checkVersion];
}

- (void)viewDidLayoutSubviews
{
    if (IS_IOS7) {
        _tableViewList.frame = CGRectMake(0, 0, 320, IS_IPHONE_5?568-64-44:480);
    }else{
        _tableViewList.frame = CGRectMake(0, 0, 320, IS_IPHONE_5?568-64-44:480-64-44);
    }
}
//获取宣传组信息
-(void)getPromotionByGroupid
{
    [xuanArray removeAllObjects];
    NSInteger b = [[YTConfig shareConfig].groupid intValue];
    [[YTDataManger shareDataManger] getPromotionByGroupidAndTocken:@"" groupid:b destView:self.tableViewList Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"getPromotionByGroupid error");
            self.isLoadData = NO;
        } else {
            if (posts) {
                if (posts == nil) {
                    self.isLoadData = NO;
                }
                 NSArray * arr = [posts objectForKey:@"result"];

                for (NSDictionary * dic in arr) {
                    YTxuanchuanzu * xuanchuan = [YTxuanchuanzu new];
                    xuanchuan.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
                    xuanchuan.imageUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"imageurl"]];
                    xuanchuan.itemid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"itemid"]];
                    [xuanArray addObject:xuanchuan];
                    self.isLoadData = YES;
                }
               
                [_tableViewList reloadData];
            }
        }
    }];
}
//获取目录列表
-(void)loadListData
{
    [self.pListArray removeAllObjects];
    if (![self.isleaf isEqualToString:@"1"]) {
        NSString * str = [NSString stringWithFormat:@"%@",[self.resultDic objectForKey:@"id"]];
        [[YTDataManger shareDataManger] getcategoryAndTocken:@"" idcode:@"" parent_id:str page:@"1" size:@"10" status:@"1" destView:self.tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
                self.isLoadData = NO;
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
//                        //无相关数据返回
//                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
//                        label.text = @"无相关数据返回";
//
//                        [self.view addSubview:label];
                        self.isLoadData = NO;
                    } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                        
                        self.isLoadData = YES;
                        NSArray * arr = [posts objectForKey:@"result"];
                        for (NSDictionary * dic in arr) {
                            YTListObj * list = [[YTListObj alloc] init];
                            list.titleLabel = [dic objectForKey:@"categoryname"];
                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                            list.isleaf = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isleaf"]];
                            list.supIsleaf = self.isleaf;
                            list.number = [dic objectForKey:@"number"];
                            [self.pListArray addObject:list];
                        }
                         [self refreshTable];
                        
                       
                    }
                }
            }
        }];
    }else {
        [[YTDataManger shareDataManger] getItemByCategoryAndTocken:@"" categoryid:[self.resultDic objectForKey:@"id"] page:1 size:10 status:@"0" destView:self.tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                        //无相关数据返回
//                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
//                        label.text = @"无相关数据返回";
//                        [self.view addSubview:label];
                        self.isLoadData = NO;
                    } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){

                        NSArray * arr =[posts objectForKey:@"result"];
                        for (NSDictionary *dic in arr) {
                             YTListObj * list = [[YTListObj alloc] init];
                            list.titleLabel = [dic objectForKey:@"title"];
                            list.contentByTrue = [dic objectForKey:@"intro"];
                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.infourl = [dic objectForKey:@"infourl"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                            list.discussnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discussnum"]];
                            [self.pListArray addObject:list];
                        }
 
                        self.isLoadData = YES;
                        [self refreshTable];

                    }
                }
            }
        }];
    }

}

-(void)jiazaigengDuo
{
//    [self.pListArray removeAllObjects];
    if (![self.isleaf isEqualToString:@"1"]) {
            NSString * str = [NSString stringWithFormat:@"%@",[self.resultDic objectForKey:@"id"]];
        [[YTDataManger shareDataManger] getcategoryAndTocken:@"" idcode:@"" parent_id:str page:[NSString stringWithFormat:@"%d",numPage] size:@"10" status:@"1" destView:self.tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
//                        //无相关数据返回
//                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
//                        label.text = @"无相关数据返回";
//                       
//                        [self.view addSubview:label];
                        self.isLoadData = NO;
                         [self loadMoreDataToTable];
                        
                    } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                        self.isLoadData = YES;
                        NSArray * arr = [posts objectForKey:@"result"];
                        for (NSDictionary * dic in arr) {
                            YTListObj * list = [[YTListObj alloc] init];
                            list.titleLabel = [dic objectForKey:@"categoryname"];
                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                            list.isleaf = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isleaf"]];
                            list.supIsleaf = self.isleaf;
                            list.number = [dic objectForKey:@"number"];
                            [self.pListArray addObject:list];
                        }
                        
                        [self.tableViewList reloadData];
                        [self loadMoreDataToTable];
                    }
                }
            }
        }];
    }else {
        [[YTDataManger shareDataManger] getItemByCategoryAndTocken:@"" categoryid:[self.resultDic objectForKey:@"id"] page:numPage size:10 status:@"0" destView:self.tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
                self.isLoadData = NO;
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                        //无相关数据返回
//                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
//                        label.text = @"无相关数据返回";
//                        [self.view addSubview:label];
                        self.isLoadData = NO;
                        [self loadMoreDataToTable];
                    } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                        
                        NSArray * arr =[posts objectForKey:@"result"];
                        for (NSDictionary *dic in arr) {
                            YTListObj * list = [[YTListObj alloc] init];
                            list.titleLabel = [dic objectForKey:@"title"];
                            list.contentByTrue = [dic objectForKey:@"intro"];
                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.infourl = [dic objectForKey:@"infourl"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                            list.discussnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"discussnum"]];
                            [self.pListArray addObject:list];
                        }
                        
                        self.isLoadData = YES;
                        
                        [self.tableViewList reloadData];
                        [self loadMoreDataToTable];
                        
                    }
                }
            }
        }];
    }
}

#pragma mark - 表格视图数据源代理方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * customHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, xuanchunzuHeight)];
    [customHeaderView setBackgroundColor:[UIColor clearColor]];
    if (self.advs) {
        if (xuanArray.count !=0) {

            [customHeaderView setBackgroundColor:[UIColor colorWithRed:254.0f/255 green:254.0f/255 blue:249.0f/255 alpha:1]];
            self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, xuanchunzuHeight)];
            self.imageScrollView.showsVerticalScrollIndicator = NO;

            self.imageScrollView.delegate = self;
            
            
            CGSize newSize = CGSizeMake(self.imageScrollView.frame.size.width*xuanArray.count, self.imageScrollView.frame.size.height);
            [self.imageScrollView setContentSize:newSize];
            self.imageScrollView.pagingEnabled = YES;
            

            for (int i =0; i<[xuanArray count]; i++)
            {

                YTxuanchuanzu * xuan = [xuanArray objectAtIndex:i];
                
                UIImageView *view = [[UIImageView alloc]init];
                view.userInteractionEnabled = YES;
                [view setImageWithURL:[NSURL URLWithString:xuan.imageUrl]];
                [view setFrame:CGRectMake(self.imageScrollView.frame.size.width*i,0,self.imageScrollView.frame.size.width,  xuanchunzuHeight)];
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnXuanchuanClick)];
                [view addGestureRecognizer:tap];
                
                [self.imageScrollView addSubview:view];
                
                //content title
                UILabel * laebl = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 40,320, 45)];
                laebl.font = [UIFont systemFontOfSize:14];
                laebl.text = xuan.title;
                laebl.textAlignment = NSTextAlignmentCenter;
                [laebl setBackgroundColor:[UIColor clearColor]];
                [laebl setTextColor:[UIColor whiteColor]];
                
                [view addSubview:laebl];
            }
            [customHeaderView addSubview:self.imageScrollView];
            
            //pageControl init
            if (xuanArray.count !=1) {
                self.pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(120, 115, 72, 37)];
                [self.pagecontrol setCurrentPage:0];
                [self.pagecontrol setNumberOfPages:xuanArray.count];
                [self.pagecontrol setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
                [self.pagecontrol setPageIndicatorTintColor:[UIColor colorWithRed:157.0f/255 green:157.0f/255 blue:157.0f/255 alpha:1]];
                
                [self.pagecontrol addTarget:self action:@selector(pageControlDidChange) forControlEvents:UIControlEventValueChanged];
                [customHeaderView addSubview:self.pagecontrol];
            }
        }
        return customHeaderView;
    } else {
        return nil;
    }
}

-(void)btnXuanchuanClick
{
    if (self.secdelegate && [self.secdelegate respondsToSelector:@selector(shownextVC:)])
    {
        if (xuanArray.count == 0) {
            NSLog(@"xuanchuanzu count ==0");
            return;
        }
        YTxuanchuanzu *xuanchuan = [xuanArray objectAtIndex:self.pagecontrol.currentPage];
        YTListObj * list = [YTListObj new];
        list.titleLabel = xuanchuan.title;
        list.itemId = xuanchuan.itemid;
        list.smallImgByTrue = xuanchuan.imageUrl;
        [self.secdelegate shownextVC:list];
        
    }
}
-(void)scrollTimer1
{
    if (xuanArray.count != 1) {
        if (self.pagecontrol.currentPage == xuanArray.count  ) {
            self.pagecontrol.currentPage = 0;
        }
        
        [self.imageScrollView setContentOffset:CGPointMake(320 * self.pagecontrol.currentPage, 0) animated:YES];

    }
    
}

-(void)pageControlDidChange
{
    CGRect frame = self.imageScrollView.frame;
    frame.origin.x = frame.size.width*self.pagecontrol.currentPage;
    frame.origin.y = 0;
    [self.imageScrollView scrollRectToVisible:frame animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger picPage = fabs(self.imageScrollView.contentOffset.x)/self.imageScrollView.frame.size.width;
    self.pagecontrol.currentPage = picPage;
    

}
#pragma mark
#pragma mark UITableViewDataSouce
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.advs) {
        return xuanchunzuHeight;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.pListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *ListViewCellId = @"xuanchuanzu";
    YTListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ListViewCellId];

    if (cell == nil) {
        if ([self.isleaf isEqualToString:@"1"]) {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"YTListTableViewCell" owner:self options:nil] firstObject];
           
        } else {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"YTListTableViewCell" owner:self options:nil] lastObject];
        }

        if (!IS_IOS7) {
            UIView *tempView = [[UIView alloc] init];
            tempView.backgroundColor = [UIColor clearColor];
            [cell setBackgroundView:tempView];
            [cell setBackgroundColor:[UIColor clearColor]];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.pListArray.count != 0) {
        if ([self.isleaf isEqualToString:@"1"]) {
            YTListObj * list =[self.pListArray objectAtIndex:indexPath.row];
            cell.lineByTrue.frame = CGRectMake(IS_IOS7?5:2, 69, IS_IOS7?306:295, 1);
            cell.smallImgByTrue.frame = CGRectMake(IS_IOS7?5:0, 7, 80, 60);
            [cell cellForRow:list];
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            YTListObj * list =[self.pListArray objectAtIndex:indexPath.row];
            cell.lineByFalse.frame = CGRectMake(IS_IOS7?5:2, 69, IS_IOS7?306:295, 1);
            cell.SmallImgByFalse.frame = CGRectMake(IS_IOS7?5:0, 7, 80, 60);
            [cell cellForRowByFalse:list];
        }
    }
        return  cell;
}
//有宣传组
-(void)advsIsEqualYes
{
    
}

-(void)checkVersion {

    BOOL update = [YTConfig shareConfig].needUpdate;
    NSString *updateContent = [YTConfig shareConfig].contentUpdate;
    NSMutableString *title = [[YTConfig shareConfig].shopTitle mutableCopy];
    NSString * titleForAlert = [title stringByAppendingString:@"已经发布了新版本"];
    if (update) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleForAlert message:updateContent delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
        alert.tag = 1234;
        [alert show];
        versionUrl = [YTConfig shareConfig].VersionUrl11;
        [YTConfig shareConfig].needUpdate = NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1234 && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionUrl]];
    }
    if (alertView.tag == 1234 && buttonIndex == 0) {
        
    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.secdelegate && [self.secdelegate respondsToSelector:@selector(shownextVC:)])
    {
       YTListObj * list = [self.pListArray objectAtIndex:indexPath.row];

        [self.secdelegate shownextVC:list ];
    }
}
#pragma mark - Refresh and load more methods
- (void) refreshTable
{
    /*
     Code to actually refresh goes here.
     */
    
    [self.tableViewList reloadData];
    
    self.tableViewList.pullLastRefreshDate = [NSDate date];
    self.tableViewList.pullTableIsRefreshing = NO;
}
- (void) loadMoreDataToTable
{
    /*
     Code to actually load more data goes here.
     */
    
    [self.tableViewList reloadData];
    
    self.tableViewList.pullTableIsLoadingMore = NO;
    
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    //    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    numPage = 1;
    [self loadListData];
    [self getPromotionByGroupid];
    
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    //    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
        numPage ++;

        [self jiazaigengDuo];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
