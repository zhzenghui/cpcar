//
//  PreserverViewController.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCalendar.h"


@interface PreserverViewController : UIViewController<PMCalendarControllerDelegate,UITextFieldDelegate, UIScrollViewDelegate>
{
    NSMutableDictionary *testDirt;
    
    NSMutableData *_data;

}

- (IBAction)autoModelSelect:(id)sender;
- (IBAction)showCalendar:(id)sender;
- (IBAction)openSelectItem:(id)sender;
- (IBAction)setGender:(id)sender;
- (IBAction)submitPreserverInfo:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *currentTextField;


@property (nonatomic, strong) PMCalendarController *pmCC;

@property (retain, nonatomic) IBOutlet UIButton *manButton;
@property (retain, nonatomic) IBOutlet UIButton *femaleButton;

@property (retain, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *autoModelLabel;
@property (retain, nonatomic) IBOutlet UILabel *provinceLabel;
@property (retain, nonatomic) IBOutlet UILabel *cityLabel;
@property (retain, nonatomic) IBOutlet UILabel *dealerLabel;
@property (retain, nonatomic) IBOutlet UILabel *boutiqueLabel;

@property (retain, nonatomic) IBOutlet UITextField *nameTextField;
@property (retain, nonatomic) IBOutlet UITextField *areaTextField;
@property (retain, nonatomic) IBOutlet UITextField *telphoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;


@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
@end
