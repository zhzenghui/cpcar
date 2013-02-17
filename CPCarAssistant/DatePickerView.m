//
//  DatePickerView.m
//  CPCarAssistant
//
//  Created by zeng on 13-2-1.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
@synthesize datePickerView;


-(void)dateChanged:(id)sender{  
    UIDatePicker* control = (UIDatePicker*)sender;  
    NSDate* _date = control.date;  
    /*添加你自己响应代码*/  
    
    [dategate dateChanged:sender];
}  

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSDate* _date = [NSDate date];  
        self = [[[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] objectAtIndex:0] retain];

        datePickerView.datePickerMode = UIDatePickerModeDate;  
        datePickerView.minuteInterval = 5;  
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateParts = [[NSDateComponents alloc] init];
        [dateParts setMonth:5];
        [dateParts setYear:2020];
        [dateParts setDay:8];
        
        NSDate *maxDate = [calendar dateFromComponents:dateParts];
        [dateParts release];
        
        dateParts = [[NSDateComponents alloc] init];
        [dateParts setMonth:1];
        [dateParts setYear:2013];
        [dateParts setDay:1];
        
        NSDate *minDate = [calendar dateFromComponents:dateParts];
        [dateParts release];
        
        datePickerView.minimumDate = minDate;  
        datePickerView.maximumDate = maxDate;  
        datePickerView.date = _date;  
        
        [datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];  
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [datePickerView release];
    [super dealloc];
}
@end
