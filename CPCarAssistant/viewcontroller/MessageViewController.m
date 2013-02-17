//
//  MessageViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MessageViewController.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "JSONKit.h"
#import "FMHelper.h"

#include "OpenUDID.h"

@implementation MessageViewController
@synthesize sendTextView;
@synthesize bubbleTableView;
@synthesize bottomImageView;

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

- (NSDate * )NSStringToNSDate: (NSString * )string
{    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"YYYY-LL-dd HH:mm:ss"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ZH_CN"];
    [formatter setLocale:locale];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];

    NSDate *date = [formatter dateFromString :string];
    [formatter release];
    return date;
}

- (void)sortArray
{

}

- (void)reloadData
{
    [self sortArray];
    for (int i=0; i < bubbleArray.count; i ++) {
            
        NSDictionary *dict = [bubbleArray objectAtIndex:i];

        NSBubbleType bubbleType = BubbleTypeMine;
        
        if (i%2 ==0) {
            bubbleType = BubbleTypeSomeoneElse;
        }
        
        NSDate *myDate = [dict objectForKey:@"UpTime"];

        
        NSBubbleData *bdata  = [NSBubbleData dataWithText:[dict objectForKey:@"Message"] 
                                                  andDate:myDate
                                                  andType:bubbleType];
        [bubbleDataArray addObject:bdata];
    }
    
    [bubbleTableView reloadData];
}
- (void)closeKeyboard
{
    [sendTextView resignFirstResponder];
}


#pragma mark -  db

- (void)saveDictToDB:(NSArray *)array
{
    [[FMInsertHelper insertHelper:DBNameDocument] insertData:array :DBTableNameMessage];
}


#pragma mark - key board


- (void) registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];  ; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeRerurnButton:(UIView *)keyboardView
{
    UIButton *doneButton = (UIButton *)[keyboardView viewWithTag:1000];
    if (doneButton) {
        [doneButton removeFromSuperview];   
    }
}

- (void)addReturnKeyButton:(CGRect)doneButtonRect
{
    
    //    http://www.neoos.ch/blog/37-uikeyboardtypenumberpad-and-the-missing-return-key
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = doneButtonRect;
    doneButton.tag = 1000;
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(hiddenKeyBord:) forControlEvents:UIControlEventTouchUpInside];
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        NSLog(@"%@", keyboard);
        // keyboard found, add the button
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
            if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
            {   
                [self removeRerurnButton:keyboard];
                [keyboard addSubview:doneButton];
            }
        } else {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:doneButton];
        }
    }
    
}

- (void) keyboardWasShown:(NSNotification *) notif{ 
    NSDictionary *info = [notif userInfo]; 
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey]; 
    CGSize keyboardSize = [value CGRectValue].size; 
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216 
    
    CGRect doneButtonRect = CGRectMake(243-16, 174-7, 106, 53);
    if (keyboardSize.height == 252) {
        doneButtonRect = CGRectMake(243-16, 174-7+36, 106, 53); 
    }
    
    keyboardWasShown = NO;
    
    NSLog(@"keyBoard:%f", self.view.frame.size.height);  //216 
    if (self.view.frame.size.height == 416) {
        self.view.frame = CGRectMake(0, -keyboardSize.height, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        self.view.frame = CGRectMake(0, -keyboardSize.height+20, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [self addReturnKeyButton:doneButtonRect];
} 
- (void) keyboardWasHidden:(NSNotification *) notif{ 
    NSDictionary *info = [notif userInfo]; 
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey]; 
    CGSize keyboardSize = [value CGRectValue].size; 
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height); 
    // keyboardWasShown = NO; 
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    keyboardWasShown = NO;
    
    
}

-(void)dismissKeyboard {
    [sendTextView resignFirstResponder];
}

#pragma mark - messageNetwork

- (void)messageIsDownload:(BOOL)isDownload :(NSBubbleData *)bData
{
    //    下载 还是提交
    NSNumber  *download = [NSNumber numberWithBool:isDownload];
    
    //    lastid
    int lastId = [[FMQueryHelper queryHelper:DBNameDocument] queryLastID:DBTableNameMessage];
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           download , @"IsDownload", 
                                           [OpenUDID value], @"UDID",
                                           @"1", @"Dealer",
                                           [NSNumber numberWithInt:lastId], @"LastID",
                                           nil];
    NSMutableDictionary *updateDataDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [OpenUDID value], KMessageUDID,
                                     bData.text, KMessageMessage,
                                     @"1", KMessageDealer,
                                     @"2011-1-1", KMessageUpTime,
                                     nil ];
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parametersDict, @"Parameters",
                              updateDataDict, @"Data",nil ];
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("preserver", NULL);  
    dispatch_async(queue, ^(void) {
        
        NSString  *jsonString = [jsonDict JSONString];        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServerMessageAdd];
        
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

            if (isDownload) {

//                获取最新数据，  更新本地数据库
                if ( [[dataDict objectForKey:@"IsNull"] isEqualToNumber:[NSNumber numberWithBool: true]] ) {
                    
                    debugLog(@"update local db");
                    [self saveDictToDB:[dataDict objectForKey:@"Data"]];      
                    [self reloadData];
                }
                else {
                    debugLog(@"no update record");
                }
                
            }
            else {
                
//                提交留言成功，  更新本地数据  
                if ( [[dataDict objectForKey:@"IsSuccess"] isEqualToNumber:[NSNumber numberWithBool: true]] ) {
                    NSLog(@"secuess");
                    NSDictionary *messageDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  [OpenUDID value], KMessageUDID,
                                                  bData.text, KMessageMessage,
                                                  @"1", KMessageDealer,
                                                  [[[dataDict objectForKey:@"Data"] objectAtIndex:0] objectForKey:KMessageUpTime], KMessageUpTime,
                                                  [[[dataDict objectForKey:@"Data"] objectAtIndex:0] objectForKey:KMessageId], KMessageId,
                                                  nil 
                                                 ];

                    [self saveDictToDB:[NSArray arrayWithObject:messageDict]];  
                    [self scrollToButtom:YES];


                }
                else {
                    NSLog(@"update  faild");

                }
            }
            
        }
        else {
            NSLog(@"return preserv data: NULL");
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });  
    
    dispatch_release(queue);
}

- (void)reflash:(BOOL)isDownload
{
    [self messageIsDownload:true :NULL];
}


#pragma mark - message   loacl 

- (void)scrollToButtom :(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:20 inSection:0];
//    [bubbleTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)scrollToTop :(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [bubbleTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}


- (IBAction)sendText:(id)sender 
{
    NSBubbleData *bData = [NSBubbleData dataWithText: sendTextView.text andDate:[NSDate dateWithTimeIntervalSinceNow:400]  andType:BubbleTypeMine];
    [bubbleDataArray insertObject:bData atIndex:0];
    [bubbleTableView reloadData];
    
    [self messageIsDownload:false :bData];
}


- (void)updateIsLoadStatue
{
    isLoad = true;
}
//  加载旧的 
- (void)loadLastData
{
    if (pageCurrent < pageMax) {
        pageCurrent ++;
        [bubbleArray addObjectsFromArray:[[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameMessage page:pageCurrent pagSize:pageSize]];    
        [self reloadData];
        
        [self scrollToTop:NO];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateIsLoadStatue) userInfo:nil repeats:NO];
    }
    else{
        NSLog(@"load all");
    }
}

#pragma mark scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.y < -65 && isLoad) {
        NSLog(@"%f", scrollView.contentOffset.y);
        
        isLoad = false;
        [self loadLastData];
    }
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [NSString stringWithFormat:@""];
    [super viewDidLoad];
    self.title = @"message";
    pageCurrent = 0;
    pageSize = 20;
    
    
    [self registerForKeyboardNotifications];
    keyboardWasShown = false;
    
    int dataCount = [[FMQueryHelper queryHelper:DBNameDocument] queryDataCount:DBTableNameMessage];
    pageMax = dataCount /pageSize;

    
    isLoad = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    
    [self.bubbleTableView addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer release];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(reflash:)];
    
    
    bubbleTableView.bubbleDataSource = self;
    bubbleTableView.delegate = self;
    sendTextView.layer.cornerRadius = 4;
    
    bubbleArray  = [[NSMutableArray alloc] initWithArray:
                    [[FMQueryHelper queryHelper:DBNameDocument] queryTableData:DBTableNameMessage page:pageCurrent pagSize:pageSize]
                    ];
    bubbleDataArray = [[NSMutableArray alloc] init];
}
- (void)viewDidAppear:(BOOL)animated
{
    

}
- (void)viewWillAppear:(BOOL)animated
{
        
    [self reloadData];

}

- (void)viewDidUnload
{
    [self setSendTextView:nil];
    [self setBottomImageView:nil];
    [self setBubbleTableView:nil];
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
    [sendTextView release];
    [bottomImageView release];
    [bubbleTableView release];
    [super dealloc];
}


#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleDataArray count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleDataArray objectAtIndex:row];
}

#pragma mark - textView

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    self.view.frame = CGRectMake(0, -236, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length != 1 && [text isEqualToString:@"\n"]) {
        sendTextView.frame = CGRectMake(sendTextView.frame.origin.x, 384-60, sendTextView.frame.size.width, 88);
    }
    
    return YES;
}

@end
