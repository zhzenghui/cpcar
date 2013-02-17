//
//  AutoModelPMViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutoModelPMViewController.h"

@implementation AutoModelPMViewController
@synthesize pmScrollView;
@synthesize detailView;
@synthesize menuImageView;
@synthesize menuTap;

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

    [pmScrollView addSubview:detailView];
    [pmScrollView setContentSize:detailView.frame.size];
}

- (void)viewDidUnload
{
    [self setMenuTap:nil];
    [self setPmScrollView:nil];
    [self setDetailView:nil];
    [self setMenuImageView:nil];
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
    [menuTap release];
    [pmScrollView release];
    [detailView release];
    [menuImageView release];
    [super dealloc];
}

#define KAutoModel_menu1  1
#define KAutoModel_menu2  2
#define KAutoModel_menu3  3

- (void)setMenuImage:(int)tag
{
    NSString *pathString = [NSString stringWithFormat:@"auto_model_menu_%d", tag];
    menuImageView.image = [UIImage imageNamed:pathString];
}

- (IBAction)menuTapInside:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    
    CGRect scrollRect ;
    switch (button.tag) {
        case KAutoModel_menu1:
        {
            scrollRect = CGRectMake(0, 0, 320, 270);
            break;
        }
        case KAutoModel_menu2:
        {

            scrollRect = CGRectMake(320, 0, 320, 270);
            break;
        }
        case KAutoModel_menu3:
        {
            scrollRect = CGRectMake(320*2, 0, 320, 270);            
            break;
        }
        default:
            break;
    }
    
    [self setMenuImage:button.tag];
    [pmScrollView scrollRectToVisible:scrollRect animated:NO];
}
@end
