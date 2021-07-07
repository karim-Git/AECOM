//
//  VRVideoListModel.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "VRVideoListModel.h"

@implementation VRVideoListModel
@synthesize delegate;
#pragma mark GET LIST OF VIDEOS
-(void)getListOfVideos
{
    [self checkDataWithDB];
    if  ([ReusedMethods checkNetwrokConnection])
    {
    WebServiceClass * service = [[WebServiceClass alloc] init];
    service.delegate = self;
    [service getVideos];
    }
    else
    {
        [ReusedMethods showNoNetworkAlert];
                [self.delegate hideActivity];
    }
}

-(void)checkDataWithDB
{
    id object = [ReusedMethods getResponseUserDefaults:DB_VIDEOS];
    if (object)
    {
         [self parseResponse:object];
    }
    
}
#pragma mark Tableview methods
-(AETweetFeed *)getCellDataAtIndexPath:(NSIndexPath *)indexPath
{
    return [videosArray objectAtIndex:indexPath.row];
}

-(NSInteger )getTableviewRowsCount
{
    return [videosArray count];
}

-(CGFloat)getHeightForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    AEVRData  * object  = [videosArray objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
    AEVideoCell  *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AEVideoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
    }
    if  (indexPath.row == videosArray.count-1)
        return [cell getDescHeight:object.title] + 20;
    return  [cell getDescHeight:object.title] ;
    return 60;
}

#pragma mark WebService Delegate methods
-(void)serviceCallDoneSuccess:(id)resposne withMethodName:(NSString *)methodName
{
    NSArray * array = (NSArray *)resposne;
    if  (array.count)
    [ReusedMethods saveResponseInUserDefaults:resposne WithKey:DB_VIDEOS];
    [self parseResponse:resposne];
}

-(void)parseResponse:(id)response
{
    NSArray * array = (NSArray *)response;
    videosArray = [[NSMutableArray alloc] init];
    for (id object  in array)
    {
        AEVRData * data = [[AEVRData alloc] initWithVRDict:object];
        [videosArray addObject:data];
    }
    [self.delegate getVideosSuccess];
}
-(void)serviceCallFailedWithError:(NSError *)error withMethodName:(NSString *)methodName
{
    NSLog(@"FAIL %@",error);
    [self.delegate getVideosError:error];
}

@end
