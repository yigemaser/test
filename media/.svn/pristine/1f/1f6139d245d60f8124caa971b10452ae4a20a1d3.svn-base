//
//  YTAboutViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTAboutViewController.h"
#import "YTConfig.h"
@interface YTAboutViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *gongsiShangbiaoImg;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *shangjiaAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *erweimaImg;
@property (weak, nonatomic) IBOutlet UIView * viewBG;
@property (weak, nonatomic) IBOutlet UILabel * emailDes;
@property (weak, nonatomic) IBOutlet UILabel *showmiUrl;
@end

@implementation YTAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setCascTitle:@"关于"];
        [self setFanhui];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self buildUI];
}
- (void)viewDidLayoutSubviews
{
      self.viewBG.frame = CGRectMake(0, IS_IOS7?64:0, 320, 421);
}
-(void)buildUI
{
    
    [_gongsiShangbiaoImg setImageWithURL:[NSURL URLWithString:[YTConfig shareConfig].logourl]];
    _versionLabel.text = [[YTConfig shareConfig].configDic objectForKey:@"version"];
    NSLog(@"%@",[YTConfig shareConfig].configDic);
    _shangjiaAddressLabel.text = [YTConfig shareConfig].address;
    NSLog(@"tele%@:",[YTConfig shareConfig].servicetel);
    if ([[YTConfig shareConfig].servicetel isEqualToString:@"(null)"]) {
        _telephoneLabel.text = @"";
    } else {
        _telephoneLabel.text = [YTConfig shareConfig].servicetel;
    }

    NSString * strEmail =[YTConfig shareConfig].email;
    if (strEmail == nil || [strEmail isEqualToString:@""]) {
        _emailLabel.hidden = YES;
        _emailDes.hidden = YES;
    }else {
        _emailLabel.text = [YTConfig shareConfig].email;
    }
    [_erweimaImg setImageWithURL:[NSURL URLWithString:[YTConfig shareConfig].shopqrcode]];
    
    _showmiUrl.attributedText = [self getAttributedString:_showmiUrl.attributedText isUnderline:YES];
    _showmiUrl.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showmiClick)];
    [_showmiUrl addGestureRecognizer:tap];
}

- (void)showmiClick {

    NSString *strUrl = [NSString stringWithFormat:@"http://%@",_showmiUrl.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];

}

//添加下划线
-(NSAttributedString*) getAttributedString:(NSAttributedString*) attributedString isUnderline:(BOOL) isUnderline
{
    NSNumber *valuUnderline = [NSNumber numberWithBool:isUnderline];
    NSRange rangeAll = NSMakeRange(0, attributedString.string.length);
    NSMutableAttributedString *as = [attributedString mutableCopy];
    [as beginEditing];
    [as addAttribute:NSUnderlineStyleAttributeName value:valuUnderline range:rangeAll];
    [as endEditing];
    return as;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
