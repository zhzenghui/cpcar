//
//  AutoModelViewController.m
//  CPCarAssistant
//
//  Created by zeng on 13-2-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#define KPageCount 10

#import "AutoModelViewController.h"
#import "DictDataToDBData.h"
#import "FMQueryHelper.h"
#import "AutoModelCell.h"

@implementation AutoModelViewController
@synthesize autoModelArray = _autoModelArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    count = 10;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    pullType = EGO_Pull_UP;
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
    
    self.autoModelArray =(NSMutableArray *) [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameAuto page:0 pagSize:10];   
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.autoModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AutoModelCell *cell = (AutoModelCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AutoModelCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (AutoModelCell *) currentObject;
                break;
            }
        }
    }    
	// Configure the cell.
   
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", PATH_OF_DOCUMENT,[[self.autoModelArray objectAtIndex:indexPath.row] objectForKey:KAuto_AutoImg] ];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];

    
    cell.titleLabel.text = [[self.autoModelArray objectAtIndex:indexPath.row] objectForKey:KAuto_Name];
    cell.titleImageView.image = image;
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
}




#pragma mark - network


- (int)nextPage
{
    start += 1;
    
    return start;
}

- (void)loadMoreData
{
    NSArray *addArray = [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameAuto page:[self nextPage] pagSize:10];
    
    if (addArray.count == 0) {
        start -=1;
        NSLog(@"loading is complete");
        [_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        

        return;
    }
    
    NSMutableArray* paths = [[NSMutableArray alloc] init];
    
    NSIndexPath *indePath;
    int startPath = self.autoModelArray.count;
    for (int i =0 ; i<addArray.count; i++) {
        indePath = [NSIndexPath indexPathForRow:startPath+i inSection:0];
        
        [paths addObject:indePath];
    }
    [self.autoModelArray addObjectsFromArray:addArray];
    
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];
    
    [_refreshFootView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];        
    
    
    
    
    int height = self.tableView.contentSize.height;
    _refreshFootView.frame = CGRectMake(0.0f, height, self.view.frame.size.width, self.tableView.bounds.size.height);
    
}

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
                    
                    
                    self.autoModelArray =(NSMutableArray *) [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameAuto page:0 pagSize:10];   
                }
                else {
                    debugLog(@"no update record");
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];


                    [self addEgoView];
                    [self.tableView reloadData];


                });
            }
            else {
                
                //               加载更多  更新本地数据  
//                if ( [[dataDict objectForKey:@"IsSuccess"] isEqualToNumber:[NSNumber numberWithBool: true]] ) {
//                    NSLog(@"success");            
                    
                    
//                }
//                else {
//                    NSLog(@"update  faild");
//                    
//                }
            }
            
        }
        else {
            NSLog(@"return preserv data: NULL");
        }
    });  
    
    dispatch_release(queue);
    
}

- (void)doneLoadingTableViewData{
    _reloading = NO;
    _reloadingFoot = NO;
    
	//  model should call this when its done loading
    if (pullType == EGO_Pull_Drop_Down) {
        
        [self loadMoreData];
        
    }
    else {
        
        [self network:1];

    }	
}

@end
