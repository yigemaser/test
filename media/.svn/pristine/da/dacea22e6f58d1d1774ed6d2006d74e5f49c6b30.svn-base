//
//  YTCategory.h
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTCategory : NSObject
@property int c_id;
@property(nonatomic,strong) NSString *categoryName;
@property(nonatomic,strong) NSString *imageurl;
@property(nonatomic, strong) NSString * isleaf;//是不是页目录，true，其目录下全为图片，false，其目录下还有目录，并且里面不会有图片
@property (nonatomic,strong) NSString *updatedatetime;
@property int number;//子数量，如果isleaf为true,表示此目录下有多少图片，如果isleaf为false，表示此目录下有多少个子目录
@property (nonatomic,strong)NSMutableArray * cateNumArray;

+(NSArray * )categoryFromDictionary:(NSArray *)arr;

@end
