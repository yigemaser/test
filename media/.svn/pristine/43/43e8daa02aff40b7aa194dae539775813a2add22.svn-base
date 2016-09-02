//
//  YTqidongtuViewController.m
//  media
//
//  Created by liuxiaolong on 14-8-17.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTqidongtuViewController.h"

@interface YTqidongtuViewController ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation YTqidongtuViewController
{

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createQidongUI];
}

- (void)createQidongUI {
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, IS_IOS7?0:20, 320, IS_IPHONE_5?568:480)];

//    imgView.image = [UIImage imageNamed:@"zhuomian.png"];
    NSString * strUrl = [YTConfig shareConfig].startupimageUrl;
    
    NSURLRequest * req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    __weak __typeof(&*self)weakSelf = self;
    [self.imgView setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakSelf.imgView.image = image;
     [NSTimer scheduledTimerWithTimeInterval:2 target:weakSelf selector:@selector(scrollTimer) userInfo:nil repeats:NO];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];

    [self.view addSubview:self.imgView];
}


- (void)scrollTimer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(retHome)]) {
        [self.delegate retHome];
    }
    
//    NSString * strUrl = [YTConfig shareConfig].startupimageUrl;
//    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
//    NSURLConnection *conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [conn start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
