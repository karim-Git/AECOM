//
//  UIColor+Color.m
//  JointEffortV2
//
//  Created by Prasad on 7/17/15.
//  Copyright (c) 2015 rapidBizApps. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)

+(UIColor *)appFontColor
{
    return [UIColor colorWithRed:83/255.0f green:83/255.0f blue:83/255.0f alpha:1];
}

+(UIColor *)appThemeColor
{
    return [UIColor colorWithRed:49/255.0f green:182/255.0f blue:255/255.0f alpha:1];
}

+(UIColor *)appThemeColor2
{
    return [UIColor colorWithRed:252/255.0f green:119/255.0f blue:0/255.0f alpha:1];
   
    //return [UIColor colorWithRed:242/255.0f green:88/255.0f blue:66/255.0f alpha:1];
}


+(UIColor *)appBackgroundColor
{
    return [UIColor colorWithRed:43/255.0f green:42/255.0f blue:41/255.0f alpha:1];
}

+(UIColor *)appWhiteColor
{
    return [UIColor colorWithRed:255/255.0 green:255/255.0 blue:253/255.0 alpha:1.0];
}

+(UIColor *)appGrayColor
{
    return [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
}

+(UIColor *)appDarkGrayColor
{
    return [UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1];
}


+(UIColor *)appHeaderWhiteColor
{
    return [UIColor colorWithWhite:0.90 alpha:1];
}


+(UIColor *)appTimelineWhiteColor
{
    return [UIColor colorWithWhite:0.91 alpha:1];
}


+(UIColor *)transperantGrayColor
{
    return [UIColor colorWithWhite:0.5 alpha:0.5];
}

+(UIColor *)appGreenColor
{
    return  [UIColor colorWithRed:94/255.0f green:188/255.0f blue:63/255.0f alpha:1];
}

+(UIColor *)appSeperatorColor
{
    return  [UIColor colorWithWhite:0.8 alpha:1];
}





+(UIColor *)graphVioletColor
{
    return  [UIColor colorWithRed:159/255.0f green:155/255.0f blue:232/255.0f alpha:1];
}

+(UIColor *)graphYellowColor
{
    return  [UIColor colorWithRed:223/255.0f green:206/255.0f blue:100/255.0f alpha:1];
}

+(UIColor *)graphGreenColor
{
    return  [UIColor colorWithRed:183/255.0f green:214/255.0f blue:145/255.0f alpha:1];
}


+(UIColor *)graphLightGreenColor
{
      return  [UIColor colorWithRed:147/255.0f green:227/255.0f blue:201/255.0f alpha:1];
}


+ (UIColor*) gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)lighterColorForColor:(UIColor *)c withAlpha:(float)alpha
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:alpha];
    return nil;
}

+(UIColor *)appTweetsCellBGColor
{
    return [UIColor colorWithRed:(53.0f/255.0f) green:(54.0f/255.0f) blue:(55.0f/255.0f) alpha:0.9];
}



@end
