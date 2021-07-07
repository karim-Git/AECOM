//
//  WebServiceClass.m
//  AECOM
//
//  Created by Kareem on 2016-01-12.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import "WebServiceClass.h"

@implementation WebServiceClass
@synthesize delegate;

-(void)postDeviceId:(NSString *)deviceId
{
    NSString * urlString = [self prepareURLString:@"deviceId"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * deviceToken = [defaults objectForKey:@"DeviceToken"];
    NSMutableDictionary * deviceIdDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:deviceToken,@"deviceId", nil];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request = [self setAuthorizationToRequest:request];
    NSError * error ;
    NSData * postDictData = [NSJSONSerialization dataWithJSONObject:[deviceIdDict jsonObject] options:NSJSONWritingPrettyPrinted error:&error];
    [request setHTTPBody:postDictData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if   (data)
                               {
                                   [RBAActivityLoader removeLoader];
                                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   NSLog(@"DEVICE DICT %@",responseDictionary);
                               }
                               if (connectionError)
                               {
                                   [RBAActivityLoader removeLoader];
                                 //  NSLog(@"PNS error %@",connectionError);
                               }
                           }];
    
}
-(void)getVideos
{
    NSString * urlString = [self prepareURLString:@"files/video"];
    [self connectServerWithRequest:urlString];
}

-(void)getPhotos
{
    NSString * urlString = [self prepareURLString:@"files/image"];
    [self connectServerWithRequest:urlString];
}

-(void)getNotifications
{
    NSString * urlString = [self prepareURLString:@"notifications/"];
    [self connectServerWithRequest:urlString];
}
-(void)connectServerWithRequest:(NSString *)urlString
{
    NSURL * url = [NSURL URLWithString:urlString];
  //  NSData * data = [NSData dataWithContentsOfURL:url];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    request = [self setAuthorizationToRequest:request];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if   (data)
                               {
                                   [RBAActivityLoader removeLoader];
                                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                   [self.delegate serviceCallDoneSuccess:responseDictionary withMethodName:self.methodName];
                               }
                               if (connectionError)
                               {
                                   [RBAActivityLoader removeLoader];
                                   [self.delegate serviceCallFailedWithError:connectionError withMethodName:self.methodName];
                               }
                           }];
}
-(NSString *)prepareURLString:(NSString *)string
{
    NSString * urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,string];
    return urlString;
}

-(NSMutableURLRequest *)setAuthorizationToRequest:(NSMutableURLRequest *)request
{
    [request addValue:[ReusedMethods authorizationKey] forHTTPHeaderField:@"Authorization"];
    return request;
}

@end
