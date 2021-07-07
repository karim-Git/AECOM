//
//  RBAActivityLoader.m
//  GoodyGood
//
//  Created by Prasad on 6/11/14.
//  Copyright (c) 2014 rapidBizApps. All rights reserved.
//

#import "RBAActivityLoader.h"
@interface RBAActivityLoader ()
{
    
}
@end
static UIView *loaderView;
@implementation RBAActivityLoader


#pragma mark Loader

+ (void) setupLoaderViewOnView:(UIView *)selfView
{
    loaderView = [[UIView alloc] initWithFrame:selfView.bounds];
    loaderView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [loaderView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [self addActivityLoderOnView:loaderView];
}
+ (void) updateLoadingLabel : (UILabel *)labelLoading
{
    if([labelLoading.text isEqualToString:@"Loading…"]) {
        labelLoading.text = @"Loading";
    } else {
        labelLoading.text = [NSString stringWithFormat:@"%@.",labelLoading.text];
    }
    [self performSelector:@selector(updateLoadingLabel:) withObject:nil afterDelay:0.3]; //each second
    
    NSLog(@"xxxx");
}

+ (void) showLoaderOnView:(UIView *)selfView withTitle :(NSString *)title
{
    [loaderView removeFromSuperview];
    UILabel *lbl = (UILabel *)[loaderView viewWithTag:100];
    [lbl setText:title];
    [selfView addSubview:loaderView];
    
    
    [[loaderView superview] bringSubviewToFront:loaderView];
}

+ (void) removeLoader
{
    [loaderView removeFromSuperview];
}


+ (void)addActivityLoderOnView:(UIView *)loaderVw
{
    UIView *subLoader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    [subLoader setBackgroundColor:[UIColor appWhiteColor]];
    [[subLoader layer] setBorderWidth:1.0];
    [[subLoader layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[subLoader layer] setCornerRadius:10.0];
    [subLoader.layer setMasksToBounds:YES];
    [loaderVw addSubview:subLoader];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    
    [subLoader setCenter: CGPointMake( screenSize.width/2,  screenSize.height/2)];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(0, 0, 24, 24);
    CGPoint center = subLoader.center;
    //center.y -= 5;
    [spinner setCenter:center];
    [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    [loaderVw addSubview:spinner];
    subLoader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        spinner.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
    
    
    UILabel *lblLoader = [[UILabel alloc] initWithFrame:CGRectMake(0, subLoader.frame.size.height - (40 + 10), subLoader.frame.size.width, 40)];
    [lblLoader setBackgroundColor:[UIColor clearColor]];
    //[lblLoader setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
    [lblLoader setFont:[UIFont appNormalFont]];
    [lblLoader setTextAlignment:NSTextAlignmentCenter];
    [lblLoader setNumberOfLines:0];
    [lblLoader setLineBreakMode:NSLineBreakByWordWrapping];
    [lblLoader setTag:100];
    [lblLoader setTextColor:[UIColor appThemeColor]];
    
    [subLoader addSubview:lblLoader];
}


@end
