//
//  YTMapViewController.m
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTMapViewController.h"
#import "YTDisplayMap.h"
@interface YTMapViewController ()

@end

@implementation YTMapViewController
{
    CLLocationManager    *locationManager;
    CGFloat bilichi;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setCascTitle:@"地图导航"];
        [self setFanhui];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bilichi = 0.05;
    [self createBtnUI];
    [self mapUI];
    
 }

- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
        self.mapView.frame = CGRectMake(0, IS_IOS7?0:0, 320, IS_IPHONE_5?568:480-44-20);
}
- (void)createBtnUI {

    UIImageView * imgVIewBG = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 43 - 10, self.view.bounds.size.height - (IS_IPHONE_5?117:250) , 43, 87)];
    imgVIewBG.image = [UIImage imageNamed:@"mapBtnBG.png"];
    imgVIewBG.userInteractionEnabled = YES;

    [self.mapView addSubview:imgVIewBG];
    
    UIButton * addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbtn setImage:[UIImage imageNamed:@"jianhaoBtn.png"] forState:UIControlStateNormal];
    addbtn.frame = CGRectMake(0, 43, 43, 43);
    [addbtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [imgVIewBG addSubview:addbtn];
    
    
    UIButton * jianbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [jianbtn setImage:[UIImage imageNamed:@"addBtn.png"] forState:UIControlStateNormal];
    
    [jianbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jianbtn.frame = CGRectMake(0, 0, 43, 43);
    [jianbtn addTarget:self action:@selector(min:) forControlEvents:UIControlEventTouchUpInside];
    [imgVIewBG addSubview:jianbtn];

}

- (void)mapUI {
    MKCoordinateSpan span ;//缩放比例
    span.latitudeDelta = 0.4;//经度
    span.longitudeDelta = 0.4;
    MKCoordinateRegion region=self.mapView.region;//坐标显示范围
    region.span = span;
    self.mapView.region = region;
    
    
    CLLocationCoordinate2D coordinate;
    
    //    39.9767020000,116.4954440000
    
    
    //设置显示区域
    [self.mapView setRegion:region animated:TRUE];
    
    coordinate.latitude=39.9767020000;
    coordinate.longitude= 116.4954440000;
    
    //加入大头针
    YTDisplayMap *anno = [[YTDisplayMap alloc]initWithTitle:@"title"
                                                   SubTitle:@"subtitle"
                                                 Coordinate:coordinate];
    [_mapView addAnnotation:anno];
    
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    [self.mapView.userLocation setCoordinate:coordinate];
}

- (void)add:(id)sender {
    bilichi += 0.02;


    MKCoordinateSpan span = {bilichi,bilichi};

    span.latitudeDelta = bilichi;//经度
    span.longitudeDelta = bilichi;
    MKCoordinateRegion region=self.mapView.region;//坐标显示范围
    region.span = span;
    self.mapView.region = region;

}
- (void)min:(id)sender {

    MKCoordinateSpan span = {bilichi,bilichi};

    bilichi-=0.02;
    if (bilichi<0) {
        bilichi = 0;
    }
    span.latitudeDelta = bilichi;//经度
    span.longitudeDelta = bilichi;
    MKCoordinateRegion region=self.mapView.region;//坐标显示范围
    region.span = span;
    self.mapView.region = region;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
