//
//  AutoModelViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutoModelViewController.h"

#import "EGORefreshTableHeaderView.h"
#import "ActivityTableViewCell.h"
#import "AutoModelIntroductionViewController.h"
#import "DictDataToDBData.h"
#import "FMQueryHelper.h"

@implementation AutoModelViewController
@synthesize tableView = _tableView;
@synthesize activityArray = _activityArray;
@synthesize tableViewBackView = _tableViewBackView;


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
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - 


- (IBAction)refresh:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    aiv.frame = button.frame;
    [aiv startAnimating];
    
    
    [button addSubview:aiv ];
    
    [aiv release];
}


- (void)addEgoView
{
    
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    [self.tableView reloadData];
    
    CGFloat height = self.tableView.contentSize.height;
    CGFloat contentheight = self.tableView.frame.size.height;
    NSLog(@"%f   %f", height, contentheight);
    if (self.tableView.contentSize.height < self.tableView.frame.size.height  ) {
        return;
    }
    if (_refreshFootView == nil) {
        //		if (self.tableView.contentSize.height < self.view.frame.size.height) {
        //            height = self.tableView.bounds.size.height-44;
        //        }
        //        else
        
        height = self.tableView.contentSize.height;
		EGORefreshTableFootView *view = [[EGORefreshTableFootView alloc] initWithFrame:CGRectMake(0.0f, height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshFootView = view;
		
	}
    
	//  update the last update date
	[_refreshFootView refreshLastUpdatedDate];	
    
}

#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    static NSString *CellIdentifier = @"Cell";
    //    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    //    }
    static NSString *CellIdentifier = @"Cell";
    
    ActivityTableViewCell *cell = (ActivityTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (ActivityTableViewCell *) currentObject;
                break;
            }
        }
    }    
	// Configure the cell.
    
    
    cell.titleLabel.text = [[self.activityArray objectAtIndex:indexPath.row] objectForKey:KAuto_Name];
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoModelIntroductionViewController *advc = [[AutoModelIntroductionViewController alloc] init];
    [self.navigationController pushViewController:advc animated:YES];
    [advc release];
}



- (void)setViewFrame
{
    CGRect rect  = ScreenSize;
    
    _tableViewBackView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height -64);
}

#pragma mark - city

-(IBAction)selectCity:(id)sender
{
//    SelectCity *sc = [[SelectCity alloc] init];
//    [self.navigationController pushViewController:sc animated:YES];
//    
//    [sc release];
}

#pragma mark - 

- (IBAction)backSuper:(id)sender
{
    [self .navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"车型介绍";
    
    [self setViewFrame];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStyleDone target:self action:@selector(selectCity:)];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:@"W" forKey:KActivity_Dealer];
//    [dict setValue:@"title" forKey:KActivity_Title];
//    [dict setValue:@"imgUrl" forKey:KActivity_ImgURL];
//    [dict setValue:@"suptime" forKey:KActivity_SupTime];
//    [dict setValue:@"activitytime" forKey:KActivity_ActivityTime];
//    [dict setValue:@"tel" forKey:KActivity_Tel];

    
    
    NSMutableArray *activity = [[NSMutableArray alloc] init];
    
    for (int i =0 ; i<10; i++) {
        [activity addObject:dict];
    }
    self.activityArray =  activity;
    
    
	[self addEgoView];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backButton"];
    UIImage* buttonImage = [backButtonImage stretchableImageWithLeftCapWidth:15 topCapHeight:12];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(0, 0, 60, buttonImage.size.height);
    [backButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(backSuper:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
//     load local data  
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setTableViewBackView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc {
    [_tableView release];
    [_tableViewBackView release];
    
    
    [_refreshFootView release];
    //    [_refreshHeaderView release];
    
    [_activityArray release];    
    
    [super dealloc];
}

- (void)getDBdata
{
    
}

#pragma mark - network

- (void)network:(bool)isUpdate
{
    //    下载 还是提交
    
    //    lastid
    int lastId = 1;// [[FMQueryHelper queryHelper:DBNameDocument] queryLastID:DBTableNameAuto];
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:lastId], @"LastID",
                                           nil];

    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parametersDict, @"Parameters",
                              nil ];
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("preserver", NULL);  
    dispatch_async(queue, ^(void) {
        
        NSString  *jsonString = [jsonDict JSONString];        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServerAboutCarUpdateCarInfo];
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];
        
        
        [request setHTTPMethod:@"POST"];
        NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:dataM];
        
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        if (data) {
            
            NSDictionary *dataDict = [data objectFromJSONData];
            
            if (isUpdate) {
                
                //                获取最新数据，  更新本地数据库
                if ( [dataDict objectForKey:@"Data"]  ) {

                    [[DictDataToDBData dataToDbHelper] data:dataDict ];
                    
                    
                    self.activityArray =(NSMutableArray *) [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameAuto page:0 pagSize:10];   
                }
                else {
                    debugLog(@"no update record");
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];    
                    [self.tableView reloadData];
                });
            }
            else {
                
                //               加载更多  更新本地数据  
                if ( [[dataDict objectForKey:@"IsSuccess"] isEqualToNumber:[NSNumber numberWithBool: true]] ) {
                    NSLog(@"success");            
                    
                }
                else {
                    NSLog(@"update  faild");
                    
                }
            }
            
        }
        else {
            NSLog(@"return preserv data: NULL");
        }
        
        
        

    });  
    
    dispatch_release(queue);

}
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    
    if (pullType == EGO_Pull_Drop_Down) {
        _reloadingFoot = YES;        
    }
    else {
        _reloading = YES;        
    }
    
    
}

- (void)doneLoadingTableViewData{
    _reloading = NO;
    _reloadingFoot = NO;
    
	//  model should call this when its done loading
    if (pullType == EGO_Pull_Drop_Down) {
        
        [self network:NO];
//        dispatch_queue_t loadMoreData = dispatch_queue_create("more data", NULL);
//        dispatch_sync(loadMoreData, ^{
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.ycombinator.com/"]];
//            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
//            NSLog(@"%@", [NSString stringWithUTF8String:[data bytes]]);   
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //Update Interface
//                [_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        
//            });
//        });
//        dispatch_release(loadMoreData);        
        
    }
    else {
        
        [self network:YES];

//        dispatch_queue_t refreshData = dispatch_queue_create("refresh", NULL);
//        dispatch_sync(refreshData, ^{
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/programming"]];
//            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
//            NSLog(@"%@", [NSString stringWithUTF8String:[data bytes]]);   
//            
//            
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //Update Interface
//                [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        
//            });
//            
//        });
//        
//        dispatch_release(refreshData);
    }	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
    //    CGPoint offset = scrollView.contentOffset;
    //    CGSize size = scrollView.frame.size;
    //    CGSize contentSize = scrollView.contentSize;
    //    
    //    float yMargin = offset.y + size.height - contentSize.height;
    
    if (scrollView.contentOffset.y > 50  && _reloading ==NO) {
        
        pullType = EGO_Pull_Drop_Down;
        [_refreshFootView egoRefreshScrollViewDidScroll:scrollView];
    }
    else  if (scrollView.contentOffset.y < 0  && _reloadingFoot ==NO) {
        pullType = EGO_Pull_UP;
        
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView.contentOffset.y > 50  && _reloading ==NO) {
        pullType = EGO_Pull_Drop_Down;
        
        [_refreshFootView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    else if (scrollView.contentOffset.y < 0  && _reloadingFoot ==NO) {
        pullType = EGO_Pull_UP;
        
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark EGORefreshTableFootDelegate Methods

- (void)egoRefreshTableFootDidTriggerRefresh:(EGORefreshTableFootView*)view{
	
	[self reloadTableViewDataSource];
    
    
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];        
    
}

- (BOOL)egoRefreshTableFootDataSourceIsLoading:(EGORefreshTableFootView*)view{
    
    return _reloadingFoot; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableFootDataSourceLastUpdated:(EGORefreshTableFootView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
