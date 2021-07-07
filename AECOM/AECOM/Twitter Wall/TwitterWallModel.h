//
//  TwitterWallModel.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AECOM_HASHTAG @"aecom"
//#define TWITTER_TAGS @"@AECOM AND #VR OR #VIRTUALREALITY OR #HYPERLOOP OR #HYPERLOOPVR OR #SPACEX"
#define TWITTER_TAGS @"@aecom & #iot"
//#define TWITTER_TAGS @"aecom OR iot"
//#define TWITTER_TAGS @"%40AECOM%20AND%20%23INNOVATION%20OR%20%23BIM"
#define PREPPOPULATE_TAG @"  @AECOM #ExperienceBetter #VR"
@protocol TwitterWallModelDelegate
@optional
-(void)tweetsListGetSuccessFully;
-(void)tweetsGettingFailed:(NSError *)error;
@end
@interface TwitterWallModel : NSObject
{
    NSMutableArray * feedsArray;
    NSMutableArray * tweets, * instagrams;
}
@property (strong,nonatomic) id <TwitterWallModelDelegate> delegate;
-(void)getTweetsListAPICall;
-(id)getCellDataAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger )getTableviewRowsCount;
-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
@end
