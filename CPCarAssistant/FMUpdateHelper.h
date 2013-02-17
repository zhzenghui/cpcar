//
//  FMUpdateHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDBHelper.h"


@interface FMUpdateHelper : NSObject
+ (FMUpdateHelper *)updateHelper:(DBName)DBName;
- (void)update:(NSDictionary *)itemDict :(DBTableName)tableName;
- (void)updateData:(NSArray *)itemArray :(DBTableName)tableName;
@end
