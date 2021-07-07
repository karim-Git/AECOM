//
//  TwitterFBShare.m
//  GoodyGood
//
//  Created by Prasad on 6/20/14.
//  Copyright (c) 2014 rapidBizApps. All rights reserved.
//

#import "TwitterFBShare.h"
#import <Social/Social.h>


@interface TwitterFBShare ()
{
    
}
@end
static AVAudioPlayer *audioPlayer;


@implementation TwitterFBShare

+(BOOL)isSocialTypeAvialableSocialType:(NSString *const )socialSiteType
{
    return  [SLComposeViewController isAvailableForServiceType:socialSiteType];
}

//Common method to share image on twitter & facebook
+(void)sharePost :(NSString *)message url:(NSURL*)url onSocialSite :(NSString *const )socialSiteType onViewController: (UIViewController *)SELF
{
    SLComposeViewController *socialSiteComposer=[SLComposeViewController composeViewControllerForServiceType:socialSiteType];
    if([SLComposeViewController isAvailableForServiceType:socialSiteType])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [socialSiteComposer dismissViewControllerAnimated:YES completion:nil];
            
            switch(result)
            {
                case SLComposeViewControllerResultCancelled:
                    
                default:
                {
                    NSLog(@"Cancelled.....");
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    if([socialSiteType isEqual:SLServiceTypeTwitter])
                    {
                        for (UIView *subView in SELF.view.subviews)
                        {
                            if ([subView isKindOfClass: [UITableView class]])
                            {
                                UITableView *tweetsTable = (UITableView *)subView;
                                [tweetsTable reloadData];
                            }
                        }
                    }
                }
                    break;
            }};
        //Add content to post
        [socialSiteComposer setInitialText: message];
        
        //To share image
        
        if(!url)
        {
//        UIImage *postImage = [UIImage imageNamed:@"sahredIcon.png"];
//        NSData *data = UIImageJPEGRepresentation(postImage, 1.0);
//        [socialSiteComposer addImage:[UIImage imageWithData:data]];
        }
        
        else
        {
            NSData *data =[NSData dataWithContentsOfURL:url];
            [socialSiteComposer addImage:[UIImage imageWithData:data]];
        }
        
        
        [socialSiteComposer setCompletionHandler:completionHandler];
        [SELF presentViewController:socialSiteComposer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Sorry!"  message:@"You can't post right now, make sure you have at least one account setup in settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [errorAlert show];
    }
}




+(void)playTweetSoundSound
{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tweet" ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = 0;
    audioPlayer.volume = 0.3;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [audioPlayer play];
}


@end
