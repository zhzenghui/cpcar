//
//  AreaTableViewController.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableViewController : UITableViewController
{
    NSArray *provinces, *cities, *areas;
    int currentProvince;
}
- (IBAction)selectProvince:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) NSMutableDictionary *testDirt;
@end
