//
//  PreserverViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define  KpickerBackgroundViewTag 100


#import "PreserverViewController.h"
#import "TestAutoModelTableViewController.h"
#import "AreaTableViewController.h"
#import "JSONKit.h" 



@implementation PreserverViewController
@synthesize contentScrollView;
@synthesize contentView;
@synthesize manButton;
@synthesize femaleButton;
@synthesize dateTimeLabel;
@synthesize autoModelLabel;
@synthesize provinceLabel;
@synthesize cityLabel;
@synthesize dealerLabel;
@synthesize boutiqueLabel;
@synthesize nameTextField;
@synthesize areaTextField;
@synthesize telphoneTextField;
@synthesize emailTextField;

@synthesize currentTextField;
@synthesize currentLabel;

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
#pragma mark OCCalendarDelegate Methods

- (void)completedWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    
    NSLog(@"startDate:%@, endDate:%@", startDate, endDate);
    
//    [self showToolTip:[NSString stringWithFormat:@"%@ - %@", [df stringFromDate:startDate], [df stringFromDate:endDate]]];
    
    [df release];
    
    [calVC.view removeFromSuperview];
    
    calVC.delegate = nil;
    [calVC release];
    calVC = nil;
}

-(void) completedWithNoSelection{
    [calVC.view removeFromSuperview];
    calVC.delegate = nil;
    [calVC release];
    calVC = nil;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    testDirt = [[NSMutableDictionary alloc] init];
    [testDirt setValue:@"1" forKey:KTestfieldAutoModel];
    [testDirt setValue:@"2013-2-12" forKey:KPreserverPreserveTime];
    
    [testDirt setValue:@"1" forKey:KTestfieldPrivince];
    [testDirt setValue:@"1" forKey:KTestfieldCity];
    [testDirt setValue:@"1" forKey:KTestfieldDealer];
    [testDirt setValue:@"1" forKey:KTestfieldFranchise];    
    
    [testDirt setValue:@"姓名" forKey:KPreserverCustName];   
    [testDirt setValue:@"true" forKey:KPreserverCustSex];   
    [testDirt setValue:@"地区area" forKey:KPreserverCustAddr];    
    [testDirt setValue:@"13122332211" forKey:KPreserverCustPhone];   
    [testDirt setValue:@"qweqwe@qq.com" forKey:KPreserverCustMail];   

    
    [contentScrollView addSubview:contentView];
    [contentScrollView setContentSize:contentView.frame.size];
}

- (void)gender :(NSString *)gender
{
    UIButton *manButtton  = (UIButton *)[contentScrollView viewWithTag:110];
    UIButton *femaleButtton  = (UIButton *)[contentScrollView viewWithTag:111];
    
    [manButtton setImage:[UIImage imageNamed:@"pre_test_quan1.png"] forState:UIControlStateNormal];
    [femaleButtton setImage:[UIImage imageNamed:@"pre_test_quan1.png"] forState:UIControlStateNormal];
    
    if ([gender isEqualToString:@"true"]) {
        
        [femaleButtton setImage:[UIImage imageNamed:@"pre_test_quan.png"] forState:UIControlStateNormal];
    
    }
    else {
        [manButtton setImage:[UIImage imageNamed:@"pre_test_quan.png"] forState:UIControlStateNormal];
        
    }
    
    [testDirt setValue:@"true" forKey:KUserGenderData];

}

- (void)reloadData
{
    autoModelLabel.text = [testDirt objectForKey:KTestfieldAutoModel];
    dateTimeLabel.text = [testDirt objectForKey:KPreserverPreserveTime];
    provinceLabel.text  = [testDirt objectForKey:KTestfieldPrivince];
    cityLabel.text  = [testDirt objectForKey:KTestfieldCity];
    dealerLabel.text  = [testDirt objectForKey:KTestfieldDealer];
    boutiqueLabel.text  = [testDirt objectForKey:KTestfieldFranchise];
    
    nameTextField.text  = [testDirt objectForKey:KUserNameData];
    [self gender:@"true"];
    areaTextField.text  = [testDirt objectForKey:KUserAreaData];
    telphoneTextField.text  = [testDirt objectForKey:KUserTelphoneData];
    emailTextField.text  = [testDirt objectForKey:KUserEmailData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self reloadData];

}

- (void)viewDidUnload
{
    [self setContentScrollView:nil];
    [self setContentView:nil];
    [self setDateTimeLabel:nil];
    [self setAutoModelLabel:nil];
    [self setProvinceLabel:nil];
    [self setCityLabel:nil];
    [self setDealerLabel:nil];
    [self setBoutiqueLabel:nil];
    [self setNameTextField:nil];
    [self setAreaTextField:nil];
    [self setTelphoneTextField:nil];
    [self setEmailTextField:nil];
    [self setManButton:nil];
    [self setFemaleButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)autoModelSelect:(id)sender 
{
    TestAutoModelTableViewController *amVC = [[TestAutoModelTableViewController alloc] init];
    amVC.testDirt = testDirt;
    
    [self.navigationController pushViewController:amVC animated:YES];
    [amVC release];
    
}

- (IBAction)openSelectItem:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case 10:
        {
//            选择车型
            TestAutoModelTableViewController *amVC = [[TestAutoModelTableViewController alloc] init];
            amVC.testDirt = testDirt;
            
            [self.navigationController pushViewController:amVC animated:YES];
            [amVC release];
            
            break;
        }  
        case 11:
        {
//            时间
            [contentScrollView scrollRectToVisible:CGRectMake(0, 98, contentScrollView.frame.size.width, contentScrollView.frame.size.height) animated:YES];
            [self showCalendar:sender];
            
            break;
        }  
        case 12:
        {
//            省
            AreaTableViewController *areaTVC = [[AreaTableViewController alloc] init];
            areaTVC.testDirt = testDirt;
            [self.navigationController pushViewController:areaTVC animated:YES];
            [areaTVC release];
            break;
        }  
        case 13:
        {
//            市
            break;
        }  
        case 14:
        {
//            经销商
            break;
        }  
        case 15:
        {
//            专营店
            break;
        } 
        default:
            break;
    }

}

- (IBAction)setGender:(id)sender 
{
    UIButton *button  = (UIButton *)sender;
    switch (button.tag) {
        case 110:
        {
            [self gender:0];
            break;
        }   
        case 111:
        {
            [self gender:1];
            break;
        }
        default:
            break;
    }
}

- (IBAction)submitPreserverInfo:(id)sender 
{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    dispatch_queue_t queue = dispatch_queue_create("preserver", NULL);  
    
    dispatch_async(queue, ^(void) {
    
        NSString  *jsonString = [testDirt JSONString];
        NSLog(@"return preserver: %@", jsonString);
        
        NSString *urlString = [NSString stringWithFormat:KServerUrl, KServerPreserverAdd];

        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];
        
        
        [request setHTTPMethod:@"POST"];
        NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:dataM];
        
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        if (data) {

            NSLog(@"return preserv data: %@", [NSString stringWithUTF8String:[data bytes]]);    
        }
        else {
            NSLog(@"return preserv data: NULL");
        }

            
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });  
}


#pragma mark - 
#pragma mark UIDatePicker 

-(void)dateChanged:(id)sender{  
    UIDatePicker* control = (UIDatePicker*)sender;  
    NSDate* _date = control.date;  
    /*添加你自己响应代码*/  
    
    NSLog(@"%@", _date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    //    NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];   
    //    
    //    //取得本地目前时间  
    //    
    //    for(NSString *name in timeZoneNames) {   
    //        NSLog(@"%@", name);
    ////        NSTimeZone *timezone = [[NSTimeZone alloc] initWithName:name];   
    ////        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];   
    //    }
    NSString *stringFromDate = [formatter stringFromDate:_date];
    

//    currentLabel.text = stringFromDate;
    
    [formatter release];
}  

- (IBAction)closePickerView:(id)sender
{
    UIView *backgroundView = (UIView *)[self.view viewWithTag:KpickerBackgroundViewTag];
    
    [backgroundView removeFromSuperview];
}

-  (IBAction)showCalendar:(id)sender
{
    UIView *pickerBackgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    pickerBackgroundView.tag = KpickerBackgroundViewTag;
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePickerView:)];
    
    tapGestureRecognizer.numberOfTouchesRequired = 1;    //触摸点个数，另作：[singleOne setNumberOfTouchesRequired:1];
    tapGestureRecognizer.numberOfTapsRequired = 1;  
    
    [pickerBackgroundView addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer release];
    
    ////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////    
    NSDate* _date = [NSDate date];  
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
    datePickerView.frame = CGRectMake(0, 254, 320, 100);
    
    datePickerView.datePickerMode = UIDatePickerModeDate;  
    datePickerView.minuteInterval = 5;  
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateParts = [[NSDateComponents alloc] init];
    [dateParts setMonth:5];
    [dateParts setYear:2020];
    [dateParts setDay:8];
    
    NSDate *maxDate = [calendar dateFromComponents:dateParts];
    [dateParts release];
    
    //    dateParts = [[NSDateComponents alloc] init];
    //    [dateParts setMonth:1];
    //    [dateParts setYear:2013];
    //    [dateParts setDay:1];
    //    
    //    NSDate *minDate = [calendar dateFromComponents:dateParts];
    //    [dateParts release];
    
    datePickerView.minimumDate = _date;  
    datePickerView.maximumDate = maxDate;  
    datePickerView.date = _date;  
    
    [datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];  
    [pickerBackgroundView addSubview:datePickerView];
    
    [self.view addSubview:pickerBackgroundView];
}


#pragma mark 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [currentTextField resignFirstResponder];    
}

#pragma mark --- textField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect rect = CGRectMake(0, textField.frame.origin.y +10, contentScrollView.frame.size.width, contentScrollView.frame.size.height  );
    
    [contentScrollView scrollRectToVisible:rect animated:YES];
    
    currentTextField = textField;
    
}



//- (NSString *)escopeString:(NSString *)inputStirng
//{
//    NSString *outString ;
//    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"'" withString:@""];
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@" " withString:@""];
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"~" withString:@""];
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"!" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"@" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"#" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"$" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"%" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"|" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"&" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"^" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"*" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"(" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@")" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"-" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"+" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"_" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"=" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"/" withString:@""];    
//    outString = [inputStirng stringByReplacingOccurrencesOfString:@"." withString:@""];    
//
//    return  outString;
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//
//{
//    NSCharacterSet *cs;
//    
//    cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
//    
//    NSString *filter = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//        
//    BOOL bTest = [string isEqualToString:filter];
//    
//    return bTest;
//    
//}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *textString = [NSString escopeString: textField.text];
    if (textField == nameTextField && nameTextField.text.length > 0) {
        [testDirt setValue:textString forKey:KUserNameData];
    }
    else if (textField == areaTextField && areaTextField.text.length > 0) {
        [testDirt setValue:textString forKey:KUserAreaData];
    }
    else if (textField == telphoneTextField && telphoneTextField.text.length > 0) {
        [testDirt setValue:textString forKey:KUserTelphoneData];
    }
    else if (textField == emailTextField && emailTextField.text.length > 0) {
        [testDirt setValue:textString forKey:KUserEmailData];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)dealloc {
    [contentScrollView release];
    [contentView release];
    [dateTimeLabel release];
    [autoModelLabel release];
    [provinceLabel release];
    [cityLabel release];
    [dealerLabel release];
    [boutiqueLabel release];
    [nameTextField release];
    [areaTextField release];
    [telphoneTextField release];
    [emailTextField release];
    
    [testDirt release];
    [manButton release];
    [femaleButton release];
    [super dealloc];
}


@end
