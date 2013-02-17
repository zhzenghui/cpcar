//
//  UINavigationBarCategory.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBarCategory.h"

@implementation UINavigationBar(Category)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        UIImage *image = [UIImage imageNamed: @"head"];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"head"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}



@end
