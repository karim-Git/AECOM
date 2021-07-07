//
//  TweetComposeVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-14.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "TweetComposeVC.h"
@implementation TweetComposeVC
@synthesize composeTextView,postTweetButton;
-(void)viewDidLoad
{
    
    [self.view setBackgroundColor:[UIColor appWhiteColor]];
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Tweet" WithDelegate:self];
    [self makeUIChanges];
    
  // Do any additional setup after loading the view, typically from a nib.
}

-(void)makeUIChanges
{
    float x = 10;
    float y = 70;
    float width =  self.view.frame.size.width - 2 * x;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y,width, 40)];
    label.font = [UIFont appHeaderFont];
    label.text = @"Share the experience";
    [self.view addSubview:label];
    
    y = CGRectGetMaxY(label.frame) + 5;
    
   UIView *  textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(x, y , width, 120)];
    [self.view addSubview:textFieldContainerView];
    self.composeTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, textFieldContainerView.frame.size.width - 10, 100)];
    self.composeTextView.backgroundColor = [UIColor appWhiteColor];
    self.composeTextView.font = [UIFont appSmallFont];
    self.composeTextView.textColor = [UIColor blackColor];
    [textFieldContainerView addSubview:self.composeTextView];
    textFieldContainerView.layer.borderColor = [UIColor twitterBGColor].CGColor;
    textFieldContainerView.layer.borderWidth = 1;
    textFieldContainerView.backgroundColor = [UIColor appWhiteColor];
    textFieldContainerView.layer.cornerRadius = 5;
    
    
    // Creating postTweetButton
    // Adding tweet icon
    postTweetButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(textFieldContainerView.frame) + 5, 100, 40)];
    [postTweetButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [postTweetButton setTitle:@"Post Tweet" forState:UIControlStateNormal];
    [postTweetButton setBackgroundColor:[UIColor appThemeColor]];
    [postTweetButton addTarget:self action:@selector(postTweetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    postTweetButton.layer.cornerRadius = 2.0;
    postTweetButton.layer.masksToBounds = YES;
    [self.view addSubview:postTweetButton];
}

-(void)postTweetButtonAction
{
    NSString *finalTweetString = [NSString stringWithFormat:@"%@ @%@",self.composeTextView.text, AECOM_HASHTAG];
    
    [TwitterFBShare sharePost:finalTweetString url:nil onSocialSite:SLServiceTypeTwitter onViewController:self];
}
-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
