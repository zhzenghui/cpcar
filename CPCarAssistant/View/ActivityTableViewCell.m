//
//  ActivityTableViewCell.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell
@synthesize titleLabel;
@synthesize titleImageView;
@synthesize descLabel;
@synthesize MoreButton;

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActivityBackground_Cell"]];    
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
    [descLabel release];
    [MoreButton release];
    [super dealloc];
}
@end
