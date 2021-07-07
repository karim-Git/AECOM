//
//  AEVideoCell.m
//  AECOM
//
//  Created by Kareem on 2016-01-14.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "AEVideoCell.h"

@implementation AEVideoCell
@synthesize    titleLabel,  timeLabel,  leftLabel,  videoTypeButton;
@synthesize   thumbNailImage;
@synthesize    downloadButton;
@synthesize   containerView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frameWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier frameWidth:width];
    if (self) {
        // Initialization code
        float x = 10;
        float y = 5;
        float containerWidth = width - 20;
        containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, containerWidth, 240)];
        containerView.backgroundColor = [UIColor cellBGColor];
     //   containerView.layer.cornerRadius = 5;
       //containerView.layer.masksToBounds = YES;
        //containerView.layer.borderWidth = 1;
     //   containerView.layer.borderColor = [UIColor bottomViewColor].CGColor;
        [self.contentView addSubview:containerView];
        
        x = 0;
        y = 0;
        // Adding thumbnail image view
        thumbNailImage=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, containerWidth, containerWidth)];
        thumbNailImage.backgroundColor = [UIColor clearColor];
        thumbNailImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:thumbNailImage];
        
        // Adding file name label
        x = 5;
        y = CGRectGetMaxY(thumbNailImage.frame) + 10;
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 140 , 16)];
        titleLabel.font= [UIFont appFontTooSmall];
        titleLabel.textColor = [UIColor userNameColor];
        [self.containerView addSubview:titleLabel];
        
        // Adding file name label
        x = 10;
        y = CGRectGetMaxY(thumbNailImage.frame) + 5;
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, containerWidth - (x + 80) , 21)];
        titleLabel.font= [UIFont appSmallFont];
        [self.containerView addSubview:titleLabel];
        
        //Adding timeLabel label
        x = CGRectGetMaxX(titleLabel.frame) + 5;
        timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(containerWidth - 80, y, 70 , 21)];
        timeLabel.font= [UIFont appVerySmallFont];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.containerView addSubview:timeLabel];
        
        // Adding left label for colors
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,3, 240)];
        leftLabel.backgroundColor = [UIColor instaBGColor];
        [self.containerView addSubview:leftLabel];
        
        //addding download button top of imageview
        
        downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(thumbNailImage.frame) - 110, 5, 100, 30)];
        [downloadButton setTitle:@"DOWNLOAD" forState:UIControlStateNormal];
        downloadButton.layer.cornerRadius = 2;
        [downloadButton.titleLabel setFont:[UIFont appFontTooSmall]];
        downloadButton.layer.masksToBounds = YES;
        downloadButton.layer.borderWidth = 1;
        downloadButton.layer.borderColor = [UIColor appWhiteColor].CGColor;
        [thumbNailImage addSubview:downloadButton];
        
        // adding video type to thumbnail image
        videoTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(downloadButton.frame) - 40, 5, 30, 30)];
        videoTypeButton.layer.cornerRadius = 15;
        [videoTypeButton.titleLabel setFont:[UIFont appFontTooSmall]];
        videoTypeButton.layer.masksToBounds = YES;
        videoTypeButton.layer.borderWidth = 1;
        [videoTypeButton setTitle:@"360" forState:UIControlStateNormal];
        videoTypeButton.layer.borderColor = [UIColor appWhiteColor].CGColor;
        [thumbNailImage addSubview:videoTypeButton];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(CGFloat)getDescHeight:(NSString *)text
{
    self.titleLabel.text = text;
    [self.titleLabel resizeToFit];
    CGRect frame = self.containerView.frame;
    frame.size.height = CGRectGetMaxY (self.titleLabel.frame)  + 5 ;
    self.containerView.frame = frame;
    
    frame = self.leftLabel.frame;
    frame.size.height = CGRectGetHeight(self.containerView.frame);
    self.leftLabel.frame = frame;
    return  CGRectGetMaxY(self.containerView.frame) ;
//    self.descLbl.text = text;
//    [self.descLbl resizeToFit];
//    
//    return CGRectGetMaxY(self.descLbl.frame) + 15;
}

-(void)adjustFrames
{
    [self.titleLabel resizeToFit];
    CGRect frame = self.containerView.frame;
    frame.size.height = CGRectGetMaxY (self.titleLabel.frame)  + 5 ;
    self.containerView.frame = frame;
    
    frame = self.leftLabel.frame;
    frame.size.height = CGRectGetHeight(self.containerView.frame);
    self.leftLabel.frame = frame;
}

@end
