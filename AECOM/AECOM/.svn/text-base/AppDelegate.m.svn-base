//
//  AppDelegate.m
//  AECOM
//
//  Created by Prasad on 1/11/16.
//  Copyright (c) 2016 rapidBizApps. All rights reserved.
//

#import "AppDelegate.h"
#import "VideoDownloadVC.h"
#import "BasicGameViewController.h"
#import "ViewController.h"
#import <scn-vr/ProfileManager.h>
#import <scn-vr/WizardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    sleep(3);
    ProfileManager * profileManager = [ProfileManager sharedManager];
    WizardManager * wizardManager = [profileManager wizardManager];
    [self setRootViewController];
    [self.window makeKeyAndVisible];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        // use registerUserNotificationSettings
        UIUserNotificationType types = UIUserNotificationActivationModeBackground|UIUserNotificationTypeBadge| UIUserNotificationTypeAlert|UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mysettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:mysettings];
        [application registerForRemoteNotifications];
    } else {
        // use registerForRemoteNotifications
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        //===       application.applicationIconBadgeNumber = 0;
    }
    [application setStatusBarHidden:YES];
    return YES;
}

- (void) setViewControllerLoad{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    _navController = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    _navController.navigationBarHidden = YES;

 /*   ViewController  * loginVC = [[ViewController alloc] init];
    _navController = [[UINavigationController alloc]initWithRootViewController:loginVC];
    _navController.navigationBarHidden = YES;*/
}
- (void) setRootViewController{
    VRVideosListVC  * loginVC = [[VRVideosListVC alloc] init];
    _navController = [[UINavigationController alloc]initWithRootViewController:loginVC];
    _navController.navigationBarHidden = YES;
    self.window.rootViewController = _navController;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSLog(@"Device token %@",hexToken);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:hexToken forKey:@"DeviceToken"];
    [defaults synchronize];
    

    [self performSelector:@selector(registerDeviceWithServer:) withObject:hexToken afterDelay:0.1];
}

-(void)registerDeviceWithServer:(NSString *)token
{
    if  ([ReusedMethods checkNetwrokConnection])
    {
    WebServiceClass * service = [[WebServiceClass alloc] init];
    [service postDeviceId:token];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:APP_TITLE message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [self setActiveViewWithNotifications];
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
  //  NSLog(@"Orinetaion called");
    UIViewController * currentView = [[(UINavigationController *)self.navController viewControllers] lastObject];
    if ([currentView isKindOfClass:[VideoDownloadVC class]] || [currentView isKindOfClass:[BasicGameViewController class]] )
    {
        return UIInterfaceOrientationMaskLandscape;
        
        //return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(void)refreshBottomView
{
     UIViewController * currentView = [[(UINavigationController *)self.navController viewControllers] lastObject];
    for (id object in currentView.view.subviews)
    {
        if ([object isKindOfClass:[BottomView class]])
        {
            BottomView * bototmView = (BottomView *)object;
            [bototmView loadBottomViewControls];
            
            if ([currentView isKindOfClass:[VRVideosListVC class]])
            {
                [bototmView highlightIndex:1];
            }
            if ([currentView isKindOfClass:[PicturesListVC class]])
            {
                [bototmView highlightIndex:2];
            }
            if ([currentView isKindOfClass:[TwitterWallVC class]])
            {
                [bototmView highlightIndex:3];
            }
            if ([currentView isKindOfClass:[NotificationListVC class]])
            {
                [bototmView highlightIndex:4];
            }
            return;
        }
    }
}

//Common method for to set Active view when abs selected

-(void)setActiveViewWithNotifications
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:SB_ID_NOTIFICATIONS];
    _navController = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    _navController.navigationBarHidden = YES;
    [self.window setRootViewController:_navController];
}
@end
