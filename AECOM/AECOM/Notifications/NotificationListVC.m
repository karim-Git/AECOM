//
//  NotificationListVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "NotificationListVC.h"

@implementation NotificationListVC
-(void)viewDidLoad
{
    [self makeUIChanges];
    currentModel = [[NotificationListModel alloc] init];
    [currentModel setDelegate:self];
    
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Notifications"];
    [ReusedMethods addBottomViewOn:self.view index:4];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelectorOnMainThread:@selector(loadingActivity) withObject:nil waitUntilDone:YES];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    [currentModel getNotificationsData];
    
    noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.notificationListTableView.frame), 40)];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.text = @"No notifications to display";
    self.notificationListTableView.tableFooterView = noDataLabel;
    
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void)makeUIChanges
{
    self.notificationListTableView.delegate = self;
    self.notificationListTableView.dataSource = self;
    self.notificationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.notificationListTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    [ReusedMethods addTableViewBackGroundColor:self.notificationListTableView];
}

#pragma mark UITableView methods
# pragma mark - TableView DataSource Methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if  ([currentModel getTableviewRowsCount])
    {
        noDataLabel.hidden = YES;
    }
    else
    {
        noDataLabel.hidden = NO;
    }
    return [currentModel getTableviewRowsCount];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (AENotificationCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
    AENotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AENotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
    }
    AENotification * object = [currentModel getCellDataAtIndexPath:indexPath];
    cell.messageLabel.text = object.comment;
    cell.timeLabel.text = object.displayTime;
    [cell adjustFrames];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [currentModel getHeightForRowAtIndexPath:indexPath tableView:tableView];
}

#pragma mark Model delegate methods

-(void)notificationsGotSuccessfully
{
        [RBAActivityLoader removeLoader];
    [self.notificationListTableView reloadData];
}
-(void)notificationsFailedWithError:(NSError *)error
{
    [RBAActivityLoader removeLoader];
}

-(void)loadingActivity
{
    [RBAActivityLoader setupLoaderViewOnView:self.view];
    [RBAActivityLoader showLoaderOnView:self.view withTitle:@"Loading..."];
}

-(void)hideActivity
{
    [RBAActivityLoader removeLoader];
}

@end
