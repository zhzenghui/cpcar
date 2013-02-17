//
//  Dealer_BoutiqueViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Dealer_BoutiqueViewController.h"
#import "Annotation.h"

@implementation Dealer_BoutiqueViewController
@synthesize grayActivityIndicatorView = _grayActivityIndicatorView;
@synthesize seacheView = _seacheView;
@synthesize searchNavbarView = _searchNavbarView;
@synthesize searchTextField = _searchTextField;
@synthesize searchOutTableView = _searchOutTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

#pragma mark       ---------------- mapView ----------------

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
//    iv.image = [UIImage imageNamed:@"dealer_box"];
//    
//    [view addSubview:iv];
//    
//    [iv     release];
}
/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{

    
}

/**
 *查找指定标注对应的View，如果该标注尚未显示，返回nil
 *@param annotation 指定的标注
 *@return 指定标注对应的View
 */
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {

		BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];   
		newAnnotationView.pinColor = BMKPinAnnotationColorPurple;   
		newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
//        Annotation *newAnnotationView = [[Annotation alloc] initWithAnnotation:annotation reuseIdentifier:@"myanno"];

		return newAnnotationView;
	}
	return nil;
}

//获得城市名称
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    cityString =  result.addressComponent.city;
    
    
    // 添加一个PointAnnotation
	BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];

	annotation.coordinate = result.geoPt;
	annotation.title = @"这里是北京";
    

	[_mapView addAnnotation:annotation];
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    _mapView .centerCoordinate = mapView.userLocation.coordinate;
    _mapView .zoomLevel = 14;
    
    //  根据城市经纬度 获取城市名称
    [_search reverseGeocode:mapView.userLocation.coordinate];
}
#pragma mark -


- (void)networkDealerUpdateDealerInfo
{
    
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:0], @"LastID",
                                           nil];
    
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parametersDict, @"Parameters",
                              nil ];
    
    
    dispatch_queue_t loadMoreData = dispatch_queue_create("more data", NULL);
    dispatch_sync(loadMoreData, ^{
        
        NSString  *jsonString = [jsonDict JSONString];        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServer_Prot_Dealer_UpdateDealerInfo];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];        [request setHTTPMethod:@"POST"];
        NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:dataM];
        
        
        NSData *dataRequest = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
//        NSLog(@"%@", [NSString stringWithUTF8String:[dataRequest bytes]]);   
        
        NSString *dataString = [[NSString alloc] initWithData:dataRequest encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataString);
        //        [[DictDataToDBData dataToDbHelper] data:[data objectFromJSONData] ];
        //        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            //Update Interface
        //            [self.activityArray removeAllObjects];
        //            self.activityArray =(NSMutableArray *) [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameActivity page:0 pagSize:10];   
        //            [self.tableView reloadData];
        //            if (pullType == EGO_Pull_Drop_Down) {
        //                [_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        
        //            }
        //            else {
        //                [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        //            }
        //        });
    });
    dispatch_release(loadMoreData);        
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"dealer";
    _dealerArray = [[NSMutableArray alloc]init];
    [self.searchOutTableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"1", @"city", 
                       nil];
    
    for (int i =0 ; i<10; i++) {
        [_dealerArray addObject:d];
    }
    
    
    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 40, 320, 420)];
    _mapView.delegate = self;
//    
    _search = [[BMKSearch alloc]init];
	_search.delegate = self;
    
    
    
//    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
//	CLLocationCoordinate2D coor;
//	coor.latitude = 39.915;
//	coor.longitude = 116.404;
//	annotation.coordinate = coor;
//	annotation.title = @"这里是北京";
//	[_mapView addAnnotation:annotation];

    [self networkDealerUpdateDealerInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_mapView setShowsUserLocation:YES];

    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    
}
- (void)viewDidUnload
{
    [_mapView release];
    _mapView = nil;
    [self setGrayActivityIndicatorView:nil];
    [self setSeacheView:nil];
    [self setSearchNavbarView:nil];
    [self setSearchTextField:nil];
    [self setSearchOutTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark textField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

- (void)dealloc {
    [_grayActivityIndicatorView release];
    [_seacheView release];
    [_searchNavbarView release];
    [_searchTextField release];
    [_mapView setShowsUserLocation:NO];
    [_mapView release];

    [_search release];
    [_searchOutTableView release];
    [super dealloc];
}

#pragma mark 
- (void)showSearchItem
{
    

    [_grayActivityIndicatorView stopAnimating];

    
    
}


- (IBAction)seacheDealerItem:(id)sender 
{
    
    [self.searchTextField resignFirstResponder];

//    [NSTimer timerWithTimeInterval:1 target:self selector:@selector(showSearchItem) userInfo:nil repeats:YES];

        [_seacheView setHidden:NO];
    _seacheView.frame = CGRectMake(0, -_seacheView.frame.size.height, _seacheView.frame.size.width, _seacheView.frame.size.height);

    
//    [self.view addSubview:_seacheView];
    
    [self.view bringSubviewToFront:_seacheView];
    
    [self.view bringSubviewToFront:_searchNavbarView];
    
    [UIView animateWithDuration:.3 animations:^{
          _seacheView.frame = CGRectMake(0, 40, _seacheView.frame.size.width, _seacheView.frame.size.height);                  
    } completion:^(BOOL finished) {
        
    }];
//    _seacheView.frame = CGRectMake(0, 40, _seacheView.frame.size.width, _seacheView.frame.size.height);
    [_grayActivityIndicatorView startAnimating];
}

- (IBAction)findMe:(id)sender 
{
    [_mapView setShowsUserLocation:YES];

}



#pragma mark -
#pragma mark UITableViewDataSource

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    return 70;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dealerArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.backgroundColor = [UIColor redColor];  
    if (indexPath.row % 2 ==0) {
        cell.backgroundView =[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dealer_input_bj.png"]] autorelease];
        cell.backgroundColor =[UIColor clearColor];
    }
    else {
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }

    //    static NSString *CellIdentifier = @"Cell";
    
    //    ActivityTableViewCell *cell = (ActivityTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        
    //        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil];
    //        
    //        for (id currentObject in topLevelObjects){
    //            if ([currentObject isKindOfClass:[UITableViewCell class]]){
    //                cell =  (ActivityTableViewCell *) currentObject;
    //                break;
    //            }
    //        }
    //    }    
	// Configure the cell.
    
//    BMKGeocoderAddressComponent *address = [_dealerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[_dealerArray objectAtIndex:indexPath.row] objectForKey:@"city"];
//    cell.textLabel.text = address.city;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.searchTextField resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        _seacheView.frame = CGRectMake(0, -_seacheView.frame.size.height, _seacheView.frame.size.width, _seacheView.frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
                [_seacheView setHidden:YES];
        }
    }];

}

@end
