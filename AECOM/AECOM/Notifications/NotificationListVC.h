//
//  NotificationListVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationListModel.h"

@interface NotificationListVC : UIViewController <NotificatioNModelDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NotificationListModel * currentModel;
    UILabel * noDataLabel;
}
@property (strong,nonatomic) IBOutlet UITableView * notificationListTableView;
@end
