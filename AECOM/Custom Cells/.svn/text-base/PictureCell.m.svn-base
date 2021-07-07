//
//  PictureCell.m
//  AECOM
//
//  Created by Kareem on 2016-01-12.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell
@synthesize leftLabel,pictureImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        pictureImageView.image = [UIImage imageNamed:@"smallLoadingImage.jpg"];
        [pictureImageView setUserInteractionEnabled:YES];
        pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
        [pictureImageView setTag:1000];
        [self addSubview:pictureImageView];
        
        // Adding left lable
        leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2, frame.size.height)];
        leftLabel.backgroundColor = [UIColor appThemeColor];
        [self addSubview:leftLabel];
        
        
        self.clipsToBounds = YES;
    }
    return self;
}

@end
