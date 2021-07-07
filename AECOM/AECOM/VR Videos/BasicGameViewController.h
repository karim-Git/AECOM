//
//  BasicGameViewController.h
//  HelloWorld
//
//  Created by Michael Fuller on 4/5/15.
//  Copyright (c) 2015 Demo. All rights reserved.
//

#import <scn-vr/SCNVirtualRealityViewController.h>

@interface BasicGameViewController : SCNVirtualRealityViewController

@property (assign) BOOL requestExit;
@property (strong,nonatomic)  NSString* videoPath;

-(void) exitLogic;

@end
