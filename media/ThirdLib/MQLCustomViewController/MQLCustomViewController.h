//
//  MQLCustomViewController.h
//  Casc
//
//  Created by uustock1 on 14-6-18.
//  Copyright (c) 2014年 uustock1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyTabBarController.h"
@interface MQLCustomViewController : UIViewController <LeveyTabBarDelegate>

-(void)setCascTitle:(NSString*)title;
-(void) setFanhui;
//@property (nonatomic, retain) LeveyTabBarController *leveyTabBarController;
@end
