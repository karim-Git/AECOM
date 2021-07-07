//
//  DBCLASS.h
//  Gladstone
//
//  Created by Kareem on 2015-03-09.
//  Copyright (c) 2015 Chandra Sekhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ContentData.h"
@interface DBCLASS : NSObject

+(NSString *)createDBIfNeeded;
+(void)insertContentData:(ContentData *)data;
+(NSMutableArray *)getContentDataWithType:(NSString *)type;
+(void)updateContentDataWithType:(NSString *)type jsonString:(NSString *)jsonString;
@end
