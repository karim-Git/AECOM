//
//  WebServiceClass.h
//  AECOM
//
//  Created by Kareem on 2016-01-12.
//  Copyright © 2016 rapidBizApps. All rights reserved.
//

#import <Foundation/Foundation.h>
//#define BASE_URL @"http://54.167.140.136:1338/api/"
//#define BASE_URL @"http://54.173.69.144:3000/api/"
//#define BASE_URL @"http://54.173.69.144:3001/api/"
#define BASE_URL @"https://exp-aecom.rapidbizapps.com/api/"
@protocol WebServiceDelegate
@optional
-(void)serviceCallDoneSuccess:(id)resposne withMethodName:(NSString *)methodName;
-(void)serviceCallFailedWithError:(NSError *)error withMethodName:(NSString *)methodName;
@end
@interface WebServiceClass : NSObject
{
    
}
@property (strong,nonatomic) NSString * methodName;
@property (strong,nonatomic) id <WebServiceDelegate> delegate;
-(void)getVideos;
-(void)getNotifications;
-(void)getPhotos;
-(void)postDeviceId:(NSString *)deviceId;
@end
