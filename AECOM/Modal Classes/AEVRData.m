//
//  AEVRData.m
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "AEVRData.h"

@implementation AEVRData
@synthesize  title,  updatedAt,  createdAt, dataDescription,  type,  url ,  thumbnail,duration;
@synthesize   _id,VRType;

-(id)initWithVRDict:(NSDictionary *)dict
{
    self = [[AEVRData alloc] initWithJsonObject:dict];
    self._id = [dict objectForKey:@"id"];
    self.dataDescription = [dict objectForKey:@"description"];
    return self;
}

@end
