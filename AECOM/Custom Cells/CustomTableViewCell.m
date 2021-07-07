//
//  CustomTableViewCell.m
//  AutoTraderNada
//
//  Created by Kareem on 26/11/14.
//  Copyright (c) 2014 rBA. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frameWidth:(float)width
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
