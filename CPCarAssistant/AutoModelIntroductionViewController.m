//
//  AutoModelIntroductionViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutoModelIntroductionViewController.h"
#import "AutoModelCell.h"
#import "AutoModelPMViewController.h"


@implementation AutoModelIntroductionViewController
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
    
    // Release any cached data, images, etc that aren't in use.
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
    return self.activityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
//    cell.textLabel.text = [[self.activityArray objectAtIndex:indexPath.row] objectForKey:KActivity_Title];
    
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 31)] autorelease];
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"auto_automodel_sectionbackground"]];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoModelPMViewController *advc = [[AutoModelPMViewController alloc] init];
    [self.navigationController pushViewController:advc animated:YES];
    [advc release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    self.activityArray =  activity;}

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
