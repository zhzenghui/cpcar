//
//  TestDrive_PreserverViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define KTestDrive 11
#define KPreserver 10


#import "TestDrive_PreserverViewController.h"
#import "TestDriveViewController.h"
#import "PreserverViewController.h"

@implementation TestDrive_PreserverViewController

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
    self.title = @"test";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
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

- (IBAction)chooseItem:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case KTestDrive:
        {
            TestDriveViewController *tdvc = [[TestDriveViewController alloc] init];
            
            [self.navigationController pushViewController:tdvc animated:YES];
            [tdvc release];
            
            break;
        }
        case KPreserver:
        {
            PreserverViewController *preserver = [[PreserverViewController alloc] init];
            
            [self.navigationController pushViewController:preserver animated:YES];
            
            [preserver release];
            break;
        }
        default:
            break;
    }
}
@end
