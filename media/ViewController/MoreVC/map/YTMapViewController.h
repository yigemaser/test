//
//  YTMapViewController.h
//  ShowMi
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "MQLCustomViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>

@interface YTMapViewController : MQLCustomViewController <MKMapViewDelegate>

@property(nonatomic,strong) IBOutlet MKMapView *mapView;

@end
