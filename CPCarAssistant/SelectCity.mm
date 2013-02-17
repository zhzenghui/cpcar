//
//  SelectCity.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectCity.h"
#import "FMQueryHelper.h"

@implementation SelectCity
@synthesize cityLabel;
@synthesize headerView;
@synthesize testDirt;
@synthesize tableView;

#pragma mark - 

- (IBAction)expansionProvince:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (currentProvince == button.tag ) {
        currentProvince = -1;
    }
    else {
        
        currentProvince = button.tag;
        cities = [[provinces objectAtIndex:button.tag] objectForKey:@"cities"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:currentProvince];
        
        [self.tableView reloadData]; 
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
    [self.tableView reloadData];
}


#pragma mark       ---------------- mapView ----------------

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
#pragma mark       ---------------- mapView ----------------

//获得城市名称
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
    NSLog(@"%@", result.addressComponent.city);
    cityLabel.text = result.addressComponent.city;
    cityString =  result.addressComponent.city;

}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    _mapView .centerCoordinate = mapView.userLocation.coordinate;
    _mapView .zoomLevel = 14;
    
    //  根据城市经纬度 获取城市名称
    [_search reverseGeocode:mapView.userLocation.coordinate];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView.delegate = self;

   
	_search = [[BMKSearch alloc]init];;
    _search.delegate = self;
    [_mapView setShowsUserLocation:YES];
    
    
    
    provinces = [[FMQueryHelper queryHelper:DBNameDocument] queryCityTableData:DBTableNameCity fatherID:@"0"];
//    [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
//    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    
    
    currentProvince = -1;
}

- (void)viewDidUnload
{
    [self setCityLabel:nil];
    [self setTableView:nil];
    [self setHeaderView:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return provinces.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    
    UIView *v = [[[UIView alloc] init] autorelease];
    v.frame = CGRectMake(0, 0, 320, 44);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 22)];
    label.text =[[provinces  objectAtIndex:section] objectForKey:@"ProvinceName"];
    [v addSubview:label];
    [label release];
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = v.frame;
    button.tag = section;
    [button addTarget:self action:@selector(expansionProvince:) forControlEvents:UIControlEventTouchUpInside];
    
    [v addSubview:button];
    return v;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if (section == currentProvince) {
        NSArray *d = [provinces objectAtIndex:currentProvince];
        return d.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (currentProvince != -1) {
//        cell.textLabel.text =  [[[provinces objectAtIndex:currentProvince] objectForKey:@"cities"]objectAtIndex:indexPath.row];        
    }
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    //    objectForKey:@"cities"];
    //    [[testDirt setValue:[provinces objectAtIndex:indexPath.section] forKey:@"cities"]) objectAtIndex:indexPath.row];
    
    NSString *provinceString = [[provinces objectAtIndex:indexPath.section] objectForKey:@"state"];
    NSString *cityString = [[[provinces objectAtIndex:indexPath.section] objectForKey:@"cities"] objectAtIndex:indexPath.row];
    
    
    [testDirt setValue:provinceString forKey:KTestfieldPrivince];
    [testDirt setValue:cityString forKey:KTestfieldCity];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)selectProvince:(id)sender 
{
    
}


- (void)dealloc {
    [cityLabel release];
    [_mapView setShowsUserLocation:NO];
    [headerView release];

    [_search release];
    [tableView release];
    [super dealloc];
}
@end
