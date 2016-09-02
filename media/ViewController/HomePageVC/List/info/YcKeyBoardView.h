//
//  YcKeyBoardView.h
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//
#define kStartLocation 20
#import <UIKit/UIKit.h>


@class YcKeyBoardView;
@protocol YcKeyBoardViewDelegate <NSObject>
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView;
-(void)tapToComments;
@end

@interface YcKeyBoardView : UIView
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *lblCommentCount;
@property (nonatomic,strong) id<YcKeyBoardViewDelegate> delegate;
@end
