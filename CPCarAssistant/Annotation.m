//
//  Annotation.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-10.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize contentView;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.canShowCallout = NO;
        self.centerOffset = CGPointMake(0, -55);
        self.frame = CGRectMake(0, 0, 240, 80);
        
        UIView *_contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)] autorelease];
        _contentView.backgroundColor   = [UIColor clearColor];
        [self addSubview:_contentView];
        self.contentView = _contentView;
    }
    return self;

}

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor clearColor];
//        self.canShowCallout = NO;
//        self.centerOffset = CGPointMake(0, -55);
//        self.frame = CGRectMake(0, 0, 240, 80);
        
        UIView *_contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)] autorelease];
        _contentView.backgroundColor   = [UIColor clearColor];
        [self addSubview:_contentView];
        self.contentView = _contentView;
    }
    return self;
}

- (void)dealloc
{    
    [super dealloc];
}

@end
