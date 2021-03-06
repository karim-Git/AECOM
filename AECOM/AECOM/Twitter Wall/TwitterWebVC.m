//
//  TwitterWebVC.m
//  AECOM
//
//  Created by Kareem on 2016-01-20.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "TwitterWebVC.h"

@implementation TwitterWebVC
-(void)viewDidLoad
{
    
    [self.view setBackgroundColor:[UIColor appWhiteColor]];
    [ReusedMethods setNavigationViewOnView:self.view WithSingleTitle:@"Tweet" WithDelegate:self];
    [self makeUIChanges];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([ReusedMethods checkNetwrokConnection])
    {
        // Loading Request
        NSString *finalTweetString = [NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@", PREPPOPULATE_TAG];
        finalTweetString = [finalTweetString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalTweetString]]];
    }
    else
    {
            [ReusedMethods showNoNetworkAlert];
    }

}
-(void)makeUIChanges
{
    float x = 0;
    float y = 55;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y , self.view.frame.size.width, self.view.frame.size.height - 55)];
    [self.view addSubview:webView];
    
}


-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma WEBVIEW DELEGATE METHODS
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"START");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"FINISH");
}
/*- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"ERROR");
}*/

@end
