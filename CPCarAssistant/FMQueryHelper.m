//
//  FMQueryHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FMQueryHelper.h"
#import "FMDatabase.h"

static FMDatabase *db;

@implementation FMQueryHelper

- (IBAction)queryData:(id)sender {
    debugMethod();
    if ([db open]) {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int userId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * pass = [rs stringForColumn:@"password"];
            debugLog(@"user id = %d, name = %@, pass = %@", userId, name, pass);
        }
        [db close];
    }
}

- (NSString *)sqlTableLastID:(DBTableName)tableName
{
    NSString * table = nil;
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            table = [NSString stringWithFormat:@"consumerecord"];;
            break;
        }
        case DBTableNameMessage:
        {
            table = [NSString stringWithFormat:@"Message"];            
            break;
        }
        case DBTableNameMyCar:
        {
            table = [NSString stringWithFormat:@"MyCar"];            
            break;
        }
        case DBTableNameAuto:
        {
            table = [NSString stringWithFormat:@"Auto"];            
            break;            
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select max(id) as id from %@", table];
    return sql;
}

- (NSString *)sqlTableDataCount:(DBTableName)tableName
{
    NSString * table = nil;
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            table = [NSString stringWithFormat:@"consumerecord"];;
            break;
        }
        case DBTableNameMessage:
        {
            table = [NSString stringWithFormat:@"Message"];            
            break;
        }
        case DBTableNameMyCar:
        {
            table = [NSString stringWithFormat:@"MyCar"];            
            break;
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select count(id) as count from %@", table];
    return sql;
}

- (NSString *)sqlTableData:(DBTableName)tableName page:(int)pageNum pagSize:(int)pageSize
{
    
    NSString *tableNameString = [NSString string];
    NSString *tableIDString = [NSString string];        
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
        case DBTableNameActivity:
        {
            
            tableNameString = [NSString stringWithFormat:@"Activity"];
            tableIDString = [NSString stringWithFormat:@"ID"]; 
            break;
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"Select * From %@ Order By %@ desc Limit %d Offset %d;", tableNameString, tableIDString, pageSize, pageNum*pageSize];
    return sql;
}

- (NSString *)sqlCityTableData:(DBTableName)tableName fatherID:(NSString *)fatherID
{
    
    NSString *sql = [NSString stringWithFormat:@"Select * From city where father=%@;", fatherID];
    return sql;
}


- (int)queryLastID:(DBTableName)tableName where:(NSString *)where 
{    
    int uid ;
    if ([db open]) {
        NSString * sql = [self sqlTableLastID:tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            uid = [rs intForColumn:@"id"];
        }        
        [db close];
        
        return uid;        
    }
    return 1;
}


- (int)queryLastID:(DBTableName)tableName
{    
    int uid ;
    if ([db open]) {
        NSString * sql = [self sqlTableLastID:tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            uid = [rs intForColumn:@"id"];
        }        
        [db close];
        
        return uid;        
    }
    return 1;
}

- (int)queryDataCount:(DBTableName)tableName
{    
    int count ;
    if ([db open]) {
        NSString * sql = [self sqlTableDataCount:tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            count = [rs intForColumn:@"count"];
        }        
        [db close];
        
        return count;        
    }
    return 1;
}



- (NSMutableDictionary *)fmResultSetConvertToDict:(FMResultSet *)rs tableName:(DBTableName)tableName
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    switch (tableName) {
        case DBTableNameMessage:
        {            
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:KMessageId];
            [dict setValue:[rs stringForColumn:KMessageMessage] forKey:KMessageMessage];
            [dict setValue:[rs stringForColumn:KMessageAnswer] forKey:KMessageAnswer];
            [dict setValue:[NSNumber numberWithBool:[rs boolForColumn:KMessageIsAnswer]] forKey:KMessageIsAnswer];
            [dict setValue:[rs stringForColumn:KMessageUDID] forKey:KMessageUDID];
            [dict setValue:[rs dateForColumn:KMessageUpTime] forKey:KMessageUpTime];
            break;
        }
        case DBTableNameAuto:
        {
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KAuto_AutoID]] forKey:KAuto_AutoID];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KAuto_SeriesID]] forKey:KAuto_SeriesID];
            
            [dict setValue:[rs stringForColumn:KAuto_Name] forKey:KAuto_Name];
            [dict setValue:[rs stringForColumn:KAuto_AutoImg] forKey:KAuto_AutoImg];

            [dict setValue:[NSNumber numberWithDouble:[rs doubleForColumn:KAuto_MSRP]] forKey:KAuto_MSRP];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KAuto_IsTestDrive]] forKey:KAuto_IsTestDrive];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KAuto_OrderNum]] forKey:KAuto_OrderNum];

            break;
        }
        case DBTableNameActivity:
        {
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KActivity_ID]] forKey:KActivity_ID];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KActivity_DealerID]] forKey:KActivity_DealerID];
            [dict setValue:[rs stringForColumn:KActivity_Title] forKey:KActivity_Title];
            [dict setValue:[rs stringForColumn:KActivity_ImgURL] forKey:KActivity_ImgURL];
            [dict setValue:[rs dataForColumn:KActivity_SupTime] forKey:KActivity_SupTime];

            break;
        }
        case DBTableNameCity:
        {
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KCityID]] forKey:KCityID];
            [dict setValue:[rs stringForColumn:KCityCode] forKey:KCityCode];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:KCityCode]] forKey:KCityFather];
            [dict setValue:[rs stringForColumn:KCityProvinceName] forKey:KCityProvinceName];
            [dict setValue:[rs stringForColumn:KCityCityName] forKey:KCityCityName];

            break;
        }
        default:
            break;
    }
    
    return dict;
}

- (NSArray *)queryRsToArray:(FMResultSet *)rs tableName:(DBTableName)tableName
{
    NSMutableArray *mArray = [NSMutableArray array];
    
    while ([rs next]) {
         
        [mArray addObject:[self fmResultSetConvertToDict:rs tableName:tableName]];
    }
    return mArray;
}



- (NSArray *)queryCityTableData:(DBTableName)tableName   fatherID:(NSString *)fatherID
{    
    NSArray *itemsArray;
    
    if ([db open]) {
        NSString * sql = [self sqlCityTableData:DBTableNameCity fatherID:fatherID];
        FMResultSet * rs = [db executeQuery:sql];
        itemsArray = [self queryRsToArray:rs tableName:tableName];
        [db close];
        return itemsArray;
    }    
    
    return nil;
}

- (NSArray *)queryTableData:(DBTableName)tableName  page:(int)pageNum pagSize:(int)pageSize
{    
    NSArray *itemsArray;

    if ([db open]) {
        NSString * sql = [self sqlTableData:tableName page:pageNum pagSize:pageSize];
        FMResultSet * rs = [db executeQuery:sql];
        itemsArray = [self queryRsToArray:rs tableName:tableName];
        [db close];
        return itemsArray;
    }    
    
    return nil;
}

+ (FMQueryHelper *)queryHelper:(DBName)DBName
{
    FMQueryHelper *queryHelper = [[[FMQueryHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:DBName];
    return queryHelper;
}

@end
