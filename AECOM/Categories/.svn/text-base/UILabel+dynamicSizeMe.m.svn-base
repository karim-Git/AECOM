#import "UILabel+dynamicSizeMe.h"

@implementation UILabel (dynamicSizeMe)

-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];

    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,9999);
    CGSize expectedSize = [self sizeThatFits:maximumLabelSize];
    return expectedSize.height;
}
-(float)resizeToFitWidth
{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize maximumLabelSize = CGSizeMake(9999,self.frame.size.height);
    CGSize expectedSize = [self sizeThatFits:maximumLabelSize];
    
    
    float width = expectedSize.width;
    CGRect newFrame = [self frame];
    newFrame.size.width = width;
    [self setFrame:newFrame];
    return newFrame.origin.x + newFrame.size.width;
     
    
}

@end
