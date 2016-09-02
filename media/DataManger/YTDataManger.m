//
//  YTDataManger.m
//  DataManger
//
//  Created by uustock1 on 14-7-24.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import "YTDataManger.h"
#import "AFNetworking.h"
static YTDataManger * dataManger = nil;
@implementation YTDataManger{

}

+(YTDataManger *)shareDataManger
{
    if (dataManger == nil) {
        dataManger = [YTDataManger new];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"txt"];
        NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
        NSString *str = [[NSString alloc] initWithData:
                         [readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
        NSString * str12 = [NSString stringWithFormat:@"%@",str];
        NSData* data = [str12 dataUsingEncoding:NSUTF8StringEncoding];
        
//        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSError* error;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error) {
                [YTConfig shareConfig].configDic = jsonData;
            
        }else{
            
        }
        
        NSString * shopid = [NSString stringWithFormat:@"%@",[[YTConfig shareConfig].configDic objectForKey:@"shopid"]];	
        NSString * systemVersion = [[UIDevice currentDevice] localizedModel]; //设备名 eg:iphone5s
        
        //获取屏幕宽高
        UIScreen *currentScreen = [UIScreen mainScreen];
        NSString *deviceWidth = [NSString stringWithFormat:@"%.0f",currentScreen.bounds.size.width*2];
        NSString *deviceHeitht = [NSString stringWithFormat:@"%.0f",currentScreen.bounds.size.height*2];
        
        NSString * tockenForShopid = [shopid stringByAppendingString:@"|S-pfksy9do|ToTu2wg9ja4OXcn/w3E/YaBw8sFDgBLQtEXRgTvLHK4FMKWUDJT61UjXVwIpRBfO2D4awtu9AKTLEfSTnHWpTvv0iEsvTx8lD72V/Q+C4ehM5J2AqjGvI1EcbL6BqZDtKkhfNbBypxEDoieox+4UlkWLv5bY+tc8Jgld8DU/peo=|1|"];
        
        NSString * str1 = [NSString stringWithFormat:@"%@%s%@%s%@",systemVersion,"|",deviceWidth,"|",deviceHeitht];
       dataManger.tockenByLocalConfig = [tockenForShopid stringByAppendingString:str1];

    }
    return dataManger;
}

//获取配置信息

-(void)getCongifAndTocken:(NSString *)tocken1 idcode:(NSString *)idcode aver:(NSString *)aver cver:(NSString *)cver destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
//    [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:idcode forKey:@"idcode"];
    [dic setValue:aver forKey:@"aver"];
    [dic setValue:cver forKey:@"cver"];
    
//    [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString *strUrl = [NSString stringWithFormat:ShowMi_getcongif];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"configBynetworking = %@",json);
         if (block) {
             block(json,nil);
//         [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         if (block) {
             block([NSArray array],error);
//            [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }

     }];
}


-(void)getcategoryAndTocken:(NSString *)tocken1 idcode:(NSString *)idcode parent_id:(NSString *)parent_id page:(NSString *)page size:(NSString *)size status:(NSString *)status destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
    if (![parent_id isEqualToString:@"0"]) {
        [MBProgressHUD showHUDAddedTo:destView animated:YES];
    }
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getcategory];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:idcode forKey:@"idcode"];
    [dic setValue:parent_id forKey:@"parent_id"];
    [dic setValue:status forKey:@"status"];
    [dic setValue:page forKey:@"page"];
    [dic setValue:size forKey:@"size"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"get = %@",json);
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }

     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
            [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}

-(void)getItemByCategoryAndTocken:(NSString *)tocken1 categoryid:(NSString *)categoryid page:(NSInteger)page size:(NSInteger)size  status:(NSString *)status destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
    [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getItemByCategory];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *sizeStr = [NSString stringWithFormat:@"%d",size];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:categoryid forKey:@"categoryid"];
    [dic setValue:pageStr forKey:@"page"];
    [dic setValue:status forKey:@"status"];
    [dic setValue:sizeStr forKey:@"size"];

    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getItem = %@",json);
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         

         if (block) {
             block([NSArray array],error);
            [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}

-(void)getDetailItemAndTocken:(NSString *)tocken1 idcode:(NSString *)idcode itemid:(NSString *)itemid destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
        [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getDetailItem];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:idcode forKey:@"idcode"];
    [dic setValue:itemid forKey:@"itemid"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getconfig = %@",json);
         
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];


}

-(void)getDetailInformationUrlAndTocken:(NSString *)tocken1 idcode:(NSString *)idcode itemid:(NSString *)itemid destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
        [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getDetailInformationUrl];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:idcode forKey:@"idcode"];
    [dic setValue:itemid forKey:@"itemid"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getInfo = %@",json);
         
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}
-(void)getPromotionByGroupidAndTocken:(NSString *)tocken1 groupid:(NSInteger)groupid destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
        [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getPromotionByGroupid];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    NSString *groupStr = [NSString stringWithFormat:@"%d",groupid];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:groupStr forKey:@"groupid"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getPromotionByGroupid = %@",json);
         
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
    
}

-(void)getdetailinformationAndTocken:(NSString *)tocken1 itemid:(NSString *)itemid destView:(UIView *) destView Block:(void (^)(id posts,NSError *error))block
{
        [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getdetailinformation];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    

    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:itemid forKey:@"itemid"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getPromotionByGroupid = %@",json);
         
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}

-(void)getDiscussByItemidAndTocken:(NSString *)tocken1 itemid:(NSString *)itemid page:(NSInteger)page size:(NSInteger)size  destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
    [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_getDiscussByItemid];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    NSString *pageStr = [NSString stringWithFormat:@"%d",page];
    NSString *sizeStr = [NSString stringWithFormat:@"%d",size];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:itemid forKey:@"itemid"];
    [dic setValue:pageStr forKey:@"page"];
    [dic setValue:sizeStr forKey:@"size"];
    
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"getDiscussByItemidAndTocken = %@",json);
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}

-(void)addItemDiscussAndTocken:(NSString *)tocken1 idcode:(NSString *)idcode itemid:(NSString *)itemid loginname:(NSString *)loginname content:(NSString *)content  destView:(UIView *)destView Block:(void (^)(id posts,NSError *error))block
{
    [MBProgressHUD showHUDAddedTo:destView animated:YES];
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_addItemDiscuss];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:itemid forKey:@"itemid"];
    [dic setValue:idcode forKey:@"idcode"];
    [dic setValue:loginname forKey:@"loginname"];
    [dic setValue:content forKey:@"content"];
    
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"addItemDiscussAndTocken = %@",json);
         
         if (block) {
             block(json,nil);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
         
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         
         if (block) {
             block([NSArray array],error);
             [MBProgressHUD hideAllHUDsForView:destView animated:YES];
         }
     }];
}


- (void)checkVesionTocken:(NSString *)tocken1 versionnum:(NSString *)versionnum block:(void (^)(id posts,NSError *error))block
{
    
    NSString * strUrl = [NSString stringWithFormat:ShowMi_checkVersion];
    NSMutableDictionary * dic = [NSMutableDictionary new];
    
    
    [dic setValue:dataManger.tockenByLocalConfig forKey:@"token"];
    [dic setValue:versionnum forKey:@"versionnum"];
    
    AFHTTPClient * client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:url_base]];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [client postPath:strUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error;
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
         NSLog(@"ShowMi_checkVersion = %@",json);
         
         if (block) {
             block(json,nil);
         }
     }
             failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Request Error:%@",error.localizedDescription);
         
         if (block) {
             block([NSArray array],error);
         }
     }];

}

@end
