//
//  BlockNetWork.m
//  CPCarAssistant
//
//  Created by zeng on 13-2-17.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "BlockNetWork.h"

@implementation BlockNetWork

- (void)hasArgsBlock:(void (^)(NSString *name, BOOL animated))block {
    
}


- (void)setCompletionBlockWithSuccess:(void (^)(id *operation, id responseObject))success
                              failure:(void (^)(id *operation, NSError *error))failure
{
    [self hasArgsBlock:^(NSString *name, BOOL animated) {
        NSLog(@"Name: %@, animated %d", name, animated);
    }];
    
    [UIView animateWithDuration:1.0
                     animations:^{
                     }
                     completion:^(BOOL finished) {
                     }];
}

+ (void)animateWithDuration:(NSTimeInterval)duration 
                 animations:(void (^)(void))animations 
                 completion:(void (^)(BOOL finished))completion 
{
    
}


@end
