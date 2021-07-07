//
//  TwitterWallVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterWallModel.h"
#import "TwitterFBShare.h"
#import "TwitterWebVC.h"

@interface TwitterWallVC : UIViewController <UITableViewDelegate,UITableViewDataSource,TwitterWallModelDelegate>
{
    TwitterWallModel * currentModel;
    UIButton * tweetButton, *postTweetButton, * instagrmButton;
    UIView * textFieldContainerView;
    BOOL isTweetTextFieldHidden;
    int vedioPlayTag;
}
@property (strong,nonatomic) IBOutlet UITableView * twitterListTableView;
@property (strong,nonatomic) IBOutlet UITextView * tweetTextView;
@end
