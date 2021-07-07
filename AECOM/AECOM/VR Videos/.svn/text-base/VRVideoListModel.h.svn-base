//
//  VRVideoListModel.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceClass.h"
@protocol VRVideoListModelDelegate
@optional
-(void)getVideosSuccess;
-(void)getVideosError:(NSError *)error;
-(void)hideActivity;
@end
@interface VRVideoListModel : NSObject <WebServiceDelegate>
{
    NSMutableArray * videosArray;
}
@property (strong,nonatomic) id <VRVideoListModelDelegate> delegate;
-(void)getListOfVideos;
-(AEVRData *)getCellDataAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger )getTableviewRowsCount;
-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
@end
