//
//  DatePickerView.h
//  CPCarAssistant
//
//  Created by zeng on 13-2-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDalegate <NSObject>

- (void)dateChanged:(id)sender;

@end

@interface DatePickerView : UIView
{
    id<DatePickerViewDalegate> dategate;
}
@property (retain, nonatomic) IBOutlet UIDatePicker *datePickerView;
@end
