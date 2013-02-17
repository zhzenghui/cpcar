//
//  AutoModelViewController.h
//  CPCarAssistant
//
//  Created by zeng on 13-2-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AutoModelViewController : RootViewController
{
    NSMutableArray *_autoModelArray;

    int start;
    int count;
    int total;
}

@property (retain, nonatomic) NSMutableArray *autoModelArray;

@end
