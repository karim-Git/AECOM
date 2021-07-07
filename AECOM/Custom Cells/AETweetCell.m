//
//  AETweetCell.m
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "AETweetCell.h"

@implementation AETweetCell
@synthesize containerView,timeLabel, messageLabel,leftLabel,userNameLabel;
@synthesize typeImage;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
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
     //   containerView.layer.cornerRadius = 5;
        containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:containerView];
        
        
        y = 5;
        // Adding iconImageView
        typeImage=[[UIImageView alloc] initWithFrame:CGRectMake(5, y, 16, 16)];
        [typeImage setImage:[UIImage twitterIcon]];
        typeImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.containerView addSubview:typeImage];
        
        //Adding userNameLabel
        x = CGRectGetMaxX(typeImage.frame) + 5;
        userNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, containerWidth - (x + 5) , 16)];
        userNameLabel.font= [UIFont appMediumBoldFont];
        userNameLabel.textColor = [UIColor userNameColor];
        [self.containerView addSubview:userNameLabel];
        
        y = CGRectGetMaxY(userNameLabel.frame) + 5;
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, containerWidth - (x + 5), 30)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor appBackgroundColor];
        messageLabel.font = [UIFont appSmallFont];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        [self.containerView addSubview:messageLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(messageLabel.frame) + 5,containerWidth- (x + 5) , 20)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor appBlackColor];
        timeLabel.font = [UIFont appFontTooSmall];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [self.containerView addSubview:timeLabel];
        
        // Adding left label for colors
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,2, 60)];
        leftLabel.backgroundColor = [UIColor twitterBGColor];
        [self.containerView addSubview:leftLabel];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

-(CGFloat)getDescHeight:(NSString *)text
{
    self.messageLabel.text = text;
    [self adjustFrames];
   // CGSize size = self.leftLabel.frame.size;
    return CGRectGetMaxY(self.containerView.frame);
}

-(void)adjustFrames
{
    [self.messageLabel resizeToFit];
    
    CGRect  frame = self.timeLabel.frame;
    frame.origin.y = CGRectGetMaxY(self.messageLabel.frame) + 5;
    self.timeLabel.frame = frame;
    
     frame = self.containerView.frame;
    frame.size.height = CGRectGetMaxY(self.timeLabel.frame) + 5;
    self.containerView.frame = frame;
    
    frame = self.leftLabel.frame;
    frame.size.height = CGRectGetHeight(self.containerView.frame);
    self.leftLabel.frame = frame;
}

@end
