//
//  YTshoucang.m
//  ShowMi
//
//  Created by uustock1 on 14-7-30.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTshoucang.h"
static YTshoucang * shoucang = nil;
@implementation YTshoucang
+(YTshoucang *)share
{
    if (shoucang == nil) {
        shoucang = [YTshoucang new];
        shoucang.shoucangArr = [NSMutableArray new];
    }
    return shoucang;
}

@end
