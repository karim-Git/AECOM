//
//  UIFont+Font.m
//  JointEffortV2
//
//  Created by Prasad on 7/17/15.
//  Copyright (c) 2015 rapidBizApps. All rights reserved.
//

#import "UIFont+Font.h"

@implementation UIFont (Font)

+(UIFont *)appHugeFont
{
    return [UIFont  fontWithName:@"Avenir-Roman" size:23];
}
+(UIFont *)appHeaderFont
{
    return  [UIFont  fontWithName:@"Avenir-Medium" size:20];
}
+(UIFont *)appBigFont
{
    return  [UIFont  fontWithName:@"Avenir-Medium" size:17];
}
+(UIFont *)appNormalFont
{
    return  [UIFont  fontWithName:@"Avenir-Roman" size:17];
}

+(UIFont *)appSmallFont
{
    return  [UIFont  fontWithName:@"Avenir-Roman" size:15];
}

+(UIFont *)appVerySmallFont
{
    return  [UIFont  fontWithName:@"Avenir-Roman" size:11.7];
}

+(UIFont  *) appPopUPDescriptionFont{
    
    return [UIFont  fontWithName:@"Avenir-Roman" size:15];
}
+(UIFont  *) appRangeOfMotionFont
{
    return [UIFont  fontWithName:@"Avenir-Roman" size:14.9];
}
+(UIFont *)appMediumBoldFont
{
  return [UIFont  fontWithName:@"Avenir-Medium" size:14];
}
@end
