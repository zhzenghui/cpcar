//
//  TestDriveViewController.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define  KpickerBackgroundViewTag 100

#import "TestDriveViewController.h"
#import "TestAutoModelTableViewController.h"

#import "AreaTableViewController.h"

//#import "HZAreaPickerView.h"

//@interface TestDriveViewController () <UITextFieldDelegate, HZAreaPickerDelegate>
//
//@property (retain, nonatomic) IBOutlet UITextField *areaText;
//@property (retain, nonatomic) IBOutlet UITextField *cityText;
//@property (strong, nonatomic) NSString *areaValue, *cityValue;
//@property (strong, nonatomic) HZAreaPickerView *locatePicker;
//
//-(void)cancelLocatePicker;
//
//@end

@implementation TestDriveViewController
@synthesize provinceLabel;
@synthesize cityLabel;
@synthesize dealerLabel;
@synthesize BoutiqueLabel;
@synthesize nameTextField;
@synthesize areaTextField;
@synthesize telphoneTextField;
@synthesize emailTextField;
@synthesize contentScrollView;
@synthesize contentView;
@synthesize tableView = _tableView;
@synthesize testAutoModel;
@synthesize autoModelLabel;
@synthesize boutiqueLabel;
@synthesize dateTimeLabel;
@synthesize payDateTimeLabel;
@synthesize currentTextField;
@synthesize currentButton;
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
    
    [testDirt setValue:[NSNumber numberWithInt:gender] forKey:KPreserverCustSex];
    
}
- (void)reloadData
{
    autoModelLabel.text = [testDirt objectForKey:KTestfieldAutoModel];
    dateTimeLabel.text = [testDirt objectForKey:KPreserverPreserveTime];
    provinceLabel.text  = [testDirt objectForKey:KTestfieldPrivince];
    cityLabel.text  = [testDirt objectForKey:KTestfieldCity];
    dealerLabel.text  = [testDirt objectForKey:KTestfieldDealer];
    boutiqueLabel.text  = [testDirt objectForKey:KTestfieldFranchise];
    
    nameTextField.text  = [testDirt objectForKey:KPreserverCustName];
    [self gender:[[testDirt objectForKey:KPreserverCustSex] intValue]];
    areaTextField.text  = [testDirt objectForKey:KPreserverCustAddr];
    telphoneTextField.text  = [testDirt objectForKey:KPreserverCustPhone];
    emailTextField.text  = [testDirt objectForKey:KPreserverCustMail];
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

    currentLabel.text = stringFromDate;
    
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


#pragma mark -


- (IBAction)openSelectItem:(id)sender 
{
    UIButton *button = (UIButton *)sender;
    currentButton = button;
    
    
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
            [contentScrollView scrollRectToVisible:CGRectMake(0, button.frame.origin.y, contentScrollView.frame.size.width, contentScrollView.frame.size.height) animated:YES];
            currentLabel = dateTimeLabel;
            [self showCalendar:sender];
            break;
        }   
        case 111:
        {
            //            时间
            [contentScrollView scrollRectToVisible:CGRectMake(0, button.frame.origin.y, contentScrollView.frame.size.width, contentScrollView.frame.size.height) animated:YES];
            currentLabel = payDateTimeLabel;
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


#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
  
	// Configure the cell.
    
    switch (indexPath.section ) {
        case 0:
        {
            cell.textLabel.text = [testDirt objectForKey:KTestfieldAutoModel];
            cell.detailTextLabel.text = [testDirt objectForKey:KTestfieldAutoModel];
            break;
        }   
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = [testDirt objectForKey:KTestfieldPrivince];
                    cell.detailTextLabel.text = [testDirt objectForKey:KTestfieldPrivince];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = [testDirt objectForKey:KTestfieldCity];
                    cell.detailTextLabel.text = [testDirt objectForKey:KTestfieldCity];
                    break;
                }
                case 2:
                {
                    cell.textLabel.text = [testDirt objectForKey:KTestfieldDealer];
                    cell.detailTextLabel.text = [testDirt objectForKey:KTestfieldDealer];
                    break;
                }
                case 3:
                {
                    cell.textLabel.text = [testDirt objectForKey:KTestfieldFranchise];
                    cell.detailTextLabel.text = [testDirt objectForKey:KTestfieldFranchise];
                    break;
                }
                default:
                    break;
            }
        }
        default:
            break;
    }


//    cell.imageView = 
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *headerView = [[[UIView alloc] init] autorelease];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 3, 15, 10)];
    numLabel .text = [NSString stringWithFormat:@"%d", section+1];
    [headerView addSubview:numLabel];
    [numLabel release];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 20)];
    
    switch (section) {
        case 0:
        {

            contentLabel.text = @"请选择您想试驾的车型";
            break;
        }
        case 1:
        {
            contentLabel.text = @"请选择您的地区和经销商";
            break;
        }
        default:
            break;
    }
    [headerView addSubview:contentLabel];
    [contentLabel release];
    
    
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            TestAutoModelTableViewController *tamtvc = [[TestAutoModelTableViewController alloc] init];
            tamtvc.testDirt = testDirt;
            [self.navigationController pushViewController:tamtvc animated:YES];            
            [tamtvc release];
            break;
        }   
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    AreaTableViewController *areaTVC = [[AreaTableViewController alloc] init];
                    areaTVC.testDirt = testDirt;
                    [self.navigationController pushViewController:areaTVC animated:YES];
                    [areaTVC release];
                    break;
                }
            }
            break;
        }
        default:
            break;
    }

}


//#pragma mark -  
//-(void)setAreaValue:(NSString *)areaValue
//{
//    if (![_areaValue isEqualToString:areaValue]) {
//        _areaValue = [areaValue retain];
//        self.areaText.text = areaValue;
//    }
//}
//
//-(void)setCityValue:(NSString *)cityValue
//{
//    if (![_cityValue isEqualToString:cityValue]) {
//        _cityValue = [cityValue retain];
//        self.cityText.text = cityValue;
//    }
//}
//#pragma mark - HZAreaPicker delegate
//-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
//{
//    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
//        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
//        
//        [testDirt setValue:picker.locate.state forKey:KTestfieldPrivinceData];
//
//        [testDirt setValue:picker.locate.city forKey:KTestfieldCityData];
//    } else{
//        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
//        [testDirt setValue:picker.locate.state forKey:KTestfieldPrivinceData];
//        
//        [testDirt setValue:picker.locate.city forKey:KTestfieldCityData];
//        
//    }
//}
//
//-(void)cancelLocatePicker
//{
//    [self.locatePicker cancelPicker];
//    self.locatePicker.delegate = nil;
//    self.locatePicker = nil;
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self cancelLocatePicker];
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    testDirt = [[NSMutableDictionary alloc] init];

    
    [testDirt setValue:@"试驾车型" forKey:KTestfieldAutoModel];
    [testDirt setValue:@"省：" forKey:KTestfieldPrivince];
    [testDirt setValue:@"市：" forKey:KTestfieldCity];
    [testDirt setValue:@"经销商：" forKey:KTestfieldDealer];
    [testDirt setValue:@"专营店：" forKey:KTestfieldFranchise];    

    [testDirt setValue:@"c50" forKey:KTestfieldAutoModel];
    [testDirt setValue:@"北京" forKey:KTestfieldPrivince];
    [testDirt setValue:@"北京" forKey:KTestfieldCity];
    [testDirt setValue:@"c次经销商：" forKey:KTestfieldDealer];
    [testDirt setValue:@"c专营店：" forKey:KTestfieldFranchise];   

    
    [testDirt setValue:@"姓名" forKey:KPreserverCustName];   
    [testDirt setValue:@"性别" forKey:KPreserverCustSex];   
    [testDirt setValue:@"地区area" forKey:KPreserverCustAddr];   
    [testDirt setValue:@"telphone：" forKey:KPreserverCustPhone];   
    [testDirt setValue:@"email：" forKey:KPreserverCustMail];   
    [testDirt setValue:@"testTime：" forKey:KPreserverPreserveTime];   

    
    [contentScrollView addSubview:contentView];
    [contentScrollView setContentSize:contentView.frame.size];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [_tableView reloadData];
    
}
- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setContentView:nil];
    [self setContentScrollView:nil];
    [self setTestAutoModel:nil];
    [self setProvinceLabel:nil];
    [self setCityLabel:nil];
    [self setDealerLabel:nil];
    [self setBoutiqueLabel:nil];
    [self setNameTextField:nil];
    [self setAreaTextField:nil];
    [self setTelphoneTextField:nil];
    [self setEmailTextField:nil];
    [self setDateTimeLabel:nil];
    [self setPayDateTimeLabel:nil];
    [self setAutoModelLabel:nil];
    [self setBoutiqueLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
//    [self cancelLocatePicker];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
    [testDirt release];
    [contentView release];
    [contentScrollView release];
    [testAutoModel release];
    [provinceLabel release];
    [cityLabel release];
    [dealerLabel release];
    [BoutiqueLabel release];
    [nameTextField release];
    [areaTextField release];
    [telphoneTextField release];
    [emailTextField release];
    [dateTimeLabel release];
    [payDateTimeLabel release];
    [autoModelLabel release];
    [boutiqueLabel release];
    [super dealloc];
}
@end
