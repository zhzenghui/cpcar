//
//  NSString+helper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NSString+helper.h"

@implementation NSString (NSString_Extension)


#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

+ (NSString *)escopeString:(NSString *)inputStirng
{
    NSMutableString *outString = [NSMutableString stringWithFormat:inputStirng];
//    
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
//    
//    for (int i=0; i<inputStirng.length; i ++) {
        //        char tag =  [inputStirng characterAtIndex:i];
        
        //        NSString *string = [NSString stringWithCString:tag length:strlen(tag)];
        //        
        //        NSString *filter = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        //        
        //        [outString appendString:filter];
//    }
    return outString;
    
}

@end
