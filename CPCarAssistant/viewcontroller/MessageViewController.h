//
//  MessageViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableView.h"


@interface MessageViewController : UIViewController <UIBubbleTableViewDataSource,UITextViewDelegate>
{
    
    NSMutableArray *bubbleArray;
    NSMutableArray *bubbleDataArray;

    bool keyboardWasShown;

    
    bool isLoad;
    
    int pageMax;
    int pageCurrent;
    int pageSize;
    
}

@property (retain, nonatomic) IBOutlet UITextView *sendTextView;
@property (retain, nonatomic) IBOutlet UIBubbleTableView *bubbleTableView;
@property (retain, nonatomic) IBOutlet UIImageView *bottomImageView;
- (IBAction)sendText:(id)sender;

- (void)scrollToButtom :(BOOL)animated;

@end
