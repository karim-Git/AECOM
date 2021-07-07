//
//  AENotificationCell.m
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "AENotificationCell.h"

@implementation AENotificationCell
@synthesize containerView,timeLabel, messageLabel,leftLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frameWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier frameWidth:width];
    if (self) {
        // Initialization code
        float x = 10;
        float y = 10;
        
        containerView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, width - 20, 60)];
        containerView.backgroundColor = [UIColor cellBGColor];
        [self.contentView addSubview:containerView];
        
        
        //Adding userNameLabel
        x  = 15;
        y = 5;
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, CGRectGetWidth(containerView.frame)- 20, 30)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor appBlackColor];
        messageLabel.font = [UIFont appSmallFont];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        [self.containerView addSubview:messageLabel];
        
        
                timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(messageLabel.frame) + 5,CGRectGetWidth(containerView.frame)- 2 *x , 20)];
                timeLabel.backgroundColor = [UIColor clearColor];
                timeLabel.font = [UIFont appFontTooSmall];
                timeLabel.textAlignment = NSTextAlignmentRight;
                [self.containerView addSubview:timeLabel];
        
        // Adding left label for colors
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,2, 60)];
        leftLabel.backgroundColor = [UIColor notificationLeftColor];
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
    [self.messageLabel resizeToFit];
    CGSize size = self.messageLabel.frame.size;
    return size.height + 30;
}

-(void)adjustFrames
{
    [self.messageLabel resizeToFit];
    CGRect frame = self.containerView.frame;
    frame.size.height = CGRectGetHeight(self.messageLabel.frame) +30;
    self.containerView.frame = frame;
    
        frame = self.timeLabel.frame;
        frame.origin.y = CGRectGetMaxY(self.messageLabel.frame) + 5;
        self.timeLabel.frame = frame;
    
    frame = self.leftLabel.frame;
    frame.size.height = CGRectGetMaxY(self.containerView.frame) ;
    self.leftLabel.frame = frame;
}

@end
