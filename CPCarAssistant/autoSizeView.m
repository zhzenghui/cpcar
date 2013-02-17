//
//  autoSizeView.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "autoSizeView.h"

@implementation autoSizeView

- (void)awakeFromNib
{
    CGRect viewRect = [[UIScreen mainScreen] bounds];
    
    self.frame = CGRectMake(0, 0, viewRect.size.width, viewRect.size.height-44);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

@end
