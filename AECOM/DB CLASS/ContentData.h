//
//  ContentData.h
//  Gladstone
//
//  Created by Kareem on 2015-03-09.
//  Copyright (c) 2015 Chandra Sekhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentData : NSObject

@property (assign) int _id;
@property (strong,nonatomic) NSString * type, * jsonString;
@property (strong,nonatomic) NSDate * serverUpdateTime;
@end
