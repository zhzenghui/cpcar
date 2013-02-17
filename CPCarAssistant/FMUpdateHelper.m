//
//  FMUpdateHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FMUpdateHelper.h"

@implementation FMUpdateHelper

static FMDatabase *db;

//  填充对应的数据字段
- (NSString *)sqlFiledAppand:(NSDictionary *)itemDict
{
    NSMutableString *sql = [NSMutableString string];
    
    for (int i =0; i< [itemDict allKeys].count ;i++) {
        
        [sql appendFormat:@"%@='%@'", [[itemDict allKeys] objectAtIndex:i], [[itemDict allValues] objectAtIndex:i]];
        if ( i!= [itemDict allKeys].count-1 ) {
            [sql appendString:@", "];
        }
    }
    return sql;
}

- (NSString *)sql :(NSDictionary *)itemDict :(DBTableName)tableName;
{
    
    NSMutableString *sql = [NSMutableString string];
    
    NSString *tableNameString = [NSString string];
    NSString *tableIDString = [NSString string];    
//            tips：  tableIDString  必须要 和返回数据的大小写一致
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {

            tableNameString = [NSString stringWithFormat:@"ConsumeRecord"];
            tableIDString = [NSString stringWithFormat:@"id"]; 
            break;
        }
        case DBTableNameMyCar:
        {
            tableNameString = [NSString stringWithFormat:@"MyCar"];
            tableIDString = [NSString stringWithFormat:@"MyCar"]; 
            break;
        }
        case DBTableNameMessage:
        {
            tableNameString = [NSString stringWithFormat:@"Message"];
            tableIDString = [NSString stringWithFormat:@"id"]; 
            break;
        }
        case DBTableNameAuto:
        {
            tableNameString = [NSString stringWithFormat:@"Auto"];
            tableIDString = [NSString stringWithFormat:@"AutoID"]; 
            break;
        }
        case DBTableNameAutoSeries:
        {
            tableNameString = [NSString stringWithFormat:@"AutoSeries"];
            tableIDString = [NSString stringWithFormat:@"SeriesID"]; 
            break;
        }
        case DBTableNameImages:
        {
            
            tableNameString = [NSString stringWithFormat:@"Images"];
            tableIDString = [NSString stringWithFormat:@"ImageID"]; 
            break;
        }
        default:
            break;
    }
    
    //            更改表名
    [sql appendFormat:@"UPDATE %@ SET", tableNameString];
    [sql appendFormat:@" "];
    [sql appendString:[self sqlFiledAppand:itemDict]];
    
    [sql appendFormat:@" "];
    //             改为对应的id 字段            
    [sql appendFormat:@"WHERE %@ = %@", tableIDString,[itemDict objectForKey:tableIDString]];
    return sql;
}

- (void)update:(NSDictionary *)itemDict :(DBTableName)tableName
{
    NSString * sql = [self sql:itemDict :tableName];
    
    BOOL res = [db executeUpdate:sql];
    if (!res) {
        debugLog(@"error to insert data: %@",sql);
    } else {
        debugLog(@"succ to insert data");
    }
}
- (void)updateData:(NSArray *)itemArray :(DBTableName)tableName
{
    if ([db open]) {
        
        for (NSDictionary *itemDict in itemArray) {
            
            [self update:itemDict:tableName];
        }
        [db close];
    }
    else {
        debugLog(@"error to db not open");
    }
}

+ (FMUpdateHelper *)updateHelper:(DBName)DBName;
{
    FMUpdateHelper *updateHelper = [[[FMUpdateHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:DBName];
    return updateHelper;
}
@end
