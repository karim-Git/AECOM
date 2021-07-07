//
//  ReusedMethods.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BottomView.h"

@interface ReusedMethods : NSObject
{
    
}
+(ReusedMethods *)sharedObject;
@property (assign) BOOL isPics;
+(void)setNavigationViewOnView: (UIView *)selfView WithSingleTitle:(NSString *)title;

+(void)addBottomViewOn:(UIView *)selfView index:(int)index;

+(void)addTableViewBackGroundColor:(UITableView *)tableView;
+(void)setLeftLabelBGColor:(UILabel *)leftLabel AtIndex:(NSInteger *)index;
+(NSString *)getFormattedDateString:(NSString *)dateString currentFormat:(NSString *)currentFormat displayFormat:(NSString *)requiredFormat;
+(void)setNavigationViewOnView: (UIView *)selfView WithSingleTitle:(NSString *)title  WithDelegate:(id)delegate;
+(NSString *)getVideosPath:(NSString *)videoID;
+(BOOL)fileExistAtPathWithId:(NSString *)videoID;
#pragma mark DBCLASSES
+(void)insertJSONResponseInDataBase:(NSString *)jsonString type:(NSString *)type;
+(NSString *)getJSONResponseStringFromDataBaseWithType:(NSString*)type;

+(id)getResponseUserDefaults:(NSString *)key;
+(void)saveResponseInUserDefaults:(id)response WithKey:(NSString *)key;
+(void)showErrorAlert:(NSError *)error;
+(BOOL)checkNetwrokConnection;
+(NSString *)getFileSizeOfVideoID:(NSString *)videoID;
+(BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;
+(NSString *)authorizationKey;
+(void)showNoNetworkAlert;
+(void)removeFileWithId:(NSString *)videoId;
@end
