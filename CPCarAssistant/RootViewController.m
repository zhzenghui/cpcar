//
//  RootViewController.m
//  TableViewPull
//
//  Created by Devin Doty on 10/16/09October16.
//  Copyright enormego 2009. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)addEgoView
{
    
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
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
		[view release];
		
	}
    else {
        height = self.tableView.contentSize.height;

        _refreshFootView.frame = CGRectMake(0.0f, height, self.view.frame.size.width, self.tableView.bounds.size.height);
    }
    
	//  update the last update date
	[_refreshFootView refreshLastUpdatedDate];	

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addEgoView];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.

    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
    _reloading = NO;
    _reloadingFoot = NO;

	//  model should call this when its done loading
    if (pullType == EGO_Pull_Drop_Down) {

        [_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    else {

        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        
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

    [self addEgoView];

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

- (void)egoRefreshTableFootDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableFootDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloadingFoot; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableFootDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	_refreshHeaderView=nil;
    _refreshFootView = nil;
}

- (void)dealloc {
	
	_refreshHeaderView = nil;
    _refreshFootView = nil;
    [super dealloc];
}


@end

