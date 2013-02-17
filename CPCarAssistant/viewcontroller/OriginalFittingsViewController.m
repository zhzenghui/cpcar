//
//  OriginalFittingsViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OriginalFittingsViewController.h"

@implementation OriginalFittingsViewController
@synthesize activityArray;


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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    cell.textLabel.text = [[self.activityArray objectAtIndex:indexPath.row] objectForKey:KActivity_Title];
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ActivityDetailViewController *advc = [[ActivityDetailViewController alloc] init];
    //    advc.activityDict = [self.activityArray objectAtIndex:indexPath.row];
    //    [self.navigationController pushViewController:advc animated:YES];
    //    [advc release];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"owoers";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:@"W" forKey:KActivity_Dealer];
    [dict setValue:@"title" forKey:KActivity_Title];
    [dict setValue:@"imgUrl" forKey:KActivity_ImgURL];
    [dict setValue:@"suptime" forKey:KActivity_SupTime];
//    [dict setValue:@"activitytime" forKey:KActivity_ActivityTime];
//    [dict setValue:@"tel" forKey:KActivity_Tel];
    
    
    NSMutableArray *activity = [[NSMutableArray alloc] init];
    
    for (int i =0 ; i<10; i++) {
        [activity addObject:dict];
    }
    self.activityArray =  activity;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
