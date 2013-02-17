//
//  AutoModelPMViewController.h
//  CPCarAssistant
//
//  Created by zeng on 12-12-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoModelPMViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *menuTap;

- (IBAction)menuTapInside:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *pmScrollView;
@property (retain, nonatomic) IBOutlet UIView *detailView;
@property (retain, nonatomic) IBOutlet UIImageView *menuImageView;
@end
