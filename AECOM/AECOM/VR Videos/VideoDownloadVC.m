//
//  VideoDownloadVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-14.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "VideoDownloadVC.h"
#import <scn-vr/ProfileManager.h>
#import "BasicGameViewController.h"

#define ALERT_CANCEL_DOWNLOAD 101
@implementation VideoDownloadVC
@synthesize selectedVideo;

-(void)viewDidLoad
{
    [super viewDidLoad];
    app = [UIApplication sharedApplication];
    [self.view setBackgroundColor:[UIColor appWhiteColor]];
    [self makeUIChanges];
    centerPoint = CGPointMake(0, 0);

}

-(void)loadView
{
    [super loadView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelectorOnMainThread:@selector(changeOrientaion) withObject:nil waitUntilDone:YES];
    [percentageLabel resizeToFit];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    progressView.transform = transform;
    
    CGRect frame = downloadingView.frame;
    frame.size.width = CGRectGetMaxX(cancelButton.frame)  + 5;
    downloadingView.frame = frame;
    
    frame = centerView.frame;
    frame.size.width = CGRectGetMaxX(standardButton.frame)  + 5;
    centerView.frame = frame;
    centerView.center = CGPointMake(self.view.center.x, self.view.center.y);
    frame = dividerLabel.frame;
    frame.size.height = CGRectGetHeight(centerView.frame);
    dividerLabel.frame = frame;
    
    downloadingView.center = CGPointMake(self.view.center.x, downloadingView.center.y);
    downloadedLabel.center = CGPointMake(self.view.center.x, downloadedLabel.center.y);
    downloadedLabel.hidden = YES;
    
    // File already downloaded
    if  ([ReusedMethods fileExistAtPathWithId:selectedVideo._id])
    {
        downloadingView.hidden = YES;
    }
    else
    {
        [self performSelectorOnMainThread:@selector(writeDummyData) withObject:nil waitUntilDone:YES];
        [self downLoadVideoFromURL];
    }
//    if ([selectedVideo.VRType isEqualToString:VR_TYPE_VIDEO])
//    {
//        if (centerPoint.x == 0)
//        {
//            centerPoint = dividerLabel.center;
//        }
//            standardButton.center = centerPoint;
//            cardBoardButton.hidden = YES;
//            dividerLabel.hidden = YES;
//          //  standardButton.center = CGPointMake(dividerLabel.center.x, dividerLabel.center.y);
//    }
    
}

-(void)writeDummyData
{
    NSData * dummyData = [NSData data];
    [dummyData writeToFile:[ReusedMethods getVideosPath:selectedVideo._id] atomically:YES];
    [ReusedMethods addSkipBackupAttributeToItemAtPath:[ReusedMethods getVideosPath:selectedVideo._id]];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}


-(void)makeUIChanges
{
    float x = 10;
    float y = 10;
        // Adding back button
    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 100, 40)];
    [backButton setTitle:@"BACK" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont appSmallFont]];
    [backButton.layer setBorderColor:[UIColor twitterBGColor].CGColor];
    backButton.layer.borderWidth = 1.0f;
    [backButton addTarget:self action:@selector(backToVideosList) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UIColor twitterBGColor] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    
    // Select viewing mode label
    
    y = CGRectGetMaxY(backButton.frame) + 10;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y,self.view.frame.size.height - (2*x), 40)];
    label.font = [UIFont appHeaderFont];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"SELECT VIEWING MODE TO PROCEED";
    [self.view addSubview:label];
    
    // Adding centerview
     y = CGRectGetMaxY(label.frame) + 5;
    centerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, self.view.frame.size.height -(2 *x), 120)];
    [self.view addSubview:centerView];
    
    if ([selectedVideo.VRType isEqualToString:VR_TYPE_VIDEO])
    {
        standardButton = [[UIButton alloc] initWithFrame:centerView.bounds];
        [standardButton setImage:[UIImage standardIcon] forState:UIControlStateNormal];
        [standardButton addTarget:self action:@selector(standardButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [standardButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
        [centerView addSubview:standardButton];
    }
    else
    {
    // Adding cardboard button
    
    cardBoardButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
    [cardBoardButton setImage:[UIImage cardboardIcon] forState:UIControlStateNormal];
    [cardBoardButton addTarget:self action:@selector(cardBoardButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [cardBoardButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [centerView addSubview:cardBoardButton];
    
    
     dividerLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 0, 1, centerView.frame.size.height)];
    [dividerLabel setBackgroundColor:[UIColor grayColor]];
    [centerView addSubview:dividerLabel];
    // Adding standard button
    
    standardButton = [[UIButton alloc] initWithFrame:CGRectMake(146, 5, 100, 100)];
    [standardButton setImage:[UIImage standardIcon] forState:UIControlStateNormal];
    [standardButton addTarget:self action:@selector(standardButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [standardButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [centerView addSubview:standardButton];
    }
    // creating dowloading view
    y = self.view.frame.size.width - 65;
    downloadingView = [[UIView alloc] initWithFrame:CGRectMake(x, y, self.view.frame.size.height -(2 *x), 60)];
   // downloadingView.backgroundColor= [UIColor redColor];
 //   downloadingView.clipsToBounds = YES;
    [self.view addSubview:downloadingView];
    
    //Adding percentage labe
    percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
    [percentageLabel setFont:[UIFont appSmallFont]];
    percentageLabel.lineBreakMode = NSLineBreakByCharWrapping;
     percentageLabel.numberOfLines = 0;
    percentageLabel.text = @"Downloading... 0%";
    [downloadingView addSubview:percentageLabel];
    // Adding progressview
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(170, 20, 100, 30)];
    [progressView setProgress:0.0];
    progressView.tintColor  = [UIColor instaBGColor];
    [progressView setProgressViewStyle:UIProgressViewStyleDefault];
   [downloadingView addSubview:progressView];
    
    // adding cancel button
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 5, 100, 30)];
    [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont appSmallFont]];
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor appBlackColor] forState:UIControlStateNormal];
    [downloadingView addSubview:cancelButton];
    
    // Adding downloded label
    downloadedLabel = [[UILabel alloc] initWithFrame:downloadingView.frame];
    downloadedLabel.font = [UIFont appSmallFont];
    downloadedLabel.textAlignment = NSTextAlignmentCenter;
    downloadedLabel.text = @"Please place your phone in the google cardboard";
    [self.view addSubview:downloadedLabel];
    
}

-(void)downLoadVideoFromURL
{
    if  ([ReusedMethods checkNetwrokConnection])
    {
        bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
            // webData = [NSMutableData data];
         //   [app endBackgroundTask:bgTask];
        }];
        //here you need to finish what you are doing evven if you've not finished yet, otherwise your app will be killed
        self.handle = [NSFileHandle fileHandleForUpdatingAtPath:[ReusedMethods getVideosPath:selectedVideo._id]];
        NSString * urlString = selectedVideo.url;
        NSURL * url = [NSURL URLWithString:urlString];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
        conn = [NSURLConnection connectionWithRequest:request delegate:self];
        dataLength = 0.0f;
    }
    else
    {
        [ReusedMethods showNoNetworkAlert];
        [ReusedMethods removeFileWithId:selectedVideo._id];
    }
}

-(void)downLoadVideoFromStandardURL
{
    NSString * urlString = selectedVideo.url;
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    conn = [NSURLConnection connectionWithRequest:request delegate:self];
    webData = [NSMutableData data];
}

-(void)downLoadVideoFromCardboardURL
{
    NSString * urlString = selectedVideo.url;
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    conn = [NSURLConnection connectionWithRequest:request delegate:self];
    webData = [NSMutableData data];
}

#pragma mark Button Actions
-(void)backToVideosList
{
    [self cancelButtonAction];
}

-(void)cancelButtonAction
{
    if (conn)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:APP_TITLE message:@"Do you want to cancel download?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:ALERT_CANCEL_DOWNLOAD];
        [alert show];
    }
    else
    {
          [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark Card Board and Standard button Action
-(void)cardBoardButtonTapped
{
    if  (conn)
    {
        [[[UIAlertView alloc] initWithTitle:APP_TITLE message:@"Downloading in progress." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    }
    if ([ReusedMethods fileExistAtPathWithId:selectedVideo._id])
    {
        [[ProfileManager sharedManager] selectIndex:1];
        UIStoryboard *st = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
        BasicGameViewController *viewController = (BasicGameViewController*)[st instantiateViewControllerWithIdentifier:@"BasicGameViewController"];
        viewController.videoPath =  [ReusedMethods getVideosPath:selectedVideo._id];
        
        [self.navigationController pushViewController:viewController animated:NO];
        
    }
}

-(void)standardButtonTapped
{
    if  (conn)
    {
        [[[UIAlertView alloc] initWithTitle:APP_TITLE message:@"Downloading in progress." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    }
    if ([ReusedMethods fileExistAtPathWithId:selectedVideo._id])
    {
        if( [selectedVideo.VRType isEqualToString:VR_TYPE_VIDEO] ) {

            NSURL *url = [[NSURL alloc] initFileURLWithPath:[ReusedMethods getVideosPath:selectedVideo._id]];
            HTY360PlayerVC *videoController = [[HTY360PlayerVC alloc] initWithNibName:@"HTY360PlayerVC" bundle:nil url:url];
            
            if (![[self presentedViewController] isBeingDismissed]) {
                [self presentViewController:videoController animated:YES completion:nil];
            }
        } else {
            [[ProfileManager sharedManager] selectIndex:5];
            UIStoryboard *st = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
            BasicGameViewController *viewController = (BasicGameViewController*)[st instantiateViewControllerWithIdentifier:@"BasicGameViewController"];
            viewController.videoPath =  [ReusedMethods getVideosPath:selectedVideo._id];
            
            [self.navigationController pushViewController:viewController animated:NO];
            
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [[UIDevice currentDevice] setValue:
//     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
//                                forKey:@"orientation"];
}
-(void)changeOrientaion
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
                                forKey:@"orientation"];
}

#pragma mark NSURLConnection Delegate methods

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
   // [webData setLength: 0];
    NSLog(@"RECIEVE ReSPONSE");
        fileSize = [response expectedContentLength];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
    //[webData appendData:data];
  //  NSString * filePath = [ReusedMethods getVideosPath:selectedVideo._id];
   // NSLog(@"FILE PATH %@",filePath);
    dataLength = dataLength + data.length;
     [self.handle seekToEndOfFile];
    [self.handle writeData:data];
  //  webData = [NSMutableData data];
    float percentage = (float)dataLength/fileSize;
    NSLog(@"Percentage %f",percentage * 100);
    progressView.progress = percentage;
    percentageLabel.text = [NSString stringWithFormat:@"Downloading... %d%%",(int)(percentage * 100)];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
    NSLog(@"error is %@",[error userInfo]);
    [[[UIAlertView alloc] initWithTitle:APP_TITLE message:[[error userInfo] objectForKey:@"NSLocalizedDescription"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    [self.handle closeFile];
    [ReusedMethods removeFileWithId:selectedVideo._id];
    conn = nil;
     [app endBackgroundTask:bgTask];
}
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSLog(@"finish ");
    [self saveFileToDocuments];
    [self performSelectorOnMainThread:@selector(hideDownloadView) withObject:nil waitUntilDone:YES];
    
    conn = nil;
    [self.handle closeFile];
     [app endBackgroundTask:bgTask];
}

-(void)hideDownloadView
{
    downloadingView.hidden = YES;
}

#pragma mark saveFile  To Documents Directory
-(void)saveFileToDocuments
{
    NSString * filePath = [ReusedMethods getVideosPath:selectedVideo._id];
   // NSLog(@"path %@",filePath);
   // [webData writeToFile:filePath atomically:YES];
   // [webData writeToFile:filePath options:NSDataWritingWithoutOverwriting error:nil];
    [ReusedMethods addSkipBackupAttributeToItemAtPath:filePath];
}

#pragma mark UIALertview delegate method
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_CANCEL_DOWNLOAD)
    {
         if   (buttonIndex == 0)
         {
             [conn cancel];
             [ReusedMethods removeFileWithId:selectedVideo._id];
             [self.navigationController popViewControllerAnimated:NO];
         }
    }
}

@end
