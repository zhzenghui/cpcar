//
//  SysSettingViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SysSettingViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *offButton;


- (IBAction)switchOnorOff:(id)sender;
- (IBAction)cleanCacheData:(id)sender;
@end
