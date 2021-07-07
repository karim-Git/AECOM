//
//  InstagramCell.m
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "InstagramCell.h"

@implementation InstagramCell
@synthesize descLbl,photoView,userName,timeLabel,playView,typeImage,containerView,playButton,leftLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frameWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier frameWidth:width];
    if (self) {
        // Initialization code
        float x = 10;
        float y = 5;
                float containerWidth = width - 20;
        containerView = [[UIView alloc] initWithFrame:CGRectMake(x, y, containerWidth, 60)];
        containerView.backgroundColor = [UIColor cellBGColor];
        //containerView.layer.cornerRadius = 5;
        //containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:containerView];
        x = 5;
        y = 5;
        typeImage=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, 16, 16)];
        [typeImage setImage:[UIImage instagramIcon]];
        [self.containerView addSubview:typeImage];
        
        //Adding userNameLabel
        x = CGRectGetMaxX(typeImage.frame) + 5;
        userName=[[UILabel alloc] initWithFrame:CGRectMake(x, y, 140 , 16)];
        userName.font= [UIFont appMediumBoldFont];
        userName.textColor = [UIColor userNameColor];
        [self.containerView addSubview:userName];
        
        timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(containerWidth- 70, y, 60, 15)];
        timeLabel.font= [UIFont appFontTooSmall];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.containerView addSubview:timeLabel];
        
        x = CGRectGetMinX(typeImage.frame) ;
        y = CGRectGetMaxY(userName.frame) + 5;
        
        photoView=[[UIImageView alloc] initWithFrame:CGRectMake(x, y, containerWidth - (2 * x), containerWidth - (2 * x))];
        photoView.backgroundColor = [UIColor clearColor];
        photoView.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:photoView];
        
        // Adding playbutton
        playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        playButton.frame=photoView.bounds;
        [playButton setImage:[UIImage playButtonIcon] forState:UIControlStateNormal];
        playButton.contentMode = UIViewContentModeScaleAspectFit;
        [photoView addSubview:playButton];
        
        playView=[[UIWebView alloc] initWithFrame:photoView.bounds];
        //  [self.contentView addSubview:photoView];
        
        y = CGRectGetMaxY(photoView.frame) + 5;
        
        descLbl=[[UILabel alloc] initWithFrame:CGRectMake(x, y, containerWidth - (2 * x), 15)];
        descLbl.font = [UIFont appSmallFont];
        descLbl.textAlignment = NSTextAlignmentLeft;
        descLbl.lineBreakMode = NSLineBreakByWordWrapping;
        descLbl.numberOfLines = 0;
        [self.containerView addSubview:descLbl];
        
        // Adding left label for colors
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,2, 60)];
        leftLabel.backgroundColor = [UIColor instaBGColor];
        [self.containerView addSubview:leftLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(CGFloat)getDescHeight:(NSString *)text
{
    self.descLbl.text = text;
    [self.descLbl resizeToFit];
    [self adjustFrames];
    return CGRectGetMaxY(self.containerView.frame);
}

-(void)adjustFrames
{
    [self.descLbl resizeToFit];
    float height =  CGRectGetMaxY(self.descLbl.frame) + 5;
    CGRect frame = self.containerView.frame;
    frame.size.height = height;
    self.containerView.frame = frame;
    
    frame = self.leftLabel.frame;
    frame.size.height = CGRectGetHeight(self.containerView.frame);
    self.leftLabel.frame = frame;
    
}

@end
