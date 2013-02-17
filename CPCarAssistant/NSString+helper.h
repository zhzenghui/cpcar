//
//  NSString+helper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Extension)
@property (copy) NSString *dealerName;

+ (NSString *)escopeString:(NSString *)inputStirng;

@end
