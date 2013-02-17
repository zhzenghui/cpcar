//
//  ConsumeRecordViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumeRecordViewController : UIViewController<UITextFieldDelegate>
{
//    ConsumeRecordI
    NSMutableArray *_consumeRecordArray;
    NSDictionary *_carDict;
    
    UITextField *currentTextField;
    bool keyboardWasShown ;

    
}
//////////////////////////////////////////////////
@property (retain, nonatomic) IBOutlet UIView *oilListView;
@property (retain, nonatomic) IBOutlet UIScrollView *oilListScrollView;
@property (retain, nonatomic) IBOutlet UIView *oilItemsView;


//////////////////////////////////////////////////

@property (retain, nonatomic) IBOutlet UITextField *oilType;


//////////////////////////////////////////////////
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *oneView;
@property (retain, nonatomic) IBOutlet UIView *twoView;
@property (retain, nonatomic) IBOutlet UIView *addView;

@property (retain, nonatomic) IBOutlet UITextField *carNumTextField;
@property (retain, nonatomic) IBOutlet UITextField *carModelTextField;
@property (retain, nonatomic) IBOutlet UITextField *payTimeTextField;
@property (retain, nonatomic) IBOutlet UITextField *currentMilageTextField;

- (IBAction)openTwo:(id)sender;
- (IBAction)saveCarInfo:(id)sender;
- (IBAction)selectOilItem:(id)sender;
@end
