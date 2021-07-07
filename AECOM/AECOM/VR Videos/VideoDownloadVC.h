//
//  VideoDownloadVC.h
//  AECOM
//
//  Created by Kareem on 2016-01-14.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDownloadVC : UIViewController <NSURLConnectionDelegate,UIAlertViewDelegate>
{
    UIView * centerView;
    UIButton * cardBoardButton, * standardButton;
    UIView * downloadingView;
    UILabel * downloadedLabel;
    UILabel * percentageLabel;
    UIProgressView * progressView;
    UIButton * cancelButton;
    UILabel * dividerLabel ;
    
    NSURLConnection * conn;
    NSMutableData * webData;
    float fileSize;
    CGPoint centerPoint;
    float dataLength;
    UIApplication* app;
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong,nonatomic) AEVRData * selectedVideo;
@property (nonatomic,strong) NSFileHandle *handle;
@end
