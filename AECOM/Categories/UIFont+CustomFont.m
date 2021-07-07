//
//  UIFont+CustomFont.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "UIFont+CustomFont.h"

@implementation UIFont (CustomFont)
+(UIFont *)appFontWithSize:(float)size
{
    return [UIFont fontWithName:@"Helvetica" size:size];
}
+(UIFont *)appFontTooSmall
{
 return [UIFont fontWithName:@"Avenir" size:12.0f];
}
@end
