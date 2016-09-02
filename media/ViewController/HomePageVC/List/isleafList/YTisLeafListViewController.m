//
//  YTisLeafListViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-28.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTisLeafListViewController.h"
#import "YTListTableViewCell.h"
#import "YTInfoViewController.h"
#define xuanchunzuHeight self.view.bounds.size.height/3
@interface YTisLeafListViewController ()

@end

@implementation YTisLeafListViewController
{
        NSInteger numPage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setFanhui];
        self.pListArray = [NSMutableArray arrayWithCapacity:20];
        numPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableViewList = [[PullTableView alloc]initWithFrame:CGRectMake(0, 64, 320, 568) style:UITableViewStylePlain];
    _tableViewList.dataSource=self;
    _tableViewList.delegate=self;
    [self.view addSubview:_tableViewList];
    _tableViewList.pullDelegate=self;
    
     _tableViewList.backgroundColor = [[YTUserHelper share] colorFromHexRGB:@"f0f0f0"];
    _tableViewList.tableFooterView = [UIView new];
    [self loadListData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [self setCascTitle:self.titleForNav];
    self.advs = [[YTConfig shareConfig] isAdvs:_listId];
}


//获取目录列表
-(void)loadListData
{
    [self.pListArray removeAllObjects];
    if ([self.isleaf isEqualToString:@"0"]) {
        [[YTDataManger shareDataManger] getcategoryAndTocken:@"" idcode:@"" parent_id:_listId page:@"1" size:@"10" status:@"1" destView:_tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                        //无相关数据返回
                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
                        label.text = @"无相关数据返回";
                        [self.view addSubview:label];
                    } if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                        NSArray * arr = [posts objectForKey:@"result"];
                        for (NSDictionary * dic in arr) {
                            YTListObj * list = [YTListObj new];


                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
                            list.isleaf = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isleaf"]];
                            list.number = [dic objectForKey:@"number"];
                            list.titleLabel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryname"]];
                            [self.pListArray addObject:list];
                        }
                            [self refreshTable];
                    }
                    
                }
            }
        }];
    }else {
        [[YTDataManger shareDataManger] getItemByCategoryAndTocken:@"" categoryid:_listId page:1 size:10 status:@"0" destView:_tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                        //无相关数据返回
                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
                        label.text = @"无相关数据返回";
                        [self.view addSubview:label];
                    } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                        NSArray * arr =[posts objectForKey:@"result"];
                        for (NSDictionary *dic in arr) {
                            YTListObj * list = [YTListObj new];
                            list.contentByTrue = [dic objectForKey:@"intro"];
                            list.smallImgByTrue = [dic objectForKey:@"imageurl"];
                            list.titleLabel = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
                            list.timeByTrue = [dic objectForKey:@"uploadtime"];
                            list.itemId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
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
        [[YTDataManger shareDataManger] getcategoryAndTocken:@"" idcode:@"" parent_id:_listId page:[NSString stringWithFormat:@"%d",numPage] size:@"10" status:@"1" destView:_tableViewList Block:^(id posts, NSError *error) {
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
                        

                        [self loadMoreDataToTable];
                    }
                }
            }
        }];
    }else {
        [[YTDataManger shareDataManger] getItemByCategoryAndTocken:@"" categoryid:_listId page:numPage size:10 status:@"0" destView:_tableViewList Block:^(id posts, NSError *error) {
            if (error) {
                NSLog(@"getcategory error");
            } else {
                if (posts) {
                    if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                        //无相关数据返回
                        //                        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(110,300 , 200, 200)];
                        //                        label.text = @"无相关数据返回";
                        //                        [self.view addSubview:label];
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
                        
                        [self loadMoreDataToTable];
                        
                    }
                }
            }
        }];
    }
}

- (void)viewDidLayoutSubviews
{
    if (IS_IOS7) {
        _tableViewList.frame = CGRectMake(0, 0, 320, IS_IPHONE_5?568:480-64);
    }else{
        _tableViewList.frame = CGRectMake(0, 0, 320, IS_IPHONE_5?568:480-64);
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
    
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    //    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    numPage ++;
    
    [self jiazaigengDuo];
    
}

#pragma mark - 表格视图数据源代理方法

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, xuanchunzuHeight)];
    view1.backgroundColor = [UIColor blackColor];
    if (self.advs) {
        return view1;
    } else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.advs) {
        return 130;
    } else {
        return 0;
    }
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
        cell.backgroundColor = [UIColor clearColor];
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    if (self.pListArray.count != 0) {
        YTListObj * list =[self.pListArray objectAtIndex:indexPath.row];
        if ([self.isleaf isEqualToString:@"1"]) {
            [cell cellForRow:list];
            cell.lineByTrue.frame = CGRectMake(4, 69, 310, 1);
        cell.smallImgByTrue.frame = CGRectMake(IS_IOS7?5:5, 7, 80, 60);

        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell cellForRowByFalse:list];
        }

    }
     return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YTListObj * list = [self.pListArray objectAtIndex:indexPath.row ];
    NSString * str =[NSString stringWithFormat:@"%@",self.isleaf];
    if ([str isEqualToString:@"1"]) {
        YTInfoViewController * infoVC = [[YTInfoViewController alloc] initWithNibName:@"YTInfoViewController" bundle:nil];
        infoVC.titleForNav = list.titleLabel;
        infoVC.itemid = list.itemId;
        infoVC.listObj = list;
        [self.navigationController pushViewController:infoVC animated:YES];
        
    } else {
        
        YTisLeafListViewController * vc = [[YTisLeafListViewController alloc] initWithNibName:@"YTisLeafListViewController" bundle:nil];
        vc.titleForNav = list.titleLabel;
        vc.listId = [NSString stringWithFormat:@"%@",list.itemId];
        vc.isleaf = [NSString stringWithFormat:@"%@",list.isleaf];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
