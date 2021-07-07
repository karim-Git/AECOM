//
//  UIColor+Color.h
//  JointEffortV2
//
//  Created by Prasad on 7/17/15.
//  Copyright (c) 2015 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)

+(UIColor *)appFontColor;
+(UIColor *)appThemeColor;
+(UIColor *)appThemeColor2;
+(UIColor *)appWhiteColor;
+(UIColor *)appBackgroundColor;
+(UIColor *)appGrayColor;
//+(UIColor *)appThemeColor2;
+(UIColor *)appGreenColor;
+(UIColor *)appHeaderWhiteColor;
+(UIColor *)transperantGrayColor;
+(UIColor *)appTimelineWhiteColor;
+(UIColor *)appSeperatorColor;
+ (UIColor*) gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;
+ (UIColor *)lighterColorForColor:(UIColor *)c withAlpha:(float)alpha;



+(UIColor *)graphVioletColor;

+(UIColor *)graphYellowColor;

+(UIColor *)graphGreenColor;

+(UIColor *)graphLightGreenColor;


+(UIColor *)appTweetsCellBGColor;

@end
