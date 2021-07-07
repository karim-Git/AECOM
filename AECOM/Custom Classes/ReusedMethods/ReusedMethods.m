//
//  ReusedMethods.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "ReusedMethods.h"
static  ReusedMethods  * sharedobject;
@implementation ReusedMethods
@synthesize isPics;
+ (ReusedMethods *)sharedObject{
    if (!sharedobject) {
        sharedobject  =  [[ReusedMethods alloc]init];
    }
    
    return  sharedobject;
}
+(void)addBottomViewOn:(UIView *)selfView index:(int)index
{
    BottomView *bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(selfView.frame)- BOTTOM_VIEW_HEIGHT, CGRectGetWidth(selfView.frame), BOTTOM_VIEW_HEIGHT)];
    [bottomView highlightIndex:index];
    [selfView addSubview:bottomView];
}



#pragma mark=== Navigation Bar ===
//Single titels
+(void)setNavigationViewOnView: (UIView *)selfView WithSingleTitle:(NSString *)title
{
    float x = 15;
    float width = CGRectGetWidth(selfView.frame);
    float navHt = NAVIGATION_HEIGHT;
    
    //Navigation view
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, navHt-10)];
    [navView setBackgroundColor:[UIColor appThemeColor]];
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [selfView addSubview:navView];
    
    //Status bar  Label
    UILabel *statusBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    [statusBarLabel setBackgroundColor:[UIColor appGrayColor]];
    statusBarLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   // [navView addSubview:statusBarLabel];
    
    //Title Label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width-2*x, navHt-10)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor appWhiteColor]];
    [titleLabel setFont: [UIFont appHeaderFont]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [navView addSubview:titleLabel];
    
    // back button
}
//Single titels
+(void)setNavigationViewOnView: (UIView *)selfView WithSingleTitle:(NSString *)title  WithDelegate:(id)delegate
{
    float x = 50;
    float width = CGRectGetWidth(selfView.frame);
    float navHt = NAVIGATION_HEIGHT;
    
    //Navigation view
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, navHt-10)];
    [navView setBackgroundColor:[UIColor appThemeColor]];
    navView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [selfView addSubview:navView];
    
    //Status bar  Label
    UILabel *statusBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    [statusBarLabel setBackgroundColor:[UIColor appGrayColor]];
    statusBarLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   // [navView addSubview:statusBarLabel];
    
    //Title Label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, width-2*x, navHt-10)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor appWhiteColor]];
    [titleLabel setFont: [UIFont appHeaderFont]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [navView addSubview:titleLabel];
    
    // back button
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, navHt-10)];
    [backButton setImage:[UIImage navBackIcon] forState:UIControlStateNormal];
    [backButton addTarget:delegate action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backButton];
}

-(void)backButtonAction
{

}
+(void)addTableViewBackGroundColor:(UITableView *)tableView
{
    tableView.backgroundColor = [UIColor appWhiteColor];
}

+(void)setLeftLabelBGColor:(UILabel *)leftLabel AtIndex:(NSInteger *)index
{
    NSArray * arrayColors = [NSArray arrayWithObjects:[UIColor appThemeColor],[UIColor appThemeColor2],[UIColor appGreenColor],[UIColor appBackgroundColor],[UIColor appTimelineWhiteColor],[UIColor appSeperatorColor],nil];
    if (index >= arrayColors.count) {
        index =(int) index % arrayColors.count;
    }
    leftLabel.backgroundColor =  [arrayColors objectAtIndex:index];
}

+(NSString *)getFormattedDateString:(NSString *)dateString currentFormat:(NSString *)currentFormat displayFormat:(NSString *)requiredFormat
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
   // [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:currentFormat];
    NSDate * date = [dateFormatter dateFromString:dateString];
    date = [date dateByAddingTimeInterval:[NSTimeZone systemTimeZone].secondsFromGMT];
    [dateFormatter setDateFormat:requiredFormat];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getVideosPath:(NSString *)videoID
{
//  NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
       NSArray *path = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *  docsDirectoryPath = [path objectAtIndex:0];
    // Build the path to the database file
    NSString * learnPath = [self createFolderIfNeccessary:@"VR_VIDEOS" path:docsDirectoryPath];
    NSString * filesPath = [learnPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",videoID]];
//    NSURL * url  = [NSURL fileURLWithPath:filesPath];
//    [ url setResourceValue: [NSNumber numberWithBool: YES ] forKey: NSURLIsExcludedFromBackupKey error: nil];
     [self addSkipBackupAttributeToItemAtPath:filesPath];
    return filesPath;
}

+(void)createApplicationSupport:(NSString *)path
{
//    NSFileManager * manager = [NSFileManager defaultManager];
//    [manager fileExistsAtPath:<#(nonnull NSString *)#> isDirectory:<#(nullable BOOL *)#>]
}
+(BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    
   // assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    
    
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                    
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        
    }
    
    return success;
    
}

+(BOOL)fileExistAtPathWithId:(NSString *)videoID
{
    NSString * filePath = [self getVideosPath:videoID];
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}

+(NSString *)getFileSizeOfVideoID:(NSString *)videoID
{
     NSString * filePath = [self getVideosPath:videoID];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    NSString * string  = [NSString stringWithFormat:@"%0.2f MB",(float)data.length/1024.0f/1024.0f];
    return string;
}

+(NSString *)createFolderIfNeccessary:(NSString *)folderName path:(NSString *)path
{
    NSString *  filePath = [[NSString alloc] initWithString: [path stringByAppendingPathComponent:folderName]];
   // filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // Create the folder if necessary
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath
                           isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:filePath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    
    [self addSkipBackupAttributeToItemAtPath:filePath];
    return filePath;
}

#pragma mark DBCLASSES
+(void)insertJSONResponseInDataBase:(NSString *)jsonString type:(NSString *)type
{
    NSMutableArray * array = [DBCLASS getContentDataWithType:type];
    if (array.count)
    {
        // Updating JSON String in DB
        ContentData * data = [array firstObject];
        [DBCLASS updateContentDataWithType:data.type jsonString:jsonString];
    }
    else
    {
        // inserting JSON string into DB
        ContentData * data = [[ContentData alloc] init];
        data.jsonString = [self dictToJson:jsonString];
        data.type = type;
        [DBCLASS insertContentData:data];
    }
}

+(id)getResponseUserDefaults:(NSString *)key
{
    NSUserDefaults * defaults= [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:key])
    {
        return [defaults objectForKey:key];
    }
    return nil;
}
+(void)saveResponseInUserDefaults:(id)response WithKey:(NSString *)key
{
    @try {
        NSUserDefaults * defaults= [NSUserDefaults standardUserDefaults];
        [defaults setObject:response forKey:key];
        [defaults synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",exception);
    }
    
    
}
+(NSString *)getJSONResponseStringFromDataBaseWithType:(NSString*)type
{
    NSMutableArray * array = [DBCLASS getContentDataWithType:type];
    if (array.count)
    {
        ContentData * data = [array firstObject];
        return data.jsonString;
    }
    return @"";
}

//Convert NSDictionory to JSONString
+(NSString *)dictToJson:(id)dict
{
    NSError * error= nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
}
+(void)showErrorAlert:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:APP_TITLE message:[error.userInfo objectForKey:@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

+(BOOL)checkNetwrokConnection
{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
        return YES;
    else
        return NO;
}

+(NSString *)authorizationKey
{
    NSArray * authorizationKeys = [[NSArray alloc] initWithObjects:@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzSWQiOiJhUVcxQmtpWmsiLCJpYXQiOjE0NTMyNzM2ODd9.mXKXNk59xdAUgRYv9tnh-Il75aqz1_Wl3jit91kro3A",@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzSWQiOiJSODNHbzZzRmciLCJpYXQiOjE0NTMyNzM2ODd9.3onPRGYvghbsfHu42BrjWFI2rZ376h-S0gopMs4O24c",@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzSWQiOiJLMXBmUWt3d1oiLCJpYXQiOjE0NTMyNzM2ODd9.iOzF5aLISWvGHXo0IQc2UlOKFXOx10OhPljOFowGLfQ",@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzSWQiOiJIbFlmYlNJTFAiLCJpYXQiOjE0NTMyNzM2ODd9.w53hhqetFIxmBLcmXH4819rLbhHT7Z3JUJKZrPxPtys",@"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzSWQiOiJ5czNidHlpc2UiLCJpYXQiOjE0NTMyNzM2ODd9._p--Dru1Ct1UpBBM82AoARMd36DbcCkwV2xRTnv8e1w", nil];
    int r = arc4random_uniform(4);
    
    if (r < 5) {
        return [authorizationKeys objectAtIndex:r];
    }
    return [authorizationKeys objectAtIndex:0];
}

+(void)showNoNetworkAlert
{
    [[[UIAlertView alloc] initWithTitle:APP_TITLE message:@"No network connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

+(void)removeFileWithId:(NSString *)videoId
{
    NSString * filePath = [self getVideosPath:videoId];
    NSFileManager * fileManager  = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}
@end
