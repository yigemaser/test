//
//  YcKeyBoardView.m
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "YcKeyBoardView.h"

@interface YcKeyBoardView()<UITextViewDelegate>
//@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;

@end

@implementation YcKeyBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        //self.backgroundColor=[UIColor redColor];
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    NSLog(@"YcKeyBoardView initTextView");
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(8.0, 8.0, 250.0, 30.0)];
    self.textView.font = [UIFont systemFontOfSize:16.0];
    self.textView.text = @"我来说两句...";
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    self.textView.layer.borderWidth = 0.65f;
    self.textView.layer.cornerRadius = 6.0f;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.delegate=self;
    //self.textViewWidth=self.textView.frame.size.width-10;
    [self addSubview:self.textView];
    
    //UIView 装载图片和数量
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(271.0, 2.0, 49.0, 40.0)];
    self.commentView.backgroundColor = [UIColor clearColor];

    //图片
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment_toolbar_comment.png"]];
    self.imageView.alpha = 1.000;
    self.imageView.autoresizesSubviews = YES;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.imageView.frame = CGRectMake(32.0, 6.0, 12.0, 12.0);
    [self.commentView addSubview:self.imageView];

    //数量
    self.lblCommentCount = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 20.0, 25.0, 17.0)];
    self.lblCommentCount.backgroundColor = [UIColor clearColor];
    self.lblCommentCount.textColor = [UIColor blackColor];
    [self.commentView addSubview:self.lblCommentCount];
    
    [self addSubview:self.commentView];
    //点击进入评论列表
    UITapGestureRecognizer *tapToComments = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getComments)];
    [self.commentView addGestureRecognizer:tapToComments];

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
        
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        return NO;
    }
    return YES;
}
//显示评论列表
- (void)getComments
{
    NSLog(@"getComments...");
    [self.delegate tapToComments];
}
    
@end
