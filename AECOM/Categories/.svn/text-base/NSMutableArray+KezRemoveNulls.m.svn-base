//
//  NSMutableArray+KezRemoveNulls.m
//  AECOM
//
//  Created by Kareem on 2016-01-15.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "NSMutableArray+KezRemoveNulls.h"

@implementation NSMutableArray (KezRemoveNulls)

- (void)Kez_removeNulls {
    [self removeObject:[NSNull null]];
    for (NSObject *child in self) {
        [child Kez_removeNulls];
    }
}

- (NSArray *)arrayByReplacingNullsWithBlanks  {
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

@end
