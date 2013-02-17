//
//  CPAppDelegate.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPViewController;

@interface CPAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
    IBOutlet UINavigationController *navController;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CPViewController *viewController;
@property (strong, nonatomic) UINavigationController *navController;


@end
