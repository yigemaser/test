//
//  YTDisplayMap.h
//  media
//
//  Created by liuxiaolong on 14-8-17.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface YTDisplayMap : NSObject <MKAnnotation>

@property (nonatomic, copy, readonly)   NSString                *title;
@property (nonatomic, copy, readonly)   NSString                *subtitle;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D   coordinate;

- (id)initWithTitle:(NSString*)title
           SubTitle:(NSString*)subtitle
         Coordinate:(CLLocationCoordinate2D)coordinate;

@end
