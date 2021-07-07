//
//  AETweetCell.h
//  AECOM
//
//  Created by Kareem on 2016-01-11.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface AETweetCell : CustomTableViewCell
@property (strong,nonatomic) UIView * containerView;
@property (strong,nonatomic) UIImageView * typeImage;
@property (strong,nonatomic) UILabel  * timeLabel, * messageLabel, * userNameLabel;
@property (strong,nonatomic) UILabel * leftLabel;

-(CGFloat)getDescHeight:(NSString *)text;
-(void)adjustFrames;
@end
