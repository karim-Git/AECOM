//
//  InstagramCell.h
//  AECOM
//
//  Created by Kareem on 2016-01-13.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface InstagramCell : CustomTableViewCell

@property (strong,nonatomic) UIView * containerView;
@property(strong,nonatomic)UILabel *userName;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIImageView *photoView;
@property(strong,nonatomic)UIWebView *playView;
@property(strong,nonatomic)UILabel *descLbl, * leftLabel;
@property(strong,nonatomic)UIImageView *typeImage;
@property (strong,nonatomic) UIButton * playButton;
-(CGFloat)getDescHeight:(NSString *)text;
-(void)adjustFrames;
@end
