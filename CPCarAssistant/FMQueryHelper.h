//
//  FMQueryHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDBHelper.h"


@interface FMQueryHelper : NSObject


+ (FMQueryHelper *)queryHelper:(DBName)DBName;
- (int)queryDataCount:(DBTableName)tableName;
- (int)queryLastID:(DBTableName)tableName;
- (NSArray *)queryTableData:(DBTableName)tableName  page:(int)pageNum pagSize:(int)pageSize;
- (NSArray *)queryCityTableData:(DBTableName)tableName   fatherID:(NSString *)fatherID;
@end
