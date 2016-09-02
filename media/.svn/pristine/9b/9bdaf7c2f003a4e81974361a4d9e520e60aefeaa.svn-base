//
//  CommentsViewController.m
//  RSinaNews
//
//  Created by TY on 14-6-25.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "YTCommentsViewController.h"
#import "YTCommentCell.h"
#import "YTComment.h"
#import "ImageConstant.h"


@implementation YTCommentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.pListArray = [NSMutableArray arrayWithCapacity:20];
        self.commentArray = [NSMutableArray arrayWithCapacity:10];
        self.title = @"全部评论";
        self.numPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.commentArray = [NSMutableArray array];
    
    //返回按钮
    //UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[ImageConstant shareImage]navBack] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    [btn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] init];
    [leftBtn setCustomView:btn];

    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // Do any additional setup after loading the view from its nib.
    _tableViewList = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
     [_tableViewList  setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin];
    _tableViewList.dataSource=self;
    _tableViewList.delegate=self;
    [self.view addSubview:_tableViewList];
    _tableViewList.pullDelegate=self;
    
    _tableViewList.backgroundColor = [[YTUserHelper share] colorFromHexRGB:@"f0f0f0"];
    _tableViewList.tableFooterView = [UIView new];
    //[self loadListData];
    [self loadComment];
}
//加载评论
- (void)loadComment
{
    [[YTDataManger shareDataManger] getDiscussByItemidAndTocken:@"" itemid:_listObj.itemId page:1 size:10 destView:self.tableViewList Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"getDiscussByItemidAndTocken error");
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
                        YTComment * comment = [[YTComment alloc] init];
                        comment.discussid = [dic objectForKey:@"id"];
                        comment.createtime = [dic objectForKey:@"createtime"];
                        comment.content = [dic objectForKey:@"content"];
                        comment.loginname = [dic objectForKey:@"loginname"];
                        [self.commentArray addObject:comment];
                    }
                    [self refreshTable];
                    
                }
            }
        }
    }];

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
    [self.commentArray removeAllObjects];
    self.numPage = 1;
    [self loadComment];
    
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    //    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    self.numPage ++;
    [self loadMore];
    
}

//加载更多
- (void)loadMore
{
    [[YTDataManger shareDataManger] getDiscussByItemidAndTocken:@"" itemid:_listObj.itemId page:self.numPage size:10 destView:self.tableViewList Block:^(id posts, NSError *error) {
        if (error) {
            NSLog(@"getDiscussByItemidAndTocken error");
        } else {
            if (posts) {
                if ([[posts objectForKey:@"resultCode"] isEqualToString:@"2002"]) {
                    self.numPage --;
                    self.isLoadData = NO;
                    [self loadMoreDataToTable];
                } else if([[posts objectForKey:@"resultCode"] isEqualToString:@"0"]){
                    NSArray * arr =[posts objectForKey:@"result"];
                    for (NSDictionary *dic in arr) {
                        YTComment * comment = [[YTComment alloc] init];
                        comment.discussid = [dic objectForKey:@"id"];
                        comment.createtime = [dic objectForKey:@"createtime"];
                        comment.content = [dic objectForKey:@"content"];
                        comment.loginname = [dic objectForKey:@"loginname"];
                        [self.commentArray addObject:comment];
                    }
                    [self loadMoreDataToTable];
                }
            }
        }
    }];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCommentCellIdentifier = @"kCommentCellIdentifier";
    YTCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifier];
    if (commentCell == nil) {
        commentCell = [[YTCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentCellIdentifier];
    }
    YTComment *comment = [self.commentArray objectAtIndex:indexPath.row];
    commentCell.lblPubTime.text = comment.createtime;
    commentCell.textContent.text = comment.content;
    commentCell.lblNickName.text = comment.loginname;
    //改变textView的高度
    UITextView *tmpText = commentCell.textContent;
    //相差的高度
    CGFloat subHeight = comment.height-tmpText.frame.size.height;
    if (subHeight > 0) {//大于0说明内容多，以下视图变高/下移
        commentCell.textContent.frame = CGRectMake(commentCell.textContent.frame.origin.x, commentCell.textContent.frame.origin.y, commentCell.textContent.frame.size.width, commentCell.textContent.frame.size.height+subHeight);
        
        commentCell.centerView.frame = CGRectMake(commentCell.centerView.frame.origin.x, commentCell.centerView.frame.origin.y, commentCell.centerView.frame.size.width, commentCell.centerView.frame.size.height+subHeight);

    }
    return commentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTComment *comment = [self.commentArray objectAtIndex:indexPath.row];
    CGFloat subHeight = comment.height - 44;//44是textView的原始高度
    if (subHeight>0) {
        return 90 + subHeight;
    }else{
        return 90;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
