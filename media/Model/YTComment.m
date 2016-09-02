//
//  Comment.m
//  RSinaNews
//
//  Created by TY on 14-6-10.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "YTComment.h"
#import "YTTool.h"
#import "YTDataManger.h"
@implementation YTComment

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    if (self = [super init]) {
        //self.ip = [attributes objectForKey:@"IP"];
        //self.nickName = [attributes objectForKey:@"NickName"];
        //self.longitude = [attributes objectForKey:@"Longitude"];
        //self.latitude = [attributes objectForKey:@"Latitude"];
        //self.drId = [attributes objectForKey:@"DrId"];
        //self.stfId = [attributes objectForKey:@"StfId"];
        //self.contentId = [attributes objectForKey:@"ContentId"];
        self.discussid = [attributes objectForKey:@"discussid"];
        self.createtime = [attributes objectForKey:@"createtime"];
        self.content = [attributes objectForKey:@"Content"];
        self.loginname =  [attributes objectForKey:@"loginname"];
        UITextView *txt = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 240, 53)];
        txt.text = self.content;
        txt.font = [UIFont systemFontOfSize:14];
        self.height = [YTTool contentSizeOfTextView:txt].height;
    }
    return self;
}

@end
