//
//  AENotification.m
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "AENotification.h"

@implementation AENotification
@synthesize   comment,  createdAt,  updatedAt, _id, displayTime;

-(id)initWithNotificationDict:(NSDictionary *)dict
{
    self = [[AENotification alloc] initWithJsonObject:dict];
    self._id = [dict objectForKey:@"id"];
    self.displayTime = [ReusedMethods getFormattedDateString:self.createdAt currentFormat:DATEFORMAT_API displayFormat:DATEFORMAT_DISPLAY];
    return self;
}
@end
