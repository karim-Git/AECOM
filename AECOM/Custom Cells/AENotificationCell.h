//
//  AENotificationCell.h
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface AENotificationCell : CustomTableViewCell
@property (strong,nonatomic) UIView * containerView;
@property (strong,nonatomic) UILabel * timeLabel, * messageLabel, * leftLabel;

-(CGFloat)getDescHeight:(NSString *)text;
-(void)adjustFrames;
@end
