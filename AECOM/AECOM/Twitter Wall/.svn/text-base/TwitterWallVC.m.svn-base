//
//  TwitterWallVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "TwitterWallVC.h"
#import "TwitterWallModel.h"
#import "UIImageView+WebCache.h"
#import "TweetComposeVC.h"

@implementation TwitterWallVC 

-(void)viewDidLoad
{
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Social"];
    [self makeUIChanges];
    currentModel = [[TwitterWallModel alloc] init];
    currentModel.delegate = self;
    [ReusedMethods addBottomViewOn:self.view index:3];
    isTweetTextFieldHidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
     [self performSelectorOnMainThread:@selector(displayLoadingActivity) withObject:nil waitUntilDone:YES];
    if  ([ReusedMethods checkNetwrokConnection])
    {
     [currentModel getTweetsListAPICall];
    }
    else
    {
        [self hideActivity];
        [ReusedMethods showNoNetworkAlert];
    }
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void)makeUIChanges
{
        // Add twiiter and instagram buttons on top
    
    UIView * buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(0 , 60, self.view.frame.size.width, 70)];
    [self.view addSubview:buttonContainerView];
    
    // Adding twitter button
    tweetButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonContainerView.frame.size.width - 70, 5, 50, 50)];
    [tweetButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [tweetButton setImage:[UIImage twitterLargeIcon] forState:UIControlStateNormal];
    [tweetButton addTarget:self action:@selector(postTweetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonContainerView addSubview:tweetButton];
    
    // Adding instagram button
    instagrmButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonContainerView.frame.size.width - 120, 5, 50, 50)];
    [instagrmButton setImage:[UIImage instagramLargeIcon] forState:UIControlStateNormal];
    [instagrmButton addTarget:self action:@selector(instagramButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonContainerView addSubview:instagrmButton];
    
    // Adding description label
    UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, CGRectGetWidth(buttonContainerView.frame) - 130, 40)];
    descLabel.font = [UIFont appNormalFont];
    descLabel.textAlignment = NSTextAlignmentRight;
    descLabel.text = @"Share the experience";
    [buttonContainerView addSubview:descLabel];
    
    
    // Adding Tableview
    float yVal = CGRectGetMaxY(buttonContainerView.frame) ;
    self.twitterListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, yVal, self.view.frame.size.width, self.view.frame.size.height - yVal-55)];
    self.twitterListTableView.delegate = self;
    self.twitterListTableView.dataSource = self;
    self.twitterListTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.twitterListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    [ReusedMethods addTableViewBackGroundColor:self.twitterListTableView];
    [ReusedMethods addTableViewBackGroundColor:self.view];
    [self.view addSubview:self.twitterListTableView];
    

    
}

-(void)addTweetTextViewToCurrentView
{
    if (textFieldContainerView == nil)
    {
        textFieldContainerView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(tweetButton.frame) + 5, self.view.frame.size.width - 20, 100)];
        self.tweetTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, textFieldContainerView.frame.size.width - 10, 90)];
        self.tweetTextView.backgroundColor = [UIColor appWhiteColor];
        self.tweetTextView.font = [UIFont appSmallFont];
        self.tweetTextView.textColor = [UIColor blackColor];
        [textFieldContainerView addSubview:self.tweetTextView];
        textFieldContainerView.backgroundColor = [UIColor appWhiteColor];
        textFieldContainerView.layer.cornerRadius = 5;
        
        // Creating postTweetButton
        // Adding tweet icon
        postTweetButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120, CGRectGetMaxY(textFieldContainerView.frame) + 5, 100, 40)];
        [postTweetButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [postTweetButton setTitle:@"Post Tweet" forState:UIControlStateNormal];
        [postTweetButton setBackgroundColor:[UIColor appThemeColor]];
        [postTweetButton addTarget:self action:@selector(postTweetButtonAction) forControlEvents:UIControlEventTouchUpInside];
        postTweetButton.layer.cornerRadius = 2.0;
        [self.view addSubview:postTweetButton];
    }
    if (isTweetTextFieldHidden)
    {
        // Updated Tableview frame
        float yVal = CGRectGetMaxY(postTweetButton.frame) + 10;
        self.twitterListTableView.frame = CGRectMake(0, yVal, self.view.frame.size.width, self.view.frame.size.height - yVal-10);
        [self.view addSubview:textFieldContainerView];
        [self.view addSubview:postTweetButton];
        isTweetTextFieldHidden = NO;
    }
    else
    {
        // Updated Tableview frame
        float yVal = CGRectGetMaxY(tweetButton.frame) + 10;
        self.twitterListTableView.frame = CGRectMake(0, yVal, self.view.frame.size.width, self.view.frame.size.height - yVal-10);
        [textFieldContainerView removeFromSuperview];
        [postTweetButton removeFromSuperview];
        isTweetTextFieldHidden = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Action
-(void)tweetButtonAction
{
    TweetComposeVC * tcVC = [[TweetComposeVC alloc] init];
    [self.navigationController pushViewController:tcVC animated:YES];
}

-(void)instagramButtonAction
{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    else
    {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.instagram.com"]];
    }
}
-(void)postTweetButtonAction
{
   // NSString *finalTweetString = [NSString stringWithFormat:@"%@" TWITTER_TAGS];
    if  ([TwitterFBShare isSocialTypeAvialableSocialType:SLServiceTypeTwitter])
    {
    [TwitterFBShare sharePost:PREPPOPULATE_TAG url:nil onSocialSite:SLServiceTypeTwitter onViewController:self];
    }
    else
    {
        TwitterWebVC * webComposer = [[TwitterWebVC alloc] init];
        [self.navigationController pushViewController:webComposer animated:YES];
    }
    
   /* NSURL *instagramURL = [NSURL URLWithString:@"twitter://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    else
    {
      //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.twitter.com"]];
      //   NSString *finalTweetString = [NSString stringWithFormat:@"%@" TWITTER_TAGS];
          // [TwitterFBShare sharePost:PREPPOPULATE_TAG url:nil onSocialSite:SLServiceTypeTwitter onViewController:self];
        NSString *finalTweetString = [NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@", PREPPOPULATE_TAG];
        finalTweetString = [finalTweetString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:finalTweetString]];
    }*/
}

#pragma mark UITableView methods
# pragma mark - TableView DataSource Methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currentModel getTableviewRowsCount];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * dict = [currentModel getCellDataAtIndexPath:indexPath];
     NSString *type=[dict objectForKey:@"TWEET_TYPE"];
    NSLog(@"TYPE %@",type);
    NSString *CellIdentifier = [NSString stringWithFormat:@"CustomCell"];
    if ([type isEqualToString:@"TWITTER"])
    {
    AETweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AETweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
    }
        NSAttributedString * messageText =[[NSAttributedString alloc] initWithData:[[dict objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    cell.messageLabel.text = messageText.string;
    cell.userNameLabel.text = [dict valueForKeyPath:@"user.screen_name"];
    cell.timeLabel.text = [self getShortTimeText:[dict valueForKey:@"created_at"]];
    [cell adjustFrames];
    return cell;
    }
    else
    {
          NSString *CellIdentifier = [NSString stringWithFormat:@"Instagram_cell"];
        InstagramCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
          if (cell == nil) {
        cell = [[InstagramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier frameWidth:tableView.frame.size.width];
          }
//        // Configure the cell...
        cell.userName.text=[[[dict objectForKey:@"caption"] objectForKey:@"from"] objectForKey:@"username"];
      //  cell.descLbl.text= [[dict objectForKey:@"caption"] objectForKey:@"text"];
        NSAttributedString * messageText =[[NSAttributedString alloc] initWithData:[[[dict objectForKey:@"caption"] objectForKey:@"text"] dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
        cell.descLbl.text = messageText.string;

        NSString *timeString = [dict objectForKey:@"created_time"];
        int time=[timeString intValue];
        cell.timeLabel.text=[self dateStringFromTimeStamp:time];
        [self setPlayButtonStatus:dict Cell:cell];
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:[self getImageURL:dict]]
                          placeholderImage:[UIImage loadingImage]];
        if (vedioPlayTag==indexPath.row)
        {
            [self playVedioWithDict:dict cell:cell];
        }
        else
        {
            [cell.playView removeFromSuperview];
        }
        [cell adjustFrames];
        return cell;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [currentModel getHeightForRowAtIndexPath:indexPath tableView:tableView];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *mediaInfo=[currentModel getCellDataAtIndexPath:indexPath];
    NSString *type=[mediaInfo objectForKey:@"type"];
    if ([type isEqualToString:@"video"])
    {
        if ([[mediaInfo allKeys] containsObject:@"videos"])
        {
            vedioPlayTag=indexPath.row;

            NSArray* rowsToReload = [NSArray arrayWithObjects:indexPath, nil];
            [tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
        }
        
    }
    

}


#pragma mark Model delegate methods
-(void)tweetsListGetSuccessFully
{
    [self performSelectorOnMainThread:@selector(hideActivity) withObject:nil waitUntilDone:YES];
    [self.twitterListTableView reloadData];
 
}
-(void)tweetsGettingFailed:(NSError *)error
{
       [self performSelectorOnMainThread:@selector(hideActivity) withObject:nil waitUntilDone:YES];
    
}
-(void)displayLoadingActivity
{
    [RBAActivityLoader setupLoaderViewOnView:self.view];
    [RBAActivityLoader showLoaderOnView:self.view withTitle:@"Loading..."];
}
-(void)hideActivity
{
    [RBAActivityLoader removeLoader];
}

# pragma mark DateStringFromTimeStamp
-(NSString *)dateStringFromTimeStamp:(int)timeStamp
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd"];
    return [dateFormatter stringFromDate:date];
}
# pragma mark getShortTimeLabel
-(NSString *)getShortTimeText:(NSString *)timeString
{
    return [timeString substringWithRange:NSMakeRange(4, 7)];
}

-(NSString *)getImageURL:(NSMutableDictionary *)dict
{
    NSDictionary *imagesDict=[dict objectForKey:@"images"];
    NSString *imageURL=[[imagesDict objectForKey:@"low_resolution"] objectForKey:@"url"];
    return imageURL;
}

-(void)setPlayButtonStatus:(NSDictionary *)dict Cell:(InstagramCell *)cell
{
    NSString *type=[dict objectForKey:@"type"];
    if ([type isEqualToString:@"video"])
    {
        cell.playButton.hidden = NO;
    }
    else
        cell.playButton.hidden = YES;
}

-(void)playVedioWithDict:(NSDictionary *)mediaInfo cell:(InstagramCell *)cell
{
    NSString *vedioURL=[[[mediaInfo objectForKey:@"videos"] objectForKey:@"low_resolution"] objectForKey:@"url"];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:cell.photoView.bounds];
    [webview setDelegate:self];
    [cell.photoView addSubview:cell.playView];
    
    [cell.playView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:vedioURL]]];
    vedioPlayTag = -1;
}
@end
