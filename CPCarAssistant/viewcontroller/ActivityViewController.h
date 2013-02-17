//
//  ActivityViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFootView.h"
#import "BaseViewController.h"


@interface ActivityViewController : BaseViewController<EGORefreshTableHeaderDelegate, EGORefreshTableFootDelegate,UITableViewDataSource, UITableViewDelegate>
{
    EGO_PullType pullType;
    
    BOOL _reloading;
	BOOL _reloadingFoot;    
    
    
	EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFootView *_refreshFootView;
    
    NSMutableArray *_activityArray;
    
    int start;
    int count;
    int total;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *tableViewBackView;
@property (retain, nonatomic) NSMutableArray *activityArray;

- (IBAction)refresh:(id)sender;
@end
