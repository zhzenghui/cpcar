//
//  FBInsertHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//




#import "FMInsertHelper.h"
#import "FMDatabase.h"

@implementation FMInsertHelper



static FMDatabase *db;

+ (FMInsertHelper *)insertHelper:(DBName)DBName
{
    FMInsertHelper *fbInsertHelper = [[[FMInsertHelper alloc] init] autorelease] ;
    db = [FMDBHelper databaseWithName:DBName];
    return fbInsertHelper;
}

- (NSString *)sql :(NSDictionary *)itemDict :(DBTableName)tableName;
{

    NSMutableString *sql = [NSMutableString string];
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            [sql appendFormat: @"insert  or replace into ConsumeRecord (type, price, uptime) values('%@', '%@', '%@') ", 
             [itemDict objectForKey:KConsumeRecordType],
             [itemDict objectForKey:KConsumeRecordPrice],
             [itemDict objectForKey:KConsumeRecordUptime]
             ];
            break;
        }
        case DBTableNameMyCar:
        {
            [sql appendFormat: @"insert  or replace into ConsumeRecord (type, price, uptime) values('%@', '%@', '%@') ", 
             [itemDict objectForKey:KConsumeRecordType],
             [itemDict objectForKey:KConsumeRecordPrice],
             [itemDict objectForKey:KConsumeRecordUptime]
             ];
            break;
        }
        case DBTableNameMessage:
        {
            [sql appendFormat: @"insert  or replace into message (ID, Dealer, UDID, Message, Answer, IsAnswer, UpTime) values('%@', '%@', '%@', '%@', '%@', '%@', '%@') ", 
             [itemDict objectForKey:KMessageId],
             [itemDict objectForKey:KMessageDealer],
             [itemDict objectForKey:KMessageUDID],
             [itemDict objectForKey:KMessageMessage],
             [itemDict objectForKey:KMessageAnswer],
             [itemDict objectForKey:KMessageIsAnswer],
             [itemDict objectForKey:KMessageUpTime]
             ];
            break;
        }
        case DBTableNameAuto:
        {
            [sql appendFormat: @"insert  or replace into Auto (AutoID,AutoImg, IsTestDrive, MSRP,Name,  OrderNum, SeriesID) values('%@','%@', '%@', '%@','%@', '%@', '%@') ", 
             [itemDict objectForKey:KAuto_AutoID],
             [itemDict objectForKey:KAuto_AutoImg],
             [itemDict objectForKey:KAuto_IsTestDrive],
             [itemDict objectForKey:KAuto_MSRP],
             [itemDict objectForKey:KAuto_Name],
             [itemDict objectForKey:KAuto_OrderNum],
             [itemDict objectForKey:KAuto_SeriesID]
             ];
            break;
        }
        case DBTableNameAutoSeries:
        {
            [sql appendFormat: @"insert  or replace into AutoSeries (SeriesID,Name, SeriesImg, Describe, OrderNum) values('%@','%@', '%@', '%@','%@') ", 
             [itemDict objectForKey:KAutoSeries_SeriesID],
             [itemDict objectForKey:KAutoSeries_Name],
             [itemDict objectForKey:KAutoSeries_SeriesImg],
             [itemDict objectForKey:KAutoSeries_Describe],
             [itemDict objectForKey:KAutoSeries_OrderNum]
             ];
            break;
        }
        case DBTableNameImages:
        {

            [sql appendFormat: @"insert or replace into Images (ImageID,AutoID, Thumbnail, ImgURL,Describe,Name,SeriesImg, OrderNum) values('%@','%@', '%@', '%@','%@', '%@','%@', '%@') ", 
             [itemDict objectForKey:KImages_ImageID],
             [itemDict objectForKey:KImages_AutoID],
             [itemDict objectForKey:KImages_Thumbnail],
             [itemDict objectForKey:KImages_ImgURL],
             [itemDict objectForKey:KImages_Describe],             
             [itemDict objectForKey:KImages_Name],
             [itemDict objectForKey:KImages_SeriesImg],
             [itemDict objectForKey:KImages_OrderNum]
             ];
            break;
        }
        case DBTableNameActivity:
        {
            NSString *s = [itemDict objectForKey:KActivity_SupTime];
            s = [s substringWithRange:NSMakeRange(6, 10)];
            NSTimeInterval published_at= [s doubleValue]; 
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"]; 
            NSString *iosDate=[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:published_at]];
            
            [sql appendFormat: @"insert or replace into activity (ID,DealerID, Title, ImgURL,SupTime) values('%@','%@', '%@', '%@','%@') ", 
             [itemDict objectForKey:KActivity_ID],
             [itemDict objectForKey:KActivity_DealerID],
             [itemDict objectForKey:KActivity_Title],
             [itemDict objectForKey:KActivity_ImgURL],
             iosDate
             ];
            break;
        }
        default:
            break;
    }
    
    return sql;
}

- (void)insert:(NSDictionary *)itemDict :(DBTableName)tableName;
{
    NSString * sql = [self sql:itemDict :tableName];
    
    BOOL res = [db executeUpdate:sql];
    if (!res) {
        debugLog(@"error to insert data: %@",sql);
    } else {
        debugLog(@"succ to insert data");
    }
}

- (void)insertData:(NSArray *)itemArray :(DBTableName)tableName;
{
    if ([db open]) {

        for (NSDictionary *itemDict in itemArray) {
            
            [self insert:itemDict:tableName];
        }
        [db close];
    }
    else {
        debugLog(@"error to db not open");
    }
}

@end
