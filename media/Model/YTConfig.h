//
//  YTConfig.h
//  ShowMi
//
//  Created by uustock1 on 14-7-27.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTConfig : NSObject
@property(strong, nonatomic) NSArray * advsArr;
@property(strong, nonatomic) NSString * groupid;
@property(strong, nonatomic) NSDictionary *configDic;
@property(strong, nonatomic) NSString * logourl;//公司图标
@property(strong, nonatomic) NSString * version; //商店编号_框架版本号_版本序列号
@property(strong, nonatomic) NSString *shopqrcode; //商店二维码图片url
@property(strong, nonatomic) NSString *email; //邮箱
@property(strong, nonatomic) NSString *telephone; //商家电话(本电话客户端一般不用)
@property(strong, nonatomic) NSString *status; //商店状态 1：激活 2：禁用 3：审查中
@property(strong, nonatomic) NSString *servicetel;//商家客服电话(本电话作为更多里面的客服电话展示，可让用户拨打)
@property(strong, nonatomic) NSString *lat;//纬度，无值时为空字符串
@property(strong, nonatomic) NSString *lng;//经度，无值时为空字符串
@property(strong, nonatomic) NSString *startupimageUrl; //加载页图片路径
@property(strong, nonatomic) NSString *address; //公司地址
@property(assign, nonatomic) BOOL needUpdate;//是否需要更新 yes 需要更新 no 不需要更新
@property(strong, nonatomic) NSString *VersionUrl11; // 新版本的下载地址
@property(strong, nonatomic) NSString *contentUpdate; //更新内容
@property(strong, nonatomic) NSString *shopTitle; //商店名称

+(YTConfig *)shareConfig;
-(BOOL)isAdvs:(NSString *)categoryid;
@end
