//
//  CustomButton.h
//  CPCarAssistant
//
//  Created by zeng on 13-2-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
{
    NSString *badgeText;
    CGFloat badgeScaleFactor;

}

@property(nonatomic,retain) NSString *badgeText;

@end
