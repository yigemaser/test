//
//  YTCollectViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTCollectViewController.h"
#import "YTListTableViewCell.h"
#import "YTInfoViewController.h"
@interface YTCollectViewController ()

@end

@implementation YTCollectViewController
{
    UILabel * label;
    UIImageView * img;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setCascTitle:@"我的收藏"];
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]initWithTitle:@"管理"style:UIBarButtonItemStyleBordered target:self action:@selector(deleteAction)];
        self.navigationItem.rightBarButtonItem = deleteButton;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pListArr = [[NSArray alloc] initWithObjects:@"1",@"1", nil];
    self.pMainTableView.tableFooterView = [[UIView alloc]init];
    [self.pMainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.leveyTabBarController.delegate = (id)self;

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"shoucang.txt"];
    [YTshoucang share].shoucangArr = [NSMutableArray  arrayWithContentsOfFile:filePath];

    [self.pMainTableView reloadData];
    
}
#pragma mark
#pragma mark LIFE CYCLE
- (void)viewDidLayoutSubviews
{
    if (!IS_IOS7) {
        self.pMainTableView.frame = CGRectMake(0, 0, 320, IS_IPHONE_5?568:480 - 64 - 44);
    }

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
- (BOOL)tabBarController:(LeveyTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    [viewController viewWillAppear:YES];
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([YTshoucang share].shoucangArr.count == 0) {
        [self alertView:NO];
    } else {
        [self alertView:YES];
    }
    return [YTshoucang share].shoucangArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *ListViewCellId = @"xuanchuanzu";
    YTListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ListViewCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YTListTableViewCell" owner:self options:nil] firstObject];

        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([YTshoucang share].shoucangArr.count != 0) {
        YTListObj * list = [YTListObj new];
        NSDictionary * dic1 = [[YTshoucang share].shoucangArr objectAtIndex:indexPath.row];
        list.titleLabel = [dic1 objectForKey:@"title"];
        list.smallImgByTrue = [dic1 objectForKey:@"imageurl"];
        list.contentByTrue = [dic1 objectForKey:@"content"];
        list.timeByTrue = [self returnTheTimelabel:[dic1 objectForKey:@"time"]];
        [cell cellForRowByCollction:list];
        cell.smallImgByTrue.frame = CGRectMake(3, cell.smallImgByTrue.frame.origin.y, cell.smallImgByTrue.frame.size.width, cell.smallImgByTrue.frame.size.height);
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTInfoViewController * infoVC = [YTInfoViewController new];
    NSDictionary * dic1 = [[YTshoucang share].shoucangArr objectAtIndex:indexPath.row];
    YTListObj * obj = [YTListObj new];
    obj.titleLabel = [dic1 objectForKey:@"title"];
    obj.contentByTrue = [dic1 objectForKey:@"content"];
    
    infoVC.titleForNav =[dic1 objectForKey:@"title"];
    infoVC.itemid = [dic1 objectForKey:@"itemid"];
    infoVC.listObj = obj;
    [self.navigationController pushViewController:infoVC animated:YES];
}
-(NSString*)returnTheTimelabel:(NSDate*)theTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//    NSDate * d = [dateFormatter dateFromString:theTime];
    
    NSDate *now = [[NSDate alloc]init];
    //    NSDate *now =[NSDate dateWithTimeInterval:3600*8 sinceDate:now1];

    NSTimeInterval late = [now timeIntervalSinceDate:theTime];
    NSString *returnStr ;
    if(late<3600)
    {
        if ((int)(late/60) == 0 )
        {
            returnStr = @"刚刚";
        }else
        {
            returnStr = [NSString stringWithFormat:@"%i分前",(int)(late/60)];
        }
    }
    else if(late>=3600&&late<3600*24) {
        returnStr = [NSString stringWithFormat:@"%i小时前",(int)(late/3600)];
    }
    else if(late>=3600*24&&late<3600*48)
    {
        returnStr = [NSString stringWithFormat:@"昨天"];
    }
    else
    {
        //NSDateFormatter *dateFormatter1 =[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSString *returnYear = [dateFormatter stringFromDate:theTime];
        NSString *nowReturnYear = [dateFormatter stringFromDate:now];
        //        NSLog(@"%@~~~~ %@",returnYear,nowReturnYear);
        
        if([returnYear isEqualToString:nowReturnYear])
        {
            [dateFormatter setDateFormat:@"MM-dd"];
            
            returnStr = [dateFormatter stringFromDate:theTime];
        }
        else
        {
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            returnStr = [dateFormatter stringFromDate:theTime];
        }
    }
    return returnStr;
}

-(void)alertView:(BOOL)isHidden
{
    if (label == nil) {
        img = [[UIImageView alloc] initWithFrame:CGRectMake(115, IS_IOS7?200:100, 100,100)];
        img.image = [UIImage imageNamed:@"cang_icon.png"];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:img];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(110, IS_IOS7?270:170, 150, 100)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [[YTUserHelper share] colorFromHexRGB:@"737373"];
        label.text = @"暂无收藏内容";
        [self.view addSubview:label];
    }
    if (isHidden) {
        label.hidden = YES;
        img.hidden = YES;
    }else {
        label.hidden = NO;
        img.hidden = NO;
    }
}

/*改变删除按钮的title*/
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

// 单行侧滑删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        [[YTshoucang share].shoucangArr removeObjectAtIndex:[indexPath row]]; //删除数组里的数据
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic]; //删除对应数据的cell
        NSString *filePahth = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"shoucang.txt"];
         [[YTshoucang share].shoucangArr writeToFile:filePahth atomically:YES];
    }
}

- (void)deleteAction
{
    if (self.pMainTableView.editing ==YES) {
        [self.pMainTableView setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"管理"];
    }
    else{
        [self.pMainTableView setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
