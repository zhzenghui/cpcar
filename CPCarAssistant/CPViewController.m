//
//  CPViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomBadge.h"

#import "CPViewController.h"
#import "JSBadgeView.h"


#define Klogo 11
#define KBadgeTag 222


@implementation CPViewController
@synthesize activityButton;
@synthesize autoModelButton;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - customer method

- (void)setButtonImage
{
    NSString *imageStr = [NSString stringWithFormat:@"index_menu_%d_0", preTag-10];
    UIImage *image= [UIImage imageNamed:imageStr];
    
    [preButton setImage:image forState:UIControlStateNormal];
    

}

- (IBAction)buttonTag:(int)buttonTag badgeNum:(NSString *)badgeNum
{
    UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag];

    if (badgeNum) {
        
        JSBadgeView *badgeView1 = [[JSBadgeView alloc] initWithParentView:button alignment:JSBadgeViewAlignmentTopRight_Within];
        badgeView1.tag = KBadgeTag;
        badgeView1.badgeText = badgeNum;        
    }
    else {
        JSBadgeView *jsBadgeView = (JSBadgeView *)[button viewWithTag:KBadgeTag];
        if (jsBadgeView) {
            [jsBadgeView removeFromSuperview];            
        }

    }
}

- (IBAction)menuTap:(id)sender 
{
    [self setButtonImage];

    [self buttonTag:10 badgeNum:nil];

    [_headView setHidden:YES];

    UIButton *button = (UIButton *)sender;    

    preTag = button.tag;
    preButton = button;
    
    
    NSString *imageStr = [NSString stringWithFormat:@"index_menu_%d_1", button.tag-10];
    UIImage *image= [UIImage imageNamed:imageStr];
    
    [button setImage:image forState:UIControlStateNormal];

    
    UIViewController *viewController = nil; 
    

    
    switch (  button.tag ) {
        case KMENU_BUTTON_Activity:
        {
            viewController = [[ActivityViewController alloc] init];
            break;
        }               
        case KMENU_BUTTON_AutoModel:
        {
            viewController = [[AutoModelViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_Dealer_Boutique:
        {
            viewController = [[Dealer_BoutiqueViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_MessageView:
        {
            viewController = [[MessageViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_OriginalFittings:
        {
            viewController = [[OriginalFittingsViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_OwnersFAQView:
        {
            viewController = [[OwnersFAQViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_SysSetting:
        {
            viewController = [[SysSettingViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_TestDrive_Preserver:
        {
            viewController = [[TestDrive_PreserverViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_ViolateView:
        {
            viewController = [[ViolateViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_Gas_StopsView:
        {
            viewController = [[Gas_StopsViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_ConsumeRecordView:
        {
            viewController = [[ConsumeRecordViewController alloc] init];
            break;
        }
            
        default:
            break;
    }
    

    [self.navigationController pushViewController:viewController animated:YES];
    
    [viewController release];

}

///Prot/GetUpdateCount.ashx


#pragma mark -

- (void)networkGetUPdateCount
{

    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:1], @"CarID",
                                           [NSNumber numberWithInt:1], @"FAQID",
                                           [NSNumber numberWithInt:1], @"FittingsID",
                                           [NSNumber numberWithInt:1], @"DealerID",
                                           [NSNumber numberWithInt:1], @"ActivityID",                                           
                                           [NSNumber numberWithInt:1], @"MessageID",
                                           nil];
    
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parametersDict, @"Parameters",
                              nil ];
    
    
    dispatch_queue_t loadMoreData = dispatch_queue_create("more data", NULL);
    dispatch_sync(loadMoreData, ^{
        
        NSString  *jsonString = [jsonDict JSONString];        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServer_Prot_GetUpdateCount];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];        [request setHTTPMethod:@"POST"];
        NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:dataM];
        
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
        if (  ! data) {
            
            return;
        }
        NSLog(@"%@", [NSString stringWithUTF8String:[data bytes]]);   
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

#define kSquareSideLengthWidth 98.0f
#define kSquareSideLengthHeight 94.0f
#define kSquareCornerRadius 10.0f
#define kMarginBetweenSquares 0.0f
- (void)loadView
{
    [super loadView];
    
//    10 -21
    CGFloat viewWidth = self.view.frame.size.width;

    NSUInteger numberOfSquaresPerRow = floor(viewWidth / (kSquareSideLengthWidth + kMarginBetweenSquares));

    const CGFloat kInitialXOffset = (viewWidth - (numberOfSquaresPerRow * kSquareSideLengthHeight)) / (float)numberOfSquaresPerRow;
    CGFloat xOffset = kInitialXOffset;
    
    const CGFloat kInitialYOffset = kInitialXOffset;
    CGFloat yOffset = kInitialYOffset;
    
    
    CGRect rectangleBounds = CGRectMake(0.0f,
                                        0.0f,
                                        kSquareSideLengthWidth,
                                        kSquareSideLengthHeight);

    
    for (int i=0 ; i<12; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.frame = CGRectIntegral(CGRectMake(xOffset,
                                                 yOffset,
                                                 rectangleBounds.size.width,
                                                 rectangleBounds.size.height));

        NSString *imagePath = [NSString stringWithFormat:@"index_menu_%d_0", i];
        NSString *highlightiImagePath = [NSString stringWithFormat:@"index_menu_%d_1", i];
        
        
        [button setImage:[UIImage imageNamed:imagePath] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highlightiImagePath] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(menuTap:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+10;
        [self.view addSubview:button];
        
        xOffset += kSquareSideLengthWidth + kMarginBetweenSquares;
        
        if (xOffset > self.view.frame.size.width - kSquareSideLengthWidth)
        {
            xOffset = kInitialXOffset;
            yOffset += kSquareSideLengthHeight + kMarginBetweenSquares;
        }

    }
    
    [self buttonTag:10 badgeNum:@"123"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"汽车助手";
    
    
    UIImage *headImage = [UIImage imageNamed:@"logo"];

    CGRect rect = CGRectMake((320-100- headImage.size.width)/2, 3, headImage.size.width, headImage.size.height);
    
    UIView *headView = [[UIView alloc] initWithFrame:rect];
    headView.backgroundColor = [UIColor clearColor];
    
    _headView = headView;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:headImage];
    headImageView.frame = rect;
    [headView addSubview:headImageView];
        
    [headImageView release];

    self.navigationItem.titleView = headView;
    


}

- (void)viewDidUnload
{

    [self setActivityButton:nil];
    [self setAutoModelButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self networkGetUPdateCount];

    [_headView setHidden:NO];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    
    [activityButton release];
    [autoModelButton release];
    [super dealloc];
}
@end
