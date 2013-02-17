//
//  ActivityTableViewCell.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *titleImageView;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;
@property (retain, nonatomic) IBOutlet UIButton *MoreButton;

@end
