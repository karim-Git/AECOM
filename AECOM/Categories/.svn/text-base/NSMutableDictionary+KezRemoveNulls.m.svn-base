//
//  NSMutableDictionary+KezRemoveNulls.m
//  AECOM
//
//  Created by Kareem on 2016-01-15.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "NSMutableDictionary+KezRemoveNulls.h"

@implementation NSMutableDictionary (KezRemoveNulls)

- (void)Kez_removeNulls {
    NSNull *null = [NSNull null];
    for (NSObject *key in self.allKeys) {
        NSObject *value = self[key];
        if (value == null) {
            [self removeObjectForKey:key];
        } else {
            [value Kez_removeNulls];
        }
    }
}

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced setObject:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
