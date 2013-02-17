//
//  TestDriveViewController.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DatePickerView.h"

@interface TestDriveViewController : UIViewController<DatePickerViewDalegate >
{
    NSMutableDictionary *testDirt;
    
}


- (IBAction)openSelectItem:(id)sender;


@property (retain, nonatomic) IBOutlet UITextField *currentTextField;
@property (retain, nonatomic) IBOutlet UILabel *currentLabel;

@property (retain, nonatomic) IBOutlet UIButton *currentButton;


@property (retain, nonatomic) IBOutlet UILabel *autoModelLabel;
@property (retain, nonatomic) IBOutlet UILabel *boutiqueLabel;

@property (retain, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *payDateTimeLabel;

@property (retain, nonatomic) IBOutlet UILabel *provinceLabel;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
@property (retain, nonatomic) IBOutlet UILabel *dealerLabel;
@property (retain, nonatomic) IBOutlet UILabel *BoutiqueLabel;

@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *areaTextField;
@property (retain, nonatomic) IBOutlet UITextField *telphoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;



@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;




@property (retain, nonatomic) IBOutlet UILabel *testAutoModel;
@end
