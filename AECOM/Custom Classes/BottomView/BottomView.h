//
//  BottomView.h
//  JointEffortV2
//
//  Created by Prasad on 7/31/15.
//  Copyright (c) 2015 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView
{
    UIButton * videosButton, * picturesButton, * tweetsButton, * notificationsButton;
}
-(void)highlightIndex:(int)index;
-(void)loadBottomViewControls;
@end
