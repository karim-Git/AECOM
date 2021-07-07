//
//  DBCLASS.m
//  Gladstone
//
//  Created by Kareem on 2015-03-09.
//  Copyright (c) 2015 Chandra Sekhar. All rights reserved.
//

# define DBNAME @"AECOM.db"
#define TABLE_CONTENTDATA @"ContentDataTable"

#import "DBCLASS.h"

@implementation DBCLASS

static sqlite3 *aecomDB = nil;

+(NSString *)createDBIfNeeded
{
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *databasePath=[documentsDirectory stringByAppendingPathComponent:DBNAME];
    BOOL success = [fileManager fileExistsAtPath:databasePath];
    if(!success) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &aecomDB) == SQLITE_OK) {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS ContentDataTable (ID INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, jsonString TEXT)";
            
            if (sqlite3_exec(aecomDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                //  status.text = @"Failed to create table";
            }
            sqlite3_close(aecomDB);
        }
        else {
            //  status.text = @"Failed to open/create database";
        }
    }
    // NSLog(@"DB PATH %@",databasePath);
    return databasePath;
}

#pragma mark Insert ContentData
/*!
 This method will insert server response json string into DB File  with type
 of Message or DashBoard or Learn or BioBetrics or Seurveys.
 */
+(void)insertContentData:(ContentData *)data
{
    NSString *projectPath=[DBCLASS createDBIfNeeded];
    NSLog(@"path : %@",projectPath);
    sqlite3_stmt *insertStmt = nil;
    sqlite3 *cuisineDB = nil;
    
    if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
        NSLog(@"Can now use sqlite on multiple threads, using the same connection");
    }
    int ret = sqlite3_enable_shared_cache(1);
    if(ret != SQLITE_OK)
    {
        //	NSLog(@"Not Shared");
    }
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([projectPath UTF8String], &cuisineDB) == SQLITE_OK)
    {
        if(insertStmt == nil) {
            
            NSString *strValue = [NSString stringWithFormat:@"insert into %@(type,jsonString) Values(?,?)",TABLE_CONTENTDATA];
            const char *sql = [strValue UTF8String];
            
            if(sqlite3_prepare_v2(cuisineDB, sql, -1, &insertStmt, NULL) != SQLITE_OK) {
                NSLog(@"Error while creating %@", [NSString stringWithUTF8String:(char *)sqlite3_errmsg(cuisineDB)]);
                
            }
        }
        
        (sqlite3_bind_text(insertStmt, 1, [data.type UTF8String], -1, SQLITE_TRANSIENT));
        (sqlite3_bind_text(insertStmt, 2, [data.jsonString UTF8String], -1, SQLITE_TRANSIENT));
        
        if(SQLITE_DONE != sqlite3_step(insertStmt)) {
            
        }
        sqlite3_reset(insertStmt);
        
        if (insertStmt) {
            sqlite3_finalize(insertStmt);
            insertStmt = nil;
        }
    }
    sqlite3_close(cuisineDB);
}

+(NSMutableArray *)getContentDataWithType:(NSString *)type
{
    NSString *projectPath=[DBCLASS createDBIfNeeded];
    sqlite3_stmt *selectAllStmt = nil;
    sqlite3 *cuisineDB = nil;
    
    if (sqlite3_config(SQLITE_CONFIG_SERIALIZED) == SQLITE_OK) {
        NSLog(@"Can now use sqlite on multiple threads, using the same connection");
    }
    int ret = sqlite3_enable_shared_cache(1);
    if(ret != SQLITE_OK)
    {
        //NSLog(@"Not Shared");
    }
    NSMutableArray *arrData = [[NSMutableArray alloc] init];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([projectPath UTF8String], &cuisineDB) == SQLITE_OK)
    {
        NSString *strValue = [NSString stringWithFormat:@"SELECT * FROM %@ where type = '%@'",TABLE_CONTENTDATA,type];
        const char *sql = [strValue UTF8String];
        
        if(sqlite3_prepare_v2(cuisineDB, sql, -1, &selectAllStmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(selectAllStmt) == SQLITE_ROW)
            {
                ContentData *data  = [[ContentData alloc]init];
                data._id =  sqlite3_column_int(selectAllStmt, 0);
                data.type =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectAllStmt, 1)];
                data.jsonString =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectAllStmt, 2)];
                [arrData addObject:data];
            }
        }
        sqlite3_reset(selectAllStmt);
        
        if (selectAllStmt) {
            sqlite3_finalize(selectAllStmt);
            selectAllStmt = nil;
        }
    }
    sqlite3_close(cuisineDB);
    return arrData;
}

+(void)updateContentDataWithType:(NSString *)type jsonString:(NSString *)jsonString
{
    NSString * projectPath = [DBCLASS createDBIfNeeded];
    sqlite3_stmt *updateStmt = nil;
    if (sqlite3_open([projectPath UTF8String], &aecomDB) == SQLITE_OK)
    {
        if(updateStmt == nil) {
            NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET jsonString = '%@'  where type = '%@' ", TABLE_CONTENTDATA, jsonString,type];
            
            const char *sql_stmt = [sql UTF8String];
            
            if(sqlite3_prepare_v2(aecomDB, sql_stmt, -1, &updateStmt, NULL) != SQLITE_OK)
                NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(aecomDB));
        }
                if(SQLITE_DONE != sqlite3_step(updateStmt))
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(aecomDB));
    }
    sqlite3_reset(updateStmt);
    sqlite3_finalize(updateStmt);
    sqlite3_close(aecomDB);
}

@end
