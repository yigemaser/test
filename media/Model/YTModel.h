//
//  YTModel.h
//  ShowMi
//
//  Created by uustock1 on 14-8-5.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTModel : NSObject

@end

@interface YTxuanchuanzu : NSObject
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *imageUrl;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *itemid;
@end

@interface YTcheckVersion : NSObject

@property(nonatomic,strong) NSString *needupdate;
@property(nonatomic,strong) NSString *applejailbreakdownloadurl;
@end