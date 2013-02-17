//
//  DictDataToDBData.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "DictDataToDBData.h"
#import "FMHelper.h"

#define KData_AddItems @"AddItems"
#define KData_DelItems @"DelItems"
#define KData_UpdateItems @"UpdateItems"


#define KData_Table_Auto @"Auto"
#define KData_Table_AutoSeries @"AutoSeries"
#define KData_Table_Images @"Images"
#define KData_Table_Activity @"Activity"

#define KFile_DelFile_Auto @"DelFile"
#define KFile_AddFile_Auto @"AddFile"


@implementation DictDataToDBData

NSDictionary *dataDict;
NSDictionary *FileDict;


+ (DictDataToDBData *)dataToDbHelper
{
    DictDataToDBData *fbInsertHelper = [[[DictDataToDBData alloc] init] autorelease] ;
 
    return fbInsertHelper;
}

- (void)addItemsDBData:(NSArray *)array tableName:(DBTableName)tableName
{
    [[FMInsertHelper insertHelper:DBNameDocument] insertData :array :tableName];    
}

- (void)delItemsDBData:(NSArray *)array tableName:(DBTableName)tableName
{
}

- (void)updateItemsDBData:(NSArray *)array tableName:(DBTableName)tableName
{
    [[FMUpdateHelper updateHelper:DBNameDocument] updateData:array :tableName];
}


/*
 
 创建目录
 
*/
- (void)createImageDocument :(NSString *)imagePath
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:imagePath isDirectory:&isDir];
    NSString *document = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imagePath];

    if(!(isDirExist && isDir))
    {
        NSError *error;
        BOOL bCreateDir = [fileManager createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error];  
        if(!bCreateDir){
            NSLog(@"Create Audio Directory Failed. %@", error);
        }
        NSLog(@"%@",imagePath);
    }
    
}

- (NSString *)imagesFilePath :(NSString *)fileUrl
{
    
/*
 
 fileUrl 替换  s ， range  根据最后一个／的位置 分割 字符串
 
 */
    NSString *s = fileUrl;//@"/Data/ChangChengC50/1.5T_ShiShangXing/1.5T_ShiShangXing.jpg";
    
    NSRange range = [s rangeOfString:@"/" options:NSBackwardsSearch range:NSMakeRange(0, s.length)];

    
/*
    创建的目录结构
    例如：/Data/ChangChengC50/1.5T_ShiShangXing     
*/
    NSString *documentPath = [s substringWithRange:NSMakeRange(0, range.location)];
    [self createImageDocument:documentPath];
    
//     创建的文件
    NSString *fileName = [s substringWithRange:NSMakeRange(range.location+1, s.length-range.location-1)];;
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:[NSString stringWithFormat: @"%@/%@", documentPath, fileName]];
    
    return path;
}

/*
 
 保存文件
 
 */
- (void)saveFile:(NSData *)data fileUrl:(NSString *)fileUrl
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
   if (data) 
    {        
        [fileManager createFileAtPath:[self imagesFilePath:fileUrl] contents:data attributes:nil];
    }
}

- (void)addFile:(NSString *)fileName
{
    NSDate *currentDate = [NSDate date];
    dispatch_queue_t myQueue = NULL;
    if (myQueue == NULL) {
        myQueue = dispatch_queue_create([[currentDate description] UTF8String], NULL);
    }

    dispatch_async(myQueue, ^(void) {
        NSLog(@"fileName:%@", fileName);
        NSString *urlString = [NSString stringWithFormat:KServerUrl,fileName];
        NSString* urlTextEscaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlTextEscaped];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];
        
        
        [request setHTTPMethod:@"GET"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        if (data) {
//            保存文件
            [self saveFile:data fileUrl:fileName];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    dispatch_release(myQueue);
}

- (void)delFile:(NSArray *)delArray
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
     
    NSError *errorMessage;
    for (NSString *autoRecord in delArray) {

        bool isSuccess = [fileManager removeItemAtPath:[self imagesFilePath:autoRecord] error:&errorMessage];
        if (isSuccess) {
            debugLog(@"success fileName %@" , autoRecord);
        }
        else {
            debugLog(@"faild ! error: %@", errorMessage);        
        }
    }
}

- (void)filesHandle:(NSDictionary *)FileDict
{
////下载添加文件 ＊添加下载是否成功标记，  以便失败后再次下载＊/////////////////////////////////////////////
    NSDictionary *addAutoDict = [FileDict objectForKey:KFile_AddFile_Auto];
    if (  ! [addAutoDict isEqual: [NSNull null]]) {     
//        NSLog(@"addDict:%@", [addAutoDict allValues]);
        for (NSString *autoRecord in [addAutoDict allValues]) {
            [self  addFile:autoRecord];
        }
    }
    else {
        debugLog(@"no add file");
    }
    
////删除本地文件 /////////////////////////////////////////////////////////////////////////////////    
    NSDictionary *delDict = [FileDict objectForKey:KFile_DelFile_Auto];
    if ( !  [delDict isEqual: [NSNull null]]) {
//        NSLog(@"delDict:%@", [delDict allValues]);
        [self  delFile:[delDict allValues]];
    }
    else {
        debugLog(@"no del file");
    }
}

- (void)dataHandle:(NSDictionary *)dataDict
{
    
///////////////////////////////////////////////////////////////////////////
//     添加信息
///////////////////////////////////////////////////////////////////////////
    
    NSDictionary *AddItemsDict = [dataDict objectForKey:KData_AddItems];
//    NSDictionary *auto_AddItemsDict = [AddItemsDict objectForKey:KData_Table_Auto];
//    NSDictionary *autoSeries_AddItemsDict = [AddItemsDict objectForKey:KData_Table_AutoSeries];
//    NSDictionary *images_AddItemsDict = [AddItemsDict objectForKey:KData_Table_Images];    
 
/*
data/
    AddItems/
        Activity{1,3...}
        Auto{1,3...}
    DelItems/
*/
    DBTableName dbTableName ;
    for (NSString *tableName in [AddItemsDict allKeys]) {
        if ([tableName isEqualToString:KData_Table_Auto]) {
            dbTableName = DBTableNameAuto;
        }
        else if([tableName isEqualToString:KData_Table_AutoSeries]) {
            dbTableName = DBTableNameAutoSeries;
        }
        else if([tableName isEqualToString:KData_Table_Images]) {
            dbTableName = DBTableNameImages;
        }
        else if([tableName isEqualToString:KData_Table_Activity]) {
            dbTableName = DBTableNameActivity;
        }
        [self addItemsDBData:[[AddItemsDict objectForKey:tableName] allValues] tableName:dbTableName];        
    }
    
////  auto 表
//    if (    !   [auto_AddItemsDict isEqual:[NSNull null]]) {
//        [self addItemsDBData:[auto_AddItemsDict allValues] tableName:DBTableNameAuto];        
//    }
////    autoSeries 表
//    if (    ! [autoSeries_AddItemsDict isEqual:[NSNull null]]) {
//        [self addItemsDBData:[autoSeries_AddItemsDict allValues]  tableName:DBTableNameAutoSeries];
//    }
//    
////    image 表
//    if (   ! [images_AddItemsDict isEqual:[NSNull null]]) {
//        [self addItemsDBData:[images_AddItemsDict allValues]  tableName:DBTableNameImages];
//    }
///////////////////////////////////////////////////////////////////////////
//     更新信息
///////////////////////////////////////////////////////////////////////////
    NSDictionary *updateItemsDict = [dataDict objectForKey:KData_UpdateItems];
    NSDictionary *auto_UpdateItemsDict = [updateItemsDict objectForKey:KData_Table_Auto];
    NSDictionary *autoSeries_UpdateItemsDict = [updateItemsDict objectForKey:KData_Table_AutoSeries];
    NSDictionary *images_UpdateItemsDict = [updateItemsDict objectForKey:KData_Table_Images];    
    
    //  auto 表
    if ( ! [auto_UpdateItemsDict isEqual: [NSNull null]]) {
        [self updateItemsDBData:[auto_UpdateItemsDict allValues] tableName:DBTableNameAuto];        
    }
    else {
        debugLog(@"auto not update");
    }
    //    autoSeries 表
    if ( ! [autoSeries_UpdateItemsDict isEqual: [NSNull null]]) {
        [self updateItemsDBData:[autoSeries_UpdateItemsDict allValues]  tableName:DBTableNameAutoSeries];
    }
    else {
        debugLog(@"autoSeries not update");
    }    
    //    image 表
    if ( ! [images_UpdateItemsDict isEqual: [NSNull null]]) {
        [self updateItemsDBData:[images_UpdateItemsDict allValues]  tableName:DBTableNameImages];
    }
    else {
        debugLog(@"images not update");
    }

}

- (void)data:(NSDictionary *)dict
{

//  {
//    Data =     {
//        AddItems =         {
//            Auto = "<null>";
//            AutoSeries = "<null>";
//            Images = "<null>";
//        };
//        DelItems =         {
//            Auto = "<null>";
//            AutoSeries = "<null>";
//            Images = "<null>";
//        };
//        UpdateItems =         {
//            Auto = "<null>";
//            AutoSeries = "<null>";
//            Images = "<null>";
//        };
//    };
//    File =     {
//        AddFile = "<null>";
//        DelFile = "<null>";
//    };
//}
    debugLog(@"update local db");
    [self dataHandle:  [dict objectForKey:KData]];
    
    
    
    debugLog(@"update local file system");
    [self filesHandle: [dict objectForKey:KFile]];
}

@end
