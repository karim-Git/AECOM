//
//  AENotification.h
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AENotification : NSObject
@property (strong,nonatomic) NSString * comment, * createdAt, * updatedAt, *_id, * displayTime;
-(id)initWithNotificationDict:(NSDictionary *)dict;
@end
