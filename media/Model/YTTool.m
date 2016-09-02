//
//  Tool.m
//  RSinaNews
//
//  Created by TY on 14-6-5.
//  Copyright (c) 2014年 Roger. All rights reserved.
//

#import "YTTool.h"
#define FIRST_USE @"FIRST_USE"

@implementation YTTool

#pragma mark- 判断是否第一次使用
+ (CGSize)contentSizeOfTextView:(UITextView *)textView
{
    CGSize textViewSize = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)];
    return textViewSize;
}
@end
