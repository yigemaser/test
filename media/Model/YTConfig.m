//
//  YTConfig.m
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTConfig.h"
static YTConfig * config = nil;
@implementation YTConfig

+(YTConfig *)shareConfig
{
    if (config == nil) {
        config = [YTConfig new];
        config.advsArr =[NSArray new];
    }
    return config;
}
-(BOOL)isAdvs:(NSString *)categoryid
{
    BOOL ret = '\0';
    NSInteger num = 0;
    categoryid = [NSString stringWithFormat:@"%@",categoryid];
    for (NSDictionary *dic in _advsArr) {
        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryid"]] isEqualToString:categoryid]) {
            ret = YES;
            self.groupid = [dic objectForKey:@"groupid"];
            break;
        }
        num++;
    }
    if (num == _advsArr.count) {
        ret = NO;
    }
    return ret;
}
@end
