//
//  ActivityDetailViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityDetailViewController.h"

@implementation ActivityDetailViewController
@synthesize activityDict = _activityDict;
@synthesize titleLabel = _titleLabel;
@synthesize activityTimeLabel = _activityTimeLabel;
@synthesize dealerLabel = _dealerLabel;
@synthesize phoneLabel = _phoneLabel;
@synthesize supTime = _supTime;
@synthesize contentTextView = _contentTextView;


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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = [self.activityDict objectForKey:KActivity_Title];
//    self.activityTimeLabel.text = [self.activityDict objectForKey:KActivity_ActivityTime];
//    self.dealerLabel.text = [self.activityDict objectForKey:KActivity_Dealer];
//
//    self.phoneLabel.text = [self.activityDict objectForKey:KActivity_Tel];
    self.supTime.text = [self.activityDict objectForKey:KActivity_SupTime];

}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setActivityTimeLabel:nil];
    [self setDealerLabel:nil];
    [self setPhoneLabel:nil];
    [self setSupTime:nil];
    [self setContentTextView:nil];
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
    [_titleLabel release];
    [_activityTimeLabel release];
    [_dealerLabel release];
    [_phoneLabel release];
    [_supTime release];
    [_contentTextView release];
    [super dealloc];
}
@end
