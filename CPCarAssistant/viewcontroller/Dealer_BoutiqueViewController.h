//
//  Dealer_BoutiqueViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"


@interface Dealer_BoutiqueViewController : UIViewController
<BMKMapViewDelegate, BMKSearchDelegate, UITextFieldDelegate>
{
    NSString *cityString;
    
    
    BMKSearch* _search;
    IBOutlet BMKMapView *_mapView;
  
    NSMutableArray *_dealerArray;
}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *grayActivityIndicatorView;
@property (retain, nonatomic) IBOutlet UIView *seacheView;
@property (retain, nonatomic) IBOutlet UIView *searchNavbarView;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) IBOutlet UITableView *searchOutTableView;


- (IBAction)seacheDealerItem:(id)sender;
@end
