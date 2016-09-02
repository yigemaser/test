//
//  HREGORootViewController.h
//  HexunRadar
//
//  Created by Eason on 13-9-24.
//
//
#import "HREGORefreshTableFooterView.h"
#import "HREGORefreshTableHeaderView.h"
#import "HREGOViewCommon.h"
#import "MQLCustomViewController.h"

@interface HREGORootViewController : MQLCustomViewController<EGORefreshTableDelegate, UITableViewDelegate, UITableViewDataSource>{
	
	HREGORefreshTableHeaderView *_refreshHeaderView;
    HREGORefreshTableFooterView *_refreshFooterView;
    
    UITableView *_tableView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}
@property(nonatomic, retain)UITableView *tableView;

// create/remove footer/header view, reset the position of the footer/header views
-(void)setFooterView;
-(void)removeFooterView;
-(void)createHeaderView;
-(void)removeHeaderView;

// overide methods
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos;
-(void)finishReloadingData;

// force to refresh
-(void)showRefreshHeader:(BOOL)animated;

@end
