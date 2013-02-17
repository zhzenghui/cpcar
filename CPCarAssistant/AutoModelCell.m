//
//  AutoModelCell.m
//  CPCarAssistant
//
//  Created by zeng on 12-12-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AutoModelCell.h"

@implementation AutoModelCell
@synthesize titleLabel;
@synthesize titleImageView;


- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"auto_model_top_background"]];    
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [titleLabel release];
    [titleImageView release];
    [super dealloc];
}
@end
