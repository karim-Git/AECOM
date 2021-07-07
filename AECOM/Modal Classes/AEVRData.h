//
//  AEVRData.h
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEVRData : NSObject
@property (strong,nonatomic) NSString * title, * updatedAt, * createdAt, *dataDescription, * type, * url , * thumbnail;
@property (strong,nonatomic) NSString * _id , * duration, * VRType;
-(id)initWithVRDict:(NSDictionary *)dict;
@end
