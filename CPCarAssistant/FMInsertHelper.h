//
//  FBInsertHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBHelper.h"

@interface FMInsertHelper : NSObject

+ (FMInsertHelper *)insertHelper:(DBName)DBName;

- (void)insert:(NSDictionary *)itemDict :(DBTableName)tableName;
- (void)insertData:(NSArray *)itemArray :(DBTableName)tableName;

@end
