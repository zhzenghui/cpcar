//
//  PreserverViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PreserverViewController.h"
#import "TestAutoModelTableViewController.h"
#import "AreaTableViewController.h"
#import "JSONKit.h" 



@implementation PreserverViewController
@synthesize contentScrollView;
@synthesize contentView;
@synthesize pmCC;
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

    testDirt = [[NSMutableDictionary alloc] init];
    [testDirt setValue:@"1" forKey:KTestfieldAutoModel];
    [testDirt setValue:@"time：" forKey:KPreserverPreserveTime];
    
    [testDirt setValue:@"省：" forKey:KTestfieldPrivince];
    [testDirt setValue:@"市：" forKey:KTestfieldCity];
    [testDirt setValue:@"经销商：" forKey:KTestfieldDealer];
    [testDirt setValue:@"专营店：" forKey:KTestfieldFranchise];    
    
    [testDirt setValue:@"姓名" forKey:KUserNameData];   
    [testDirt setValue:@"1" forKey:KUserGenderData];   
    [testDirt setValue:@"地区area" forKey:KUserAreaData];   
    [testDirt setValue:@"13122332211：" forKey:KUserTelphoneData];   
    [testDirt setValue:@"qweqwe@qq.com：" forKey:KUserEmailData];   

    
    [contentScrollView addSubview:contentView];
    [contentScrollView setContentSize:contentView.frame.size];
}

- (void)gender :(int)gender
{
    UIButton *manButtton  = (UIButton *)[contentScrollView viewWithTag:110];
    UIButton *femaleButtton  = (UIButton *)[contentScrollView viewWithTag:111];
    
    [manButtton setImage:[UIImage imageNamed:@"pre_test_quan1.png"] forState:UIControlStateNormal];
    [femaleButtton setImage:[UIImage imageNamed:@"pre_test_quan1.png"] forState:UIControlStateNormal];
    
    if (gender == 1) {
        
        [femaleButtton setImage:[UIImage imageNamed:@"pre_test_quan.png"] forState:UIControlStateNormal];
    
    }
    else {
        [manButtton setImage:[UIImage imageNamed:@"pre_test_quan.png"] forState:UIControlStateNormal];
        
    }
    
    [testDirt setValue:[NSNumber numberWithInt:gender] forKey:KUserGenderData];

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
    [self gender:[[testDirt objectForKey:KUserGenderData] intValue]];
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

    
    NSString  *jsonString = [testDirt JSONString];
    NSLog(@"return preserv %@", jsonString);
    
    NSString *urlString = [NSString stringWithFormat:@"%@", KServerUrl, KServerPreserver];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                             timeoutInterval:UPLOAD_TIME_OUT] autorelease];
    
    
    [request setHTTPMethod:@"POST"];
    NSData * dataM = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:dataM];
    
    
    NSURLConnection * connec = [NSURLConnection connectionWithRequest:request delegate:self];
    [connec start];

    if (_data) {
        [_data setLength:0];
    }
}

#pragma mark connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response respondsToSelector:@selector(statusCode)])
	{
		int statusCode = [((NSHTTPURLResponse *)response) statusCode];
		if (statusCode >= 400)
		{
			[connection cancel];
            NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                                                                          NSLocalizedString(@"Server returned status code %d",@""),
                                                                          statusCode]
                                                                  forKey:NSLocalizedDescriptionKey];
            NSError *statusError = [NSError errorWithDomain:@"hyndai.com"
                                                       code:statusCode
                                                   userInfo:errorInfo];
            
            NSLog(@"%@",[statusError localizedDescription]); 

            //            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提交失败!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alertView show];
            //            [alertView release];
            

			return;
		}
	}
	
    
    
    if (_data) {
        [_data setLength:0];
    }
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [_data appendData:data];
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading \n");

    
    NSString *strRes = [[NSString alloc] initWithBytes:[_data bytes] length:[_data length] encoding:NSUTF8StringEncoding];
    
    if ([strRes isEqualToString:@"1"]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提交成功!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提交失败!" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [alertView release];
    }
    

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError %@\n",[error debugDescription]);


    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提交失败!" message:@"连接服务器失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}


#pragma mark PMCalendarControllerDelegate methods
- (IBAction)showCalendar:(id)sender
{
    self.pmCC = [[PMCalendarController alloc] init];
    pmCC.delegate = self;
    pmCC.mondayFirstDayOfWeek = YES;
    
    [pmCC presentCalendarFromView:sender 
         permittedArrowDirections:PMCalendarArrowDirectionAny 
                         animated:YES];
    /*    [pmCC presentCalendarFromRect:[sender frame]
     inView:[sender superview]
     permittedArrowDirections:PMCalendarArrowDirectionAny
     animated:YES];*/
    [self calendarController:pmCC didChangePeriod:pmCC.period];
}
- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    NSLog(@"%@", [NSString stringWithFormat:@"%@ - %@"  , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]  , [newPeriod.endDate dateStringWithFormat:@"dd-MM-yyyy"]]
                  );
    dateTimeLabel.text = [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"];
    
    [testDirt setObject:[newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"] forKey:KPreserverPreserveTime];

//    periodLabel.text = [NSString stringWithFormat:@"%@ - %@"
//                        , [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]
//                        , [newPeriod.endDate dateStringWithFormat:@"dd-MM-yyyy"]];
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
    if (textField == nameTextField) {
        [testDirt setValue:textString forKey:KUserNameData];
    }
    else if (textField == areaTextField) {
        [testDirt setValue:textString forKey:KUserAreaData];
    }
    else if (textField == telphoneTextField) {
        [testDirt setValue:textString forKey:KUserTelphoneData];
    }
    else if (textField == emailTextField) {
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
