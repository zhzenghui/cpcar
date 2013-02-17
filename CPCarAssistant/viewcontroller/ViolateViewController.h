//
//  ViolateViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViolateViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (retain, nonatomic) IBOutlet UIView *contentView;
- (IBAction)saveCarInfo:(id)sender;
@end
