//
//  ConsumeRecordViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#define KConsumeRecordID @"id"
#define KConsumeRecordType @"Type"
#define KConsumeRecordPrice @"Price"
#define KConsumeRecordUptime @"Uptime"

#define KSessionUserCousumeTag @"cousumeTag"

#define KCarID @"carid"
#define KCarModel @"carmodel"
#define KCarPayDateTime @"paydatetime"
#define KCarMileage @"mileage"

#import "ConsumeRecordViewController.h"

#import "FMHelper.h"

@implementation ConsumeRecordViewController
@synthesize oilListView = _oilListView;
@synthesize oilListScrollView = _oilListScrollView;
@synthesize oilItemsView = _oilItemsView;
@synthesize oilType = _oilType;
@synthesize tableView = _tableView;
@synthesize oneView = _oneView;
@synthesize twoView = _twoView;
@synthesize addView = _addView;
@synthesize carNumTextField = _carNumTextField;
@synthesize carModelTextField = _carModelTextField;
@synthesize payTimeTextField = _payTimeTextField;
@synthesize currentMilageTextField = _currentMilageTextField;

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

//  初始化  
- (void)initData
{
    //  id  type   price   uptime
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"id", KConsumeRecordID,
                          @"type", KConsumeRecordType,
                          @"price", KConsumeRecordPrice,
                          @"uptime", KConsumeRecordUptime,
                          nil];
    
    NSMutableArray *consumeRecord = [[NSMutableArray alloc] init];

    for (int i =0 ; i<10; i++) {
        [consumeRecord addObject:dict];
    }
    _consumeRecordArray =  consumeRecord;
    
    
}

- (IBAction)addCoume:(id)sender
{
    [self.view addSubview:_addView];
}

//激活引导
- (void)guid
{
    [self.view addSubview:_twoView];
}


- (IBAction)openTwo:(id)sender 
{

    [self.view addSubview:_twoView];
}

- (void)saveCarInfomation
{
    NSString *alertString = nil;
    
    if ( [_carNumTextField.text isEqualToString:@""]) {
        alertString = [NSString stringWithFormat:LocalSTR(@"车牌")];
    }
    if ( [_carModelTextField.text isEqualToString:@""]) {
        alertString = [NSString stringWithFormat:LocalSTR(@"车型")];
    }
    if ( [_payTimeTextField.text isEqualToString:@""]) {
        alertString = [NSString stringWithFormat:LocalSTR(@"购车日期")];
    }
    if ( [_currentMilageTextField.text isEqualToString:@""]) {
        alertString = [NSString stringWithFormat:LocalSTR(@"当前里程")];
    }

    if (alertString != nil) {
        NSLog(@"not  null %@", alertString);
        
        return;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString escopeString:_carNumTextField.text], KUser_Car_num, 
                          [NSString escopeString:_carModelTextField.text], KUser_Car_autoModel, 
                          [NSString escopeString:_payTimeTextField.text], KUser_Car_mileage, 
                          [NSString escopeString:_currentMilageTextField.text], KUser_Car_payTime,                          
                          nil];
    
//    [[FMInsertHelper insertHelper:DBNameDocument] insert:dict :DBTableNameConsumeRecord];
    _carDict = [[NSDictionary alloc] initWithDictionary: dict];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:KUser_Car];   

    [_twoView removeFromSuperview];
    [_oneView removeFromSuperview];
}

- (IBAction)saveCarInfo:(id)sender 
{
    [currentTextField resignFirstResponder];
    [self saveCarInfomation];
    
    [self.tableView reloadData];
}
#pragma mark -  获取油价

#pragma mark -

- (void)networkOliPrice:(NSString *)oliType
{
    
    
    NSMutableDictionary *parametersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           oliType, @"Oil",
                                           @"2012-12-29", @"Time",
                                           [NSNumber numberWithInt:36], @"CityID",
                                           nil];
    
    
    NSDictionary *jsonDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              parametersDict, @"Parameters",
                              nil ];
    
    
    dispatch_queue_t loadMoreData = dispatch_queue_create("more data", NULL);
    dispatch_sync(loadMoreData, ^{
        
        NSString  *jsonString = [jsonDict JSONString];        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServer_Prot_OilPrice_GetOilPrice];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];        [request setHTTPMethod:@"POST"];
        NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:dataM];
        
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:nil];
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

- (IBAction)selectOilItem:(id)sender 
{
    _oilListView.alpha = 0;
    
    UIButton *button = (UIButton *)sender;
    
    _oilType.text =  button.titleLabel.text;
    
//    获取油价
    [self networkOliPrice:button.titleLabel.text];
}

- (IBAction)updateCarInfo:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:KUser_Car];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

-(void)dismissKeyboard {
    [currentTextField resignFirstResponder];
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
    [doneButton addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
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
        self.view.frame = CGRectMake(0, -keyboardSize.height+currentTextField.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        self.view.frame = CGRectMake(0, -keyboardSize.height+20+currentTextField.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
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


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self registerForKeyboardNotifications];
    keyboardWasShown = false;
    
    [_oilListScrollView addSubview:_oilItemsView];
    [_oilListScrollView setContentSize:_oilItemsView.frame.size];
    _oilListView.alpha = 0;
    [self.view addSubview:_oilListView];
    
    self.title = @"cousume";
//     [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"carDict"];   
    NSDictionary *carDict =  [[NSUserDefaults standardUserDefaults] objectForKey:KUser_Car];
    _carDict = [[NSDictionary alloc] initWithDictionary: carDict];
    if (carDict.count > 0) {
        [self initData];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(addCoume:)] autorelease];
    }
    else {
        [self guid];
    }
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setOneView:nil];
    [self setTwoView:nil];
    [self setAddView:nil];
    [self setCarNumTextField:nil];
    [self setCarModelTextField:nil];
    [self setPayTimeTextField:nil];
    [self setCurrentMilageTextField:nil];
    [self setOilType:nil];
    [self setOilListView:nil];
    [self setOilListScrollView:nil];
    [self setOilItemsView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 92;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _consumeRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
//    static NSString *CellIdentifier = @"Cell";
    
//    ActivityTableViewCell *cell = (ActivityTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil];
//        
//        for (id currentObject in topLevelObjects){
//            if ([currentObject isKindOfClass:[UITableViewCell class]]){
//                cell =  (ActivityTableViewCell *) currentObject;
//                break;
//            }
//        }
//    }    
	// Configure the cell.
    
    
//    cell.titleLabel.text = [[self.activityArray objectAtIndex:indexPath.row] objectForKey:KActivity_Title];
    cell.textLabel.text = [[_consumeRecordArray objectAtIndex:indexPath.row] objectForKey:KConsumeRecordPrice];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 92)] autorelease];
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"policy_box"]];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(170, 10, 100, 45);
    [button setTitle:@"重新设置汽车" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateCarInfo:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    UILabel *carNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 100, 45)];
    carNameLabel.text = [NSString stringWithFormat:@"%@", [_carDict objectForKey:KUser_Car_autoModel]];

    
    
    
    
    [headView addSubview:button];    
    [headView addSubview:carNameLabel];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark -

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
    
    [UIView animateWithDuration:.3 animations:^{
        if (currentTextField.frame.origin.y > 80) {
            
            self.view.frame = CGRectMake(0, -currentTextField.frame.origin.y+80, self.view.frame.size.width, self.view.frame.size.height);    
        }
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _oilType) {

        _oilListView.alpha = 1;
        [self.view bringSubviewToFront:_oilListView];
        
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [currentTextField resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);    
    }];
}
- (void)dealloc {
    [_tableView release];
    [_oneView release];
    [_twoView release];
    [_addView release];
    [_carNumTextField release];
    [_carModelTextField release];
    [_payTimeTextField release];
    [_currentMilageTextField release];
    [_oilType release];
    [_oilListView release];
    [_oilListScrollView release];
    [_oilItemsView release];
    [super dealloc];
}

@end
