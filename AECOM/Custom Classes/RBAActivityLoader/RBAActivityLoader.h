//
//  RBAActivityLoader.h
//  GoodyGood
//
//  Created by Prasad on 7/5/14.
//  Copyright (c) 2014 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBAActivityLoader : NSObject
{
}

+ (void) setupLoaderViewOnView:(UIView *)selfView;
+ (void) showLoaderOnView:(UIView *)selfView withTitle :(NSString *)title;
+ (void) removeLoader;
+ (void)addActivityLoderOnView:(UIView *)loaderVw;
+ (void) updateLoadingLabel : (UILabel *)labelLoading;


@end