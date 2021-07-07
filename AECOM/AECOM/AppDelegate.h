//
//  AppDelegate.h
//  AECOM
//
//  Created by Prasad on 1/11/16.
//  Copyright (c) 2016 rapidBizApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UINavigationController *navController;

- (void) setRootViewController;
-(void)refreshBottomView;
@end

