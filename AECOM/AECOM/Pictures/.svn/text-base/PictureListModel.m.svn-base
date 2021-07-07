//
//  PictureListModel.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "PictureListModel.h"

@implementation PictureListModel
@synthesize delegate;

-(void)getPhotos
{
    [self checkDataWithDB];
    WebServiceClass * service = [[WebServiceClass alloc] init];
    service.delegate = self;
    [service getPhotos];
}

-(void)checkDataWithDB
{
    id object = [ReusedMethods getResponseUserDefaults:DB_PICS];
    if (object)
    {
        [self parseResponse:object];
    }
    
}
#pragma mark WebService Delegate methods
-(void)serviceCallDoneSuccess:(id)resposne withMethodName:(NSString *)methodName
{
    [ReusedMethods saveResponseInUserDefaults:resposne WithKey:DB_PICS];
    [self parseResponse:resposne];
    
}
-(void)serviceCallFailedWithError:(NSError *)error withMethodName:(NSString *)methodName
{
    NSLog(@"FAIL %@",error);
 [self.delegate getPhotosError:error];
}

-(void)parseResponse:(id)response
{
    NSArray * array = (NSArray *)response;
    picturesArray = [[NSMutableArray alloc] init];
    for (id object  in array)
    {
        AEVRData * data = [[AEVRData alloc] initWithVRDict:object];
        [picturesArray addObject:data];
    }
    [self.delegate getPhotosSuccess];
}
#pragma mark Colloection view methods
- (NSInteger)numberOfSectionsInCollectionView
{
    return 1;
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return picturesArray.count;
}

-(AEVRData *)getItemAtIndexPath:(NSIndexPath *)indexpath
{
    return [picturesArray objectAtIndex:indexpath.row];
}

-(NSMutableArray *)getPicturesArray
{
    return picturesArray;
}

@end
