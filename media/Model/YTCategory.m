//
//  YTCategory.m
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTCategory.h"

@implementation YTCategory

+(NSArray *)categoryFromDictionary:(NSArray *)arr
{
    for (NSDictionary *dic in arr) {
        YTCategory *cat = [[YTCategory alloc] init];
        
        cat.c_id = [[dic objectForKey:@"id"] intValue];
        cat.categoryName = [dic objectForKey:@"categoryname"];
        cat.imageurl = [dic objectForKey:@"imageurl"];
//        cat.isleaf = [[dic objectForKey:@"isleaf"] boolValue];
        cat.number = [[dic objectForKey:@"num"] intValue];
        cat.updatedatetime = [dic objectForKey:@"updatedatetime"];
    }
    return arr;
}


@end
