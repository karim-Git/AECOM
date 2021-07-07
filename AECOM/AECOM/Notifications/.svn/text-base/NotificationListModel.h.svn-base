//
//  NotificationListModel.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NotificatioNModelDelegate
@optional
-(void)notificationsGotSuccessfully;
-(void)notificationsFailedWithError:(NSError *)error;
-(void)hideActivity;
@end
@interface NotificationListModel : NSObject <WebServiceDelegate>
{
    NSMutableArray * notificationsArray;
}
@property (strong,nonatomic) id <NotificatioNModelDelegate> delegate;
-(AENotification *)getCellDataAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger )getTableviewRowsCount;
-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
-(void)getNotificationsData;
@end
