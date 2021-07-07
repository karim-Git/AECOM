//
//  NotificationListModel.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "NotificationListModel.h"

@implementation NotificationListModel
@synthesize delegate;

-(void)getNotificationsData
{
    [self checkDataWithDB];
    if  ([ReusedMethods checkNetwrokConnection])
    {
    WebServiceClass * service = [[WebServiceClass alloc] init];
    service.delegate = self;
    [service getNotifications];
    }
    else
    {
        [self.delegate hideActivity];
        [ReusedMethods showNoNetworkAlert];
    }
}
-(void)checkDataWithDB
{
    id object = [ReusedMethods getResponseUserDefaults:DB_NOTIFICATION];
    if (object)
    {
        [self parseResponse:object];
    }
    
}
#pragma mark WebService Delegate methods
-(void)serviceCallDoneSuccess:(id)resposne withMethodName:(NSString *)methodName
{
     NSArray * array = (NSArray *)[resposne objectForKey:@"notifications"];
    if (array.count)
    {
        [ReusedMethods saveResponseInUserDefaults:resposne WithKey:DB_NOTIFICATION];
    }
     [self parseResponse:resposne];


}
-(void)serviceCallFailedWithError:(NSError *)error withMethodName:(NSString *)methodName
{
    NSLog(@"FAIL %@",error);
    [self.delegate notificationsFailedWithError: error];
}

-(void)parseResponse:(id)response
{
    NSArray * array = (NSArray *)[response objectForKey:@"notifications"];
    notificationsArray = [[NSMutableArray alloc] init];
 
        for (id object  in array)
        {
            AENotification * data = [[AENotification alloc] initWithNotificationDict:object];
            [notificationsArray addObject:data];
        }
 
    [self.delegate notificationsGotSuccessfully];
}
#pragma mark Tableview methods
-(AETweetFeed *)getCellDataAtIndexPath:(NSIndexPath *)indexPath
{
    return [notificationsArray objectAtIndex:indexPath.row];
}

-(NSInteger )getTableviewRowsCount
{
    return [notificationsArray count];
}

-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    AENotification  * object  = [notificationsArray objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
    AENotificationCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AENotificationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
    }
    return  [cell getDescHeight:object.comment] + 5;
    return 60;
}

@end
