//
//  BottomView.m
//  JointEffortV2
//
//  Created by Prasad on 7/31/15.
//  Copyright (c) 2015 rapidBizApps. All rights reserved.
//

#import "BottomView.h"
#import "NotificationListVC.h"
#import "PicturesListVC.h"
#import "TwitterWallVC.h"
#import "VRVideosListVC.h"


@implementation BottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadBottomViewControls];
    }
    return self;
}


-(void)loadBottomViewControls
{
    [[self subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = [UIColor bottomViewColor];
    //To set the shadow effect to the ui button
    //        self.layer.shadowColor = [UIColor appSeperatorColor].CGColor;
    //        self.layer.shadowOpacity = 1;
    //        self.layer.shadowRadius = 3;
    //        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    //
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBound.size.width;
    
    // set a horizantalline for the view as a divider
    UILabel * horizantalLine = [[UILabel alloc] initWithFrame:CGRectMake(0 ,0,CGRectGetWidth(self.frame), 0.5)];
    horizantalLine.backgroundColor = [UIColor appSeperatorColor];
    //[self addSubview:horizantalLine];
    
    float x = 10;
    float y = 0;
    float gap = 10;
    
    float buttonWidth = (screenWidth- 2*x - 3*gap)/4;
    float buttonHeight = 55;
    if  (![ReusedMethods sharedObject].isPics)
    {
        buttonWidth = (screenWidth- 2*x - 2*gap)/3;
    }
    //  float buttonHeight = buttonWidth;
    
    videosButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [videosButton setFrame :CGRectMake(x, y, buttonWidth, buttonHeight)];
    [videosButton setImage:[UIImage bottomVideoIcon] forState:UIControlStateNormal];
    //  [videosButton setTitle:@"Videos" forState:UIControlStateNormal];
    [videosButton setTitleColor:[UIColor appGrayColor] forState:UIControlStateNormal];
    [videosButton addTarget:self action:@selector(videosButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    videosButton.tag = 1;
    [self addSubview:videosButton];
    
    if  ([ReusedMethods sharedObject].isPics)
    {
        x = x + buttonWidth + gap;
        picturesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [picturesButton setFrame :CGRectMake(x, y, buttonWidth, buttonHeight)];
        [picturesButton setImage:[UIImage bottomPictureIcon] forState:UIControlStateNormal];
        //   [picturesButton setTitle:@"Photos" forState:UIControlStateNormal];
        [picturesButton setTitleColor:[UIColor appGrayColor] forState:UIControlStateNormal];
        [picturesButton addTarget:self action:@selector(picturesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        picturesButton.tag = 2;
        [self addSubview:picturesButton];
    }
    
    x = x + buttonWidth + gap;
    tweetsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tweetsButton setFrame :CGRectMake(x, y, buttonWidth, buttonHeight)];
    [tweetsButton setImage:[UIImage bottomWallIcon] forState:UIControlStateNormal];
    //[tweetsButton setTitle:@"Team" forState:UIControlStateNormal];
    //   [tweetsButton setTitle:@"Tweets" forState:UIControlStateNormal];
    [tweetsButton setTitleColor:[UIColor appGrayColor] forState:UIControlStateNormal];
    [tweetsButton addTarget:self action:@selector(tweetsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    tweetsButton.tag = 3;
    [self addSubview:tweetsButton];
    
    x = x + buttonWidth + gap;
    notificationsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [notificationsButton setFrame :CGRectMake(x, y, buttonWidth, buttonHeight)];
    [notificationsButton setImage:[UIImage bottomNotificationIcon] forState:UIControlStateNormal];
    //    [notificationsButton setTitle:@"Notifications" forState:UIControlStateNormal];
    [notificationsButton setTitleColor:[UIColor appGrayColor] forState:UIControlStateNormal];
    [notificationsButton addTarget:self action:@selector(notificationsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    notificationsButton.tag = 4;
    [self addSubview:notificationsButton];
    
    //  [self setTheCommonPropertiesForAllTheButtonsinBottomView:self];

}


# pragma mark set The Properties ForAll The Buttons in Bottom View
//To set the Common properties for buttons
-(void)setTheCommonPropertiesForAllTheButtonsinBottomView:(UIView *)selfView
{
    for (UIView *subView in selfView.subviews)
    {
        if([subView isKindOfClass:[UIButton class]])
        {
            UIButton *button = (UIButton *)subView;
            
            [button setBackgroundColor: [UIColor clearColor]];
            [[button titleLabel] setFont:[UIFont appVerySmallFont]];
          //  [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
           // [self centerAllignedImageAndTitleForButton:button];
            [button setExclusiveTouch:YES];
            button.clipsToBounds = YES;
        }
    }
}

//To  set the Edge insets allign to left for
- (void)centerAllignedImageAndTitleForButton:(UIButton *)button
{
    float spacing = 6.0f;
    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}



# pragma mark Bottom Button Actions

-(void)videosButtonAction:(UIButton *)sender
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([[[appDelegate.navController viewControllers] objectAtIndex:0] isKindOfClass:[VRVideosListVC class]])
    {
        
    }
    else
    {
        [self setActiveViewWithStoryBoardID:SB_ID_VIDEOS];
    }
}

-(void)picturesButtonAction:(UIButton *)sender
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([[[appDelegate.navController viewControllers] objectAtIndex:0] isKindOfClass:[PicturesListVC class]])
    {
        
    }
    else
    {
        [self setActiveViewWithStoryBoardID:SB_ID_PICTURES];
    }
}

-(void)tweetsButtonAction:(UIButton *)sender
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([[[appDelegate.navController viewControllers] objectAtIndex:0] isKindOfClass:[TwitterWallVC class]])
    {
        
    }
    else
    {
        [self setActiveViewWithStoryBoardID:SB_ID_TWITTERWALL];
    }
}

-(void)notificationsButtonAction:(UIButton *)sender
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([[[appDelegate.navController viewControllers] objectAtIndex:0] isKindOfClass:[NotificationListVC class]])
    {
        
    }
    else
    {
        [self setActiveViewWithStoryBoardID:SB_ID_NOTIFICATIONS];
    }
}


//Common method for to set Active view when abs selected

-(void)setActiveViewWithStoryBoardID:(NSString *)storyboardID
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:storyboardID];//SurveyDetails
    appDelegate.navController = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    appDelegate.navController.navigationBarHidden = YES;
    [appDelegate.window setRootViewController:appDelegate.navController];
}




-(void)highlightIndex:(int)index
{
    UIButton * button = (UIButton *) [self viewWithTag:index];
    [button setTitleColor:[UIColor appThemeColor2] forState:UIControlStateNormal];
    [button setImage:[self getHighLightImageName:index] forState:UIControlStateNormal];
}

-(UIImage *)getHighLightImageName:(int)index
{
    switch (index)
    {
        case 1:
            return [UIImage bottomVideoIconSelected];
            break;
        case 2:
            return [UIImage bottomPictureIconSelected];
            break;
        case 3:
            return [UIImage bottomWallIconSelected];
            break;
        case 4:
            return [UIImage bottomNotificationIconSelected];
            break;
      
            
        default:
            break;
    }
        return [UIImage bottomVideoIconSelected];
}
 


@end
