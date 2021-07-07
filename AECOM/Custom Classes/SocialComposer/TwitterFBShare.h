//
//  TwitterFBShare.h
//  GoodyGood
//
//  Created by Prasad on 6/20/14.
//  Copyright (c) 2014 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import <AVFoundation/AVFoundation.h>


@interface TwitterFBShare : NSObject
{
    
}
//+(void)sharePost :(NSString *)message onSocialSite :(NSString *const )socialSiteType onViewController: (UIViewController *)SELF;
+(void)sharePost :(NSString *)message url:(NSURL*)url onSocialSite :(NSString *const )socialSiteType onViewController: (UIViewController *)SELF;

+(void)playTweetSoundSound;
+(BOOL)isSocialTypeAvialableSocialType:(NSString *const )socialSiteType;
@end
