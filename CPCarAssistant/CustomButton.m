//
//  CustomButton.m
//  CPCarAssistant
//
//  Created by zeng on 13-2-6.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
@synthesize badgeText;



// Use this method if you want to change the badge text after the first rendering 
- (void) autoBadgeSizeWithString:(NSString *)badgeString
{
    badgeScaleFactor = 1.0;

	CGSize retValue;
	CGFloat rectWidth, rectHeight;
	CGSize stringSize = [badgeString sizeWithFont:[UIFont boldSystemFontOfSize:12]];
	CGFloat flexSpace;
	if ([badgeString length]>=2) {
		flexSpace = [badgeString length];
		rectWidth = 25 + (stringSize.width + flexSpace); rectHeight = 25;
		retValue = CGSizeMake(rectWidth*badgeScaleFactor, rectHeight*badgeScaleFactor);
	} else {
		retValue = CGSizeMake(25*badgeScaleFactor, 25*badgeScaleFactor);
	}
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, retValue.width, retValue.height);
	self.badgeText = badgeString;
	[self setNeedsDisplay];
}

// Draws the Badge with Quartz
-(void) drawRoundedRectWithContext:(CGContextRef)context withRect:(CGRect)rect
{
	CGContextSaveGState(context);
	
	CGFloat radius = CGRectGetMaxY(rect)*3;
	CGFloat puffer = CGRectGetMaxY(rect)*0.10;
	CGFloat maxX = CGRectGetMaxX(rect) - puffer;
	CGFloat maxY = CGRectGetMaxY(rect) - puffer;
	CGFloat minX = CGRectGetMinX(rect) + puffer;
	CGFloat minY = CGRectGetMinY(rect) + puffer;
    
    CGContextBeginPath(context);
	CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
	CGContextAddArc(context, maxX-radius, minY+radius, radius, M_PI+(M_PI/2), 0, 0);
	CGContextAddArc(context, maxX-radius, maxY-radius, radius, 0, M_PI/2, 0);
	CGContextAddArc(context, minX+radius, maxY-radius, radius, M_PI/2, M_PI, 0);
	CGContextAddArc(context, minX+radius, minY+radius, radius, M_PI, M_PI+M_PI/2, 0);
	CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 3, [[UIColor blackColor] CGColor]);
    CGContextFillPath(context);
    
	CGContextRestoreGState(context);
    
}

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawRoundedRectWithContext:context withRect:rect];

    badgeScaleFactor = 1.0;
	self.badgeText = @"1212";
	if ([self.badgeText length]>0) {
        
        CGFloat sizeOfFont = 13.5*badgeScaleFactor;
		if ([self.badgeText length]<2) {
			sizeOfFont += sizeOfFont*0.20;
		}
        UIFont *textFont = [UIFont boldSystemFontOfSize:sizeOfFont];
		CGSize textSize = [self.badgeText sizeWithFont:textFont];
			[self.badgeText drawAtPoint:CGPointMake((rect.size.width/2-textSize.width/2), (rect.size.height/2-textSize.height/2)) withFont:textFont];
	}
	
}

@end
