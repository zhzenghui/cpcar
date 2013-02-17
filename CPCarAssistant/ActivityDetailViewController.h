//
//  ActivityDetailViewController.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailViewController : UIViewController
{
    NSDictionary *_activityDict;
}

@property (retain, nonatomic) NSDictionary *activityDict;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *activityTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel *dealerLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneLabel;
@property (retain, nonatomic) IBOutlet UILabel *supTime;
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;
@end
