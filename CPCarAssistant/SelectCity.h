//
//  SelectCity.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface SelectCity : UIViewController <BMKMapViewDelegate, BMKSearchDelegate>
{
    NSString *cityString;
    IBOutlet BMKMapView *_mapView;
    BMKSearch* _search;

    NSArray *provinces, *cities, *areas;
    int currentProvince;
}
- (IBAction)selectProvince:(id)sender;

@property (retain, nonatomic) NSMutableDictionary *testDirt;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
@end
