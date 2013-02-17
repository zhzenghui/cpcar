//
//  NetWork.m
//  CPCarAssistant
//
//  Created by zeng on 13-2-17.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NetWork.h"
#import "Reachability.h"

@implementation NetWork

+ (BOOL)checkNetwork
{
    NetworkStatus status =[[Reachability reachabilityWithHostName:@"www.baidu.com"] currentReachabilityStatus];
    NSLog(@"check network  : %d", status);
    
    
    
    if(status != NotReachable  )  //  self.bServerOk == YES  #946
    {
        return YES;
    }
    else {
        return NO;
    }
}

@end
